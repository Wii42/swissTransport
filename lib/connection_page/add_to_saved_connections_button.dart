import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/saved_connections.dart';
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
    SavedConnections? savedConnections = context.watch<SavedConnections?>();
    if (savedConnections == null || !isActive) {
      return null;
    }

    return () {
      setState(() {
        isActive = false;
      });

      if (savedConnections.list.stringContains(widget.connection)) {
        ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          const SnackBar(content: Text('Bereits Gemerkt')),
        );
      } else {
        savedConnections.add(widget.connection);
      }
    };
  }

  String get buttonText {
    return isActive ? 'Merke Verbindung' : 'Verbindung gemerkt';
  }

  bool setIsActive(BuildContext context) {
    List<Connection>? connections = savedConnections(context)?.list;
    if (connections == null) return false;
    return !connections.stringContains(widget.connection);
  }

  SavedConnections? savedConnections(BuildContext context) =>
      context.watch<SavedConnections?>();
}
