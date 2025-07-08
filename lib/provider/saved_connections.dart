import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sbb/db/app_database.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

class SavedConnections extends ChangeNotifier {
  static const String savedConnectionsKey = 'savedConnections';

  final SplayTreeSet<SavedConnection> _savedConnections =
      SplayTreeSet((a, b) => a.connection.compareTo(b.connection));
  final AppDatabase database;

  bool _isInitialized = false;

  SavedConnections({required this.database});

  /// Returns a copy of the list of saved Connections.
  /// Changing this list will have no effect on SavedConnections
  List<SavedConnection> get savedConnections {
    if (!_isInitialized) {
      _loadAll();
    }
    return List.unmodifiable(_savedConnections);
  }

  /// Convenience getter to access the connections directly.
  List<Connection> get connections =>
      List.unmodifiable(savedConnections.map((e) => e.connection));

  Future<void> add(Connection connection) async {
    SavedConnection savedConnection = await _addToDatabase(connection);
    _savedConnections.add(savedConnection);
    notifyListeners();
  }

  bool remove(SavedConnection connection) {
    bool successful = _savedConnections.remove(connection);
    notifyListeners();
    database.removeSavedConnection(connection);
    return successful;
  }

  Future<void> _loadAll() async {
    if (_isInitialized) return;
    List<SavedConnection> loadedConnections =
        await database.getAllSavedConnections();
    _savedConnections.addAll(loadedConnections);
    _isInitialized = true;
    notifyListeners();
  }

  Future<SavedConnection> _addToDatabase(Connection connection) async {
    if (!_isInitialized) {
      await _loadAll();
    }
    return database.addSavedConnection(connection);
  }

  Future<int> clear() async {
    _savedConnections.clear();
    int rowsAffected = await database.clearSavedConnections();
    notifyListeners();
    return rowsAffected;
  }
}
