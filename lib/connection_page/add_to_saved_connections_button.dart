import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbb/db/app_database.dart';

import '../provider/saved_connections.dart';
import '../transport_api/transport_objects/connection.dart';

class AddToSavedConnectionsButton extends StatelessWidget {
  final Connection connection;

  const AddToSavedConnectionsButton({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    SavedConnections savedConnections = context.watch<SavedConnections>();
    bool connectionAlreadySaved =
        savedConnections.connections.contains(connection);
    if (connectionAlreadySaved) {
      return TextButton(
          onPressed: () {
            SavedConnection? savedConnection =
                savedConnections.getMatchingConnection(connection);
            if (savedConnection == null) {
              log("connection not found in saved connections");
              return;
            }
            savedConnections.remove(savedConnection);
          },
          child: Text("Reise nicht mehr merken"));
    }
    return ElevatedButton(
        onPressed: () => savedConnections.add(connection),
        child: Text('Merke Verbindung'));
  }

  void Function()? addConnection(
      BuildContext context, SavedConnections savedConnections) {
    return () {
      savedConnections.add(connection);
    };
  }
}
