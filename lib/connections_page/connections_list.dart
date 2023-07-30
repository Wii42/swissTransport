import 'package:flutter/widgets.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

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
          !isSameDate(connection, previousConnection)) {
        list.add(connectionDate(connection));
      }
      list.add(ConnectionSneakPeek(connection: connection));
      previousConnection = connection;
    }
    return list;
  }

  bool isSameDate(Connection connection, Connection previousConnection) {
    DateTime? connectionDateTime = connection.from?.departure?.toLocal();
    DateTime? previousConnectionDateTime =
        previousConnection.from?.departure?.toLocal();
    if (connectionDateTime == null || previousConnectionDateTime == null) {
      return false;
    }
    DateTime connectionDate = DateTime(connectionDateTime.year,
        connectionDateTime.month, connectionDateTime.day);
    DateTime previousConnectionDate = DateTime(previousConnectionDateTime.year,
        previousConnectionDateTime.month, previousConnectionDateTime.day);
    return connectionDate == previousConnectionDate;
  }

  Widget connectionDate(Connection connection) {
    String text = '?';
    DateTime? departure = connection.from?.departure;
    if (departure != null) {
      String weekday;
      switch (departure.weekday) {
        case 1:
          weekday = "Montag";
          break;
        case 2:
          weekday = "Dienstag";
          break;
        case 3:
          weekday = "Mittwoch";
          break;
        case 4:
          weekday = "Donnerstag";
          break;
        case 5:
          weekday = "Freitag";
          break;
        case 6:
          weekday = "Samstag";
          break;
        case 7:
          weekday = "Sonntag";
          break;
        default:
          weekday = "?";
          break;
      }
      text = "$weekday ${departure.day}.${departure.month}.${departure.year}";
    }
    return Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 5),
        child: Text(text));
  }
}
