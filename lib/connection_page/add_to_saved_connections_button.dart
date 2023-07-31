import 'package:flutter/material.dart';

import '../saved_connections.dart';
import '../transport_api/transport_objects/connection.dart';

class AddToSavedConnectionsButton extends StatefulWidget {
  final Connection connection;
  const AddToSavedConnectionsButton({super.key, required this.connection});

  @override
  State<AddToSavedConnectionsButton> createState() =>
      _AddToSavedConnectionsButtonState();
}

class _AddToSavedConnectionsButtonState
    extends State<AddToSavedConnectionsButton> {
  bool isActive = true;
  bool _isInit = true;

  @override
  Widget build(BuildContext context) {
    if (_isInit) {
      isActive = setIsActive(context);
      _isInit = false;
    }
    return ElevatedButton(
        onPressed: onPressed(context), child: Text(buttonText));
  }

  void Function()? onPressed(BuildContext context) {
    List<Connection>? savedConnections = SavedConnections.of(context);
    if (savedConnections == null || !isActive) {
      return null;
    }

    return () {
      setState(() {
        isActive = false;
      });
      ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
      if (savedConnections.stringContains(widget.connection)) {
        messenger.showSnackBar(
          SnackBar(content: Text('Bereits Gemerkt')),
        );
      } else {
        savedConnections.add(widget.connection);
        messenger.showSnackBar(
          SnackBar(content: Text('Merke Verbindung')),
        );
      }
    };
  }

  String get buttonText {
    return isActive ? 'Merke Verbindung' : 'Verbindung bereits gemerkt';
  }

  bool setIsActive(BuildContext context) {
    List<Connection>? connections = savedConnections(context);
    if (connections == null) return false;
    return !connections.stringContains(widget.connection);
  }

  List<Connection>? savedConnections(BuildContext context) =>
      SavedConnections.of(context);
}
