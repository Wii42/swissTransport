import 'package:flutter/widgets.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

import '../ui/date_badge.dart';
import 'connection_sneak_peek.dart';

class ConnectionsList extends StatefulWidget {
  final List<Connection> initialConnections;
  const ConnectionsList({super.key, required this.initialConnections});

  @override
  State<StatefulWidget> createState() => _ConnectionsListState();
}

class _ConnectionsListState extends State<ConnectionsList> {
  late List<Connection> connections;

  @override
  void initState() {
    super.initState();
    connections = widget.initialConnections;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: listElements(),
    );
  }

  List<Widget> listElements() {
    List<Widget> list = [];

    Connection? previousConnection;

    for (Connection connection in connections) {
      if (previousConnection == null ||
          !connection.isSameDate(previousConnection)) {
        list.add(DateBadge(connection: connection));
      }
      list.add(ConnectionSneakPeek(connection: connection));
      previousConnection = connection;
    }
    return list;
  }
}
