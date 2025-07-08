import 'package:sbb/transport_api/helper/date_time_to_string_extension.dart';

abstract class DepartureArrival implements Comparable<DepartureArrival> {
  static const String platformKey = 'platform', sectionKey = 'platformSection';

  String? get departurePlatformData;

  String? get departurePlatform =>
      _departurePlatformSection(departurePlatformData)[platformKey];

  String? get departurePlatformSection =>
      _departurePlatformSection(departurePlatformData)[sectionKey];

  bool hasDeparturePlatformChanged() {
    if (departurePlatformData == null) {
      return false;
    }
    return departurePlatformData!.endsWith('!');
  }

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
    if (hasDeparturePlatformChanged()) {
      platform = platform.substring(0, platform.length - 1);
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

  @override
  int compareTo(DepartureArrival other) {
    DateTime? thisTime = departureTime;
    DateTime? otherTime = other.departureTime;

    if (thisTime != null && otherTime != null) {
      return thisTime.compareTo(otherTime);
    }
    if (thisTime != null) {
      return 1;
    }

    if (otherTime != null) {
      return -1;
    }

    return 0;
  }
}
