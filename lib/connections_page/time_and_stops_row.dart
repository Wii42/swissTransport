import 'package:flutter/material.dart';
import 'package:sbb/connections_page/stops_indicator.dart';

import '../transport_api/transport_objects/connection.dart';
import '../transport_api/transport_objects/section.dart';

class TimeAndStopsRow extends StatelessWidget {
  final Connection connection;

  const TimeAndStopsRow({super.key, required this.connection});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (connection.isStartingWithWalk)
          walkingIndicator(connection.firstSection,
              suffix: const SizedBox(width: 10)),
        departureTimeText(connection),
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                child: StopsIndicator(connection: connection))),
        arrivalTimeText(connection)
      ],
    );
  }

  static Widget walkingIndicator(Section? section, {Widget? suffix}) {
    return Row(
      children: [
        const Icon(
          Icons.directions_walk,
          size: 13,
        ),
        Text("${section?.walk?.duration.inMinutes ?? 0}'"),
        if (suffix != null) suffix,
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
