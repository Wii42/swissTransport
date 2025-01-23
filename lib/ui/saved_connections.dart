import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedConnections extends ChangeNotifier {
  static const String savedConnectionsKey = 'savedConnections';

  late final List<Connection> _savedConnections;
  final SharedPreferences sharedPrefs;

  SavedConnections({required this.sharedPrefs}) {
    _savedConnections = _loadFromSharedPreferencesIfPossible();
  }

  List<Connection> _loadFromSharedPreferencesIfPossible() {
    if (sharedPrefs.containsKey(savedConnectionsKey)) {
      return sharedPrefs
          .getStringList(savedConnectionsKey)!
          .map<Connection>(
              (String string) => Connection.fromJson(jsonDecode(string)))
          .toList();
    }
    return [];
  }

  void _saveToSharedPreferences() {
    sharedPrefs.setStringList(
        savedConnectionsKey,
        _savedConnections
            .map<String>(
                (Connection connection) => jsonEncode(connection.toJson()))
            .toList());
  }

  /// Returns a copy of the list of saved Connections.
  /// Changing this list will have no effect on SavedConnections
  List<Connection> get list => _savedConnections.toList();

  void add(Connection connection) {
    _savedConnections.add(connection);
    _saveToSharedPreferences();
  }

  bool remove(Connection connection) {
    bool successful = _savedConnections.remove(connection);
    _saveToSharedPreferences();
    return successful;
  }
}
