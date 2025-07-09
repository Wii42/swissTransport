import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbb/db/app_database.dart';

import '../transport_api/transport_objects/connections.dart';
import '../transport_api/transport_objects/location.dart';

class LocationHistory extends ChangeNotifier {
  final SplayTreeSet<LocationHistoryData> _locationHistory = SplayTreeSet((a,
          b) =>
      computeScore(b).compareTo(computeScore(a))); // Sort by score, descending

  final AppDatabase database;

  bool _isInitialized = false;

  final Map<Location, LocationHistoryData> _locationHistoryMap = {};

  LocationHistory({required this.database});

  bool get isInitialized => _isInitialized;

  List<LocationHistoryData> get locationHistory {
    ensureInitialized();
    return List.unmodifiable(_locationHistory);
  }

  Future<List<LocationHistoryData>> getAsync() async {
    await ensureInitialized();
    return List.unmodifiable(_locationHistory);
  }

  Future<void> add(Location location) async {
    await ensureInitialized();
    LocationHistoryData historyData =
        await database.addLocationHistory(location);
    _locationHistory.add(historyData);
    _locationHistoryMap[location] = historyData;
    notifyListeners();
  }

  Future<int> incrementSearchCount(
      LocationHistoryData locationHistoryData) async {
    await ensureInitialized();
    assert(_locationHistory.contains(locationHistoryData),
        'LocationHistoryData must be in the history to increment search count');
    DateTime now = DateTime.now();
    _locationHistory.remove(locationHistoryData);
    _locationHistory.add(locationHistoryData.copyWith(
        searchCount: locationHistoryData.searchCount + 1, lastSearched: now));
    notifyListeners();
    return database.incrementLocationHistoryCount(locationHistoryData,
        lastSearched: now);
  }

  Future<int> remove(LocationHistoryData locationHistoryData) async {
    await ensureInitialized();
    _locationHistory.remove(locationHistoryData);
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

  /// Score of how relevant a location suggestion is.
  /// The score depends on the recency (last search) and the frequency (number of searches).
  static double computeScore(LocationHistoryData locationHistoryData) {
    // recency Score: number of days since last search
    double recencyScore = DateTime.now()
            .difference(locationHistoryData.lastSearched)
            .inMicroseconds /
        Duration.microsecondsPerDay;
    if (recencyScore == 0) return double.infinity;

    // frequency Score: number of searches
    int frequencyScore = locationHistoryData.searchCount;
    return frequencyScore / recencyScore;
  }

  Future<void> ensureInitialized() async {
    if (_isInitialized) return;
    List<LocationHistoryData> loadedLocations =
        await database.getAllLocationHistory();
    _locationHistory.addAll(loadedLocations);
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
}
