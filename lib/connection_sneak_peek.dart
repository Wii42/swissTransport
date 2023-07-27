import 'package:flutter/material.dart';
import 'package:sbb/transport_api/helper/date_time_to_string_extension.dart';
import 'package:sbb/padded_card.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:sbb/transport_api/transport_objects/section.dart';

class ConnectionSneakPeek extends StatelessWidget {
  final Connection connection;
  const ConnectionSneakPeek({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 5,
            children: [
              Text(
                connection.transportProduct ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Richtung ${connection.direction}"),
            ],
          ),
          Row(
            children: [
              Text(connection.departureTimeString ?? ""),
              const Expanded(child: Divider()),
              Text(connection.arrivalTimeString ?? "")
            ],
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 5,
            children: [
              Text("Gl. ${connection.departurePlatform}"),
              //const Spacer(),
              Text("${connection.duration!.inMinutes.toString()} min")
            ],
          )
        ],
      ),
    );
  }
}
