import 'package:sbb/transport_api/helper/date_time_to_string_extension.dart';

abstract class DepartureArrival {
  DateTime? get departureTime;

  String? get departurePlatform;

  String? get departureTimeString {
    DateTime? departure = departureTime;
    if (departure == null) {
      return null;
    }
    return departure.toLocal().localTimeString;
  }

  DateTime? get arrivalTime;

  String? get arrivalTimeString {
    DateTime? arrival = arrivalTime;
    if (arrival == null) {
      return null;
    }
    return arrival.toLocal().localTimeString;
  }
}
