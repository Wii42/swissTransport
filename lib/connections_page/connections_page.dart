import 'package:flutter/material.dart';
import 'package:sbb/connections_page/top_widget.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';
import 'package:sbb/ui/custom_page.dart';

import '../ui/api_user.dart';
import 'connections_list.dart';

class ConnectionsPage extends StatelessWidget with WidgetWithTitle {
  final Future<Connections> connectionsRequest;

  @override
  final String title = 'Verbindungen';
  @override
  final IconData icon = Icons.multiple_stop;

  const ConnectionsPage({super.key, required this.connectionsRequest});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: title,
      body: ApiUser<Connections>(
          apiCall: connectionsRequest, displayResponse: display),
    );
  }

  Widget display(BuildContext context, Connections connections) {
    List<Connection>? connectionList = connections.connections;
    if ((connectionList == null || connectionList.isEmpty) &&
        connections.from == null &&
        connections.to == null) {
      return const Center(child: Text("Keine Verbindungen gefunden"));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TopWidget(
          connections: connections,
          initiallyExpanded: (connectionList == null || connectionList.isEmpty),
        ),
        Expanded(
            child: ConnectionsList(
          initialConnections: connections.connections!,
        ))
      ],
    );
  }

  factory ConnectionsPage.inRoute([dynamic request]) =>
      ConnectionsPage(connectionsRequest: request);
}
