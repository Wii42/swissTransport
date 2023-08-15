import 'package:sbb/transport_api/helper/date_time_to_string_extension.dart';

abstract class DepartureArrival {
  static const String platformKey = 'platform', sectionKey = 'platformSection';

  String? get departurePlatformString;

  String? get departurePlatform =>
      _departurePlatformSection(departurePlatformString)[platformKey];

  String? get departurePlatformSection =>
      _departurePlatformSection(departurePlatformString)[sectionKey];

  DateTime? get departureTime;

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

  Map<String, String> _departurePlatformSection(String? platform) {
    Map<String, String> map = {};

    if (platform == null) {
      return map;
    }

    RegExp pattern = RegExp(r'^[0-9]+[a-zA-Z]');
    if (!pattern.hasMatch(platform)) {
      map[platformKey] = platform;
      return map;
    }

    int split = pattern.firstMatch(platform)!.end - 1;

    map[platformKey] = platform.substring(0, split);
    map[sectionKey] = platform.substring(split);
    return map;
  }
}
