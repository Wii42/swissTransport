import 'package:flutter/material.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

class TravelDurationRow extends StatelessWidget {
  final Connection connection;

  const TravelDurationRow({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 5,
      children: [
        (connection.departurePlatform != null &&
                connection.departurePlatform != '')
            ? Text("Gl. ${connection.departurePlatform}")
            : const Text(''),
        Text(durationString(connection.duration))
      ],
    );
  }

  static String durationString(Duration? duration) {
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
