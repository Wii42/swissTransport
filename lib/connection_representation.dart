import 'package:flutter/material.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

import 'connections_page/time_and_stops_row.dart';
import 'connections_page/transport_type_and_direction_row.dart';
import 'connections_page/travel_duration_row.dart';

class ConnectionRepresentation extends StatelessWidget {
  const ConnectionRepresentation({
    super.key,
    required this.connection,
  });

  final Connection connection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TransportTypeAndDurationRow(connection: connection),
        TimeAndStopsRow(connection: connection),
        TravelDurationRow(connection: connection),
      ],
    );
  }
}