import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbb/generic_ui_elements/padded_clickable_card.dart';
import 'package:sbb/helper/go_subroute_extension.dart';
import 'package:sbb/provider/saved_connections.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:sbb/ui/connection_representation.dart';
import 'package:sbb/ui/from_to_text.dart';
import 'package:sbb/ui/routes.dart';

import 'date_badge.dart';

class SavedConnectionsWidget extends StatefulWidget {
  const SavedConnectionsWidget({super.key});

  @override
  State<SavedConnectionsWidget> createState() => _SavedConnectionsWidgetState();
}

class _SavedConnectionsWidgetState extends State<SavedConnectionsWidget> {
  @override
  Widget build(BuildContext context) {
    SavedConnections? savedConnections = context.watch<SavedConnections?>();

    if (savedConnections == null || savedConnections.list.isEmpty) {
      return const Center(child: Text("Keine gespeicherten Reisen vorhanden"));
    }
    return Center(
      child: ListView(children: listElements(context, savedConnections)),
    );
  }

  PaddedClickableCard clickableConnectionSneakPeek(BuildContext context,
      Connection connection, SavedConnections savedConnections) {
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
                savedConnections.remove(connection);
                setState(() {});
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
    List<Connection> connections = savedConnections.list;
    connections.sort((a, b) => a.compareTo(b));

    List<Widget> list = [];

    Connection? previousConnection;

    for (Connection connection in connections) {
      if (previousConnection == null ||
          !connection.isSameDate(previousConnection)) {
        list.add(DateBadge(connection: connection));
      }
      list.add(
          clickableConnectionSneakPeek(context, connection, savedConnections));
      previousConnection = connection;
    }
    return list;
  }
}
