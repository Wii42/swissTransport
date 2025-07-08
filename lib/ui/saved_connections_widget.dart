import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbb/generic_ui_elements/padded_clickable_card.dart';
import 'package:sbb/helper/go_subroute_extension.dart';
import 'package:sbb/provider/saved_connections.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:sbb/ui/connection_representation.dart';
import 'package:sbb/ui/from_to_text.dart';
import 'package:sbb/ui/routes.dart';

import '../db/app_database.dart';
import 'date_badge.dart';

class SavedConnectionsWidget extends StatelessWidget {
  const SavedConnectionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SavedConnections? savedConnections = context.watch<SavedConnections?>();

    if (savedConnections == null || savedConnections.savedConnections.isEmpty) {
      return const Center(child: Text("Keine gespeicherten Reisen vorhanden"));
    }
    return Center(
      child: ListView(children: listElements(context, savedConnections)),
    );
  }

  PaddedClickableCard clickableConnectionSneakPeek(BuildContext context,
      SavedConnection savedConnection, SavedConnections savedConnections) {
    Connection connection = savedConnection.connection;
    return PaddedClickableCard(
      onTap: () =>
          context.pushSubRoute(Routes.connection.string, extra: connection),
      //Routes.connection.push(context, params: connection),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FromToText(
              from: connection.from?.station, to: connection.to?.station),
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
                savedConnections.remove(savedConnection);
              },
              child: const Text('Reise nicht mehr speichern'),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> listElements(
      BuildContext context, SavedConnections savedConnections) {
    List<SavedConnection> connections = savedConnections.savedConnections;

    List<Widget> list = [];

    Connection? previousConnection;

    for (SavedConnection savedConnection in connections) {
      final Connection connection = savedConnection.connection;
      if (previousConnection == null ||
          !connection.isSameDate(previousConnection)) {
        list.add(DateBadge(connection: connection));
      }
      list.add(clickableConnectionSneakPeek(
          context, savedConnection, savedConnections));
      previousConnection = connection;
    }
    return list;
  }
}
