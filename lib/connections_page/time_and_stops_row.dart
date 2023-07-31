import 'package:flutter/material.dart';
import 'package:sbb/connections_page/stops_indicator.dart';

import '../transport_api/transport_objects/connection.dart';

class TimeAndStopsRow extends StatelessWidget {
  final Connection connection;

  const TimeAndStopsRow({super.key, required this.connection});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (connection.isStartingWithWalk) walkingIndicator(),
        departureTimeText(connection),
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                child: StopsIndicator(connection: connection))),
        arrivalTimeText(connection)
      ],
    );
  }

  Widget walkingIndicator() {
    int walkingMins = connection.totalWalkingSecs! ~/ 60;
    return Row(
      children: [
        const Icon(
          Icons.directions_walk,
          size: 13,
        ),
        Text("$walkingMins'"),
        const SizedBox(width: 10)
      ],
    );
  }

  static Widget departureTimeText(Connection connection) {
    return Text(connection.departureTimeString ?? "",
        style: const TextStyle(fontWeight: FontWeight.bold));
  }

  static Widget arrivalTimeText(Connection connection) {
    return Text(connection.arrivalTimeString ?? "",
        style: const TextStyle(fontWeight: FontWeight.bold));
  }
}
