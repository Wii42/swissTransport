import 'package:flutter/material.dart';
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
              const Expanded(child: Divider(thickness: 2)),
              Text(connection.arrivalTimeString ?? "")
            ],
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 5,
            children: [
              Text("Gl. ${connection.departurePlatform}"),
              //const Spacer(),
              Text(durationString(connection.duration))
            ],
          )
        ],
      ),
    );
  }

  String durationString(Duration? duration) {
    if (duration == null) {
      return "? min";
    }
    int hours = duration.inHours;
    int mins = duration.inMinutes.remainder(60);

    String string = '';
    if (hours != 0) {
      string += "$hours h ";
    }
    string += "$mins min";

    return string;
  }
}
