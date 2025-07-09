import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../transport_api/transport_objects/location.dart';

class TouchFahrplanTiles extends ChangeNotifier {
  static const _manualTiles = 'touchFahrplanTiles';
  static const _historyTileRowsKey = 'historyTileRows';
  final List<StationTile> _stationTiles = [];

  int _historyTileRows = 1;

  bool _isInitialized = false;
  final SharedPreferences _prefs;

  TouchFahrplanTiles(this._prefs);

  List<StationTile> get stationTiles {
    ensureInitialized();
    return List.unmodifiable(_stationTiles);
  }

  int get historyTileRows {
    ensureInitialized();
    return _historyTileRows;
  }

  void add(StationTile tile) async {
    _stationTiles.add(tile);
    _saveTiles();
    notifyListeners();
  }

  void remove(StationTile tile) async {
    _stationTiles.remove(tile);
    _saveTiles();
    notifyListeners();
  }

  void setHistoryTileRows(int rows) async {
    _historyTileRows = rows;
    _saveHistoryTileRows();
    notifyListeners();
  }

  void ensureInitialized() async {
    if (_isInitialized) return;

    // Load tiles from shared preferences
    final List<String> jsonList = _prefs.getStringList(_manualTiles) ?? [];
    _stationTiles
        .addAll(jsonList.map((json) => StationTile.fromJson(jsonDecode(json))));
    _historyTileRows = _prefs.getInt(_historyTileRowsKey) ?? _historyTileRows;
    _isInitialized = true;
  }

  Future<bool> _saveTiles() async {
    final List<String> jsonList =
        _stationTiles.map((tile) => jsonEncode(tile.toJson())).toList();
    return _prefs.setStringList(_manualTiles, jsonList);
  }

  Future<bool> _saveHistoryTileRows() async {
    return _prefs.setInt(_historyTileRowsKey, _historyTileRows);
  }
}

class StationTile {
  final Location location;
  int crossAxisCellCount;
  int mainAxisCellCount;

  StationTile({
    required this.location,
    this.crossAxisCellCount = 1,
    this.mainAxisCellCount = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'crossAxisCellCount': crossAxisCellCount,
      'mainAxisCellCount': mainAxisCellCount,
    };
  }

  factory StationTile.fromJson(Map<String, dynamic> json) {
    return StationTile(
      location: Location.fromJson(json['location']),
      crossAxisCellCount: json['crossAxisCellCount'] ?? 1,
      mainAxisCellCount: json['mainAxisCellCount'] ?? 1,
    );
  }
}
