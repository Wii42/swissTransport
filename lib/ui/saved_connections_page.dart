import 'package:flutter/material.dart';
import 'package:sbb/ui/connection_representation.dart';
import 'package:sbb/ui/from_to_text.dart';
import 'package:sbb/generic_ui_elements/padded_clickable_card.dart';
import 'package:sbb/ui/routes.dart';
import 'package:sbb/ui/saved_connections.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

class SavedConnectionsPage extends StatefulWidget {
  const SavedConnectionsPage({super.key});

  @override
  State<SavedConnectionsPage> createState() => _SavedConnectionsPageState();
}

class _SavedConnectionsPageState extends State<SavedConnectionsPage> {
  @override
  Widget build(BuildContext context) {
    SavedConnections? savedConnections = SavedConnections.of(context);
    if (savedConnections == null || savedConnections.list.isEmpty) {
      return const Center(child: Text("Keine gespeicherten Reisen vorhanden"));
    }
    return Center(
      child: ListView(
        children: [
          for (Connection connection in savedConnections.list)
            PaddedClickableCard(
              onTap: () => Routes.connection.push(context, params: connection),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FromToText(
                      from: connection.from?.station,
                      to: connection.to?.station),
                  ConnectionRepresentation(
                    connection: connection,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        savedConnections.remove(connection);
                        setState(() {});
                      },
                      child: const Text('Reise nicht mehr speichern'),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
