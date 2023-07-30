import 'package:flutter/material.dart';
import 'package:sbb/connections_page/time_and_stops_row.dart';
import 'package:sbb/connections_page/travel_duration_row.dart';
import 'package:sbb/generic_ui_elements/padded_card.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

import '../connections_page/connections_list.dart';
import '../from_to_text.dart';

class FromToWidget extends StatelessWidget {
  final Connection connection;
  const FromToWidget({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FromToText(
              from: connection.from?.station, to: connection.to?.station),
          Text(
              "${ConnectionsList.connectionDateString(connection)}, ${TravelDurationRow.durationString(connection.duration)}"),
          TimeAndStopsRow(connection: connection)
        ],
      ),
    );
  }
}
