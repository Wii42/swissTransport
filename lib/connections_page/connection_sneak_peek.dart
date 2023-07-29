import 'package:flutter/material.dart';
import 'package:sbb/connections_page/time_and_stops_row.dart';
import 'package:sbb/connections_page/transport_type_and_direction_row.dart';
import 'package:sbb/connections_page/travel_duratiion_row.dart';
import 'package:sbb/padded_card.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

class ConnectionSneakPeek extends StatelessWidget {
  final Connection connection;
  const ConnectionSneakPeek({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TransportTypeAndDurationRow(connection: connection),
          TimeAndStopsRow(connection: connection),
          TravelDurationRow(connection: connection),
        ],
      ),
    );
  }
}
