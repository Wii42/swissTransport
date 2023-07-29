import 'package:flutter/material.dart';
import 'package:sbb/connection_sneak_peek.dart';
import 'package:sbb/custom_page.dart';
import 'package:sbb/from_to_info.dart';
import 'package:sbb/padded_card.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';

import 'api_user.dart';

class ConnectionsPage extends StatelessWidget {
  final Future<Connections> connectionsRequest;

  const ConnectionsPage({super.key, required this.connectionsRequest});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: 'Verbindungen',
      body: ApiUser<Connections>(
          apiCall: connectionsRequest, displayResponse: display),
    );
  }

  Widget display(Connections connections) {
    List<Connection>? connectionList = connections.connections;
    if (connectionList == null || connectionList.isEmpty) {
      return const Center(child: Text("No connections found"));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FromToInfo(connections: connections),
        Expanded(
          child: ListView(
            children: [
              for (Connection connection in connections.connections!)
                ConnectionSneakPeek(connection: connection)
            ],
          ),
        )
      ],
    );
  }

  static Widget inRoute([dynamic request]) =>
      ConnectionsPage(connectionsRequest: request);
}
