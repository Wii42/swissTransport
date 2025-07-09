import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbb/db/app_database.dart';

import '../transport_api/transport_objects/connections.dart';
import '../transport_api/transport_objects/location.dart';

class LocationHistory extends ChangeNotifier {
  final List<LocationHistoryData> _locationHistory = [];

  final AppDatabase database;

  bool _isInitialized = false;

  final Map<Location, LocationHistoryData> _locationHistoryMap = {};

  DateTime _lastSorted = DateTime.fromMillisecondsSinceEpoch(0);

  static const Duration _sortDebounceDuration = Duration(minutes: 1);

  LocationHistory({required this.database});

  bool get isInitialized => _isInitialized;

  List<LocationHistoryData> get locationHistory {
    ensureInitialized();
    _sortIfNeeded();
    log('LocationHistory: Returning ${_locationHistory.map((f) => "${f.location.name}: score ${computeScore(f)}, count ${f.searchCount}")} items');
    return List.unmodifiable(_locationHistory);
  }

  Future<List<LocationHistoryData>> getAsync() async {
    await ensureInitialized();
    _sortIfNeeded();
    return List.unmodifiable(_locationHistory);
  }

  Future<void> add(Location location) async {
    await ensureInitialized();
    LocationHistoryData historyData =
        await database.addLocationHistory(location);
    _locationHistory.add(historyData);
    _sortByScore();
    _locationHistoryMap[location] = historyData;
    notifyListeners();
  }

  Future<int> incrementSearchCount(
      LocationHistoryData locationHistoryData) async {
    await ensureInitialized();
    assert(_locationHistory.contains(locationHistoryData),
        'LocationHistoryData must be in the history to increment search count');
    DateTime now = DateTime.now();
    LocationHistoryData newData = locationHistoryData.copyWith(
        searchCount: locationHistoryData.searchCount + 1, lastSearched: now);
    _locationHistory.remove(locationHistoryData);
    _locationHistory.add(newData);
    _sortByScore();
    _locationHistoryMap[locationHistoryData.location] = newData;
    notifyListeners();
    return database.incrementLocationHistoryCount(locationHistoryData,
        lastSearched: now);
  }

  Future<int> remove(LocationHistoryData locationHistoryData) async {
    await ensureInitialized();
    _locationHistory.remove(locationHistoryData);
    _locationHistoryMap.remove(locationHistoryData.location);
    notifyListeners();
    return database.removeLocationHistory(locationHistoryData);
  }

  Future<void> registerLocation(Location location) async {
    await ensureInitialized();
    if (_locationHistoryMap.containsKey(location)) {
      await incrementSearchCount(_locationHistoryMap[location]!);
    } else {
      await add(location);
    }
  }

  Future<void> clear() async {
    _locationHistory.clear();
    _locationHistoryMap.clear();
    notifyListeners();
    await database.clearLocationHistory();
  }

  /// Score of how relevant a location suggestion is.
  /// The score depends on the recency (last search) and the frequency (number of searches).
  static double computeScore(LocationHistoryData locationHistoryData) {
    // recency Score: number of days since last search
    double recencyInDays = DateTime.now()
            .difference(locationHistoryData.lastSearched)
            .inMicroseconds /
        Duration.microsecondsPerDay;
    if (recencyInDays == 0) return double.infinity;
    double recencyScore = 1 / (recencyInDays + 1);

    // frequency Score: number of searches
    int frequencyScore = locationHistoryData.searchCount;
    return frequencyScore * recencyScore;
  }

  Future<void> ensureInitialized() async {
    if (_isInitialized) return;
    List<LocationHistoryData> loadedLocations =
        await database.getAllLocationHistory();
    _locationHistory.addAll(loadedLocations);
    _sortByScore();
    _locationHistoryMap.addEntries(loadedLocations.map(
      (data) => MapEntry(data.location, data),
    ));
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> saveEndpointsOfConnections(Connections connections) async {
    Location? from = connections.from;
    Location? to = connections.to;

    if (from != null) {
      await registerLocation(from);
    }
    if (to != null) {
      await registerLocation(to);
    }
  }

  static Future<void> saveEndpointsOfConnectionsRequest(
      BuildContext context, Future<Connections> connectionsRequest) async {
    LocationHistory locationHistory =
        Provider.of<LocationHistory>(context, listen: false);
    Connections connections = await connectionsRequest;
    await locationHistory.saveEndpointsOfConnections(connections);
  }

  void _sortByScore() {
    _locationHistory.sort((a, b) => computeScore(b)
        .compareTo(computeScore(a))); // Sort by score, descending
    _lastSorted = DateTime.timestamp();
  }

  void _sortIfNeeded() {
    if (DateTime.timestamp().difference(_lastSorted) > _sortDebounceDuration) {
      _sortByScore();
    }
  }
}
