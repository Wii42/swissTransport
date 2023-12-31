import 'package:flutter/material.dart';

import 'package:sbb/ui/custom_page.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';

import '../ui/api_user.dart';
import 'from_to_widget.dart';
import 'connections_list.dart';

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
      return const Center(child: Text("Keine Verbindungen gefunden"));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FromToInfo(connections: connections),
        Expanded(
            child: ConnectionsList(
          initialConnections: connections.connections!,
        ))
      ],
    );
  }

  static Widget inRoute([dynamic request]) =>
      ConnectionsPage(connectionsRequest: request);
}
