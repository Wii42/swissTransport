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
        (connection.departurePlatformString != null &&
                connection.departurePlatformString != '')
            ? Text("Gl. ${connection.departurePlatformString}")
            : const Text(''),
        if (connection.hasCapacityInfo) capacityInfo(),
        Text(durationString(connection.duration)),
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

  Widget capacityInfo() {
    return Row(
      children: [
        if (connection.capacity1st != null)
          Text('1: ${connection.capacity1st}'),
        if (connection.capacity2nd != null)
          Text('2: ${connection.capacity2nd}'),
      ],
    );
  }
}
