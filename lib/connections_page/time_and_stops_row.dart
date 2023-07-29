import 'package:flutter/material.dart';

import '../transport_api/transport_objects/connection.dart';

class TimeAndStopsRow extends StatelessWidget {
  final Connection connection;

  const TimeAndStopsRow({super.key, required this.connection});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (connection.hasWalkingTime) walkingIndicator(),
        Text(connection.departureTimeString ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const Expanded(child: Divider(thickness: 2)),
        Text(connection.arrivalTimeString ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold))
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
        SizedBox(width:10)
      ],
    );
  }
}
