import 'package:flutter/material.dart';

import '../transport_api/enums/weekday.dart';
import '../transport_api/transport_objects/connection.dart';

class DateBadge extends StatelessWidget {
  const DateBadge({
    super.key,
    required this.connection,
  });

  final Connection connection;

  @override
  Widget build(BuildContext context) {
    String text = connectionDateString(connection);
    return Padding(
        padding:
        const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 5),
        child: Text(text));
  }

  static String connectionDateString(Connection connection) {
    String text = '?';
    DateTime? departure = connection.departureTime;
    if (departure != null) {
      Weekday weekday = Weekday.byNrOfDay(departure.weekday);
      text =
      "${weekday.fullName} ${departure.day}.${departure.month}.${departure.year}";
    }
    return text;
  }
}