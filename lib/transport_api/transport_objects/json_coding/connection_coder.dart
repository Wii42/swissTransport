import 'package:sbb/transport_api/transport_objects/json_coding/json_coder.dart';

import '../connection.dart';
import '../section.dart';
import '../stop.dart';
import '../service.dart';

class ConnectionCoder extends JsonCoder<Connection> {
  static const String fromKey = 'from',
      toKey = 'to',
      durationKey = 'duration',
      serviceKey = 'service',
      productsKey = 'products',
      capacity1stKey = 'capacity1st',
      capacity2ndKey = 'capacity2nd',
      sectionsKey = 'sections';

  @override
  Connection fromJson(Map<String, dynamic> map) {
    return Connection(
      from: Stop.maybeFromJson(map[fromKey]),
      to: Stop.maybeFromJson(map[toKey]),
      duration: tryParseDuration(map[durationKey]),
      service: Service.maybeFromJson(map[serviceKey]),
      products: map[productsKey] != null
          ? [for (String product in map[productsKey]) product]
          : null,
      capacity1st: map[capacity1stKey],
      capacity2nd: map[capacity2ndKey],
      sections: Section.maybeMultipleFromJson(map[sectionsKey]),
    );
  }

  @override
  Map<String, dynamic> asJson(Connection object) {
    return {
      fromKey: object.from?.asJson(),
      toKey: object.to?.asJson(),
      durationKey: tryStringInJson(object.duration),
      serviceKey: object.service?.asJson(),
      productsKey: object.products,
      capacity1stKey: object.capacity1st,
      capacity2ndKey: object.capacity2nd,
      sectionsKey: Section.maybeMultipleAsJson(object.sections),
    };
  }

  static Duration? tryParseDuration(String? string) {
    if (string == null) {
      return null;
    }
    try {
      return parseDuration(string);
    } on Exception {
      return null;
    }
  }

  static Duration parseDuration(String string) {
    List<String> daySplit = string.split('d');
    assert(daySplit.length == 2);
    int days = int.parse(daySplit[0]);

    String time = daySplit[1];
    List<String> timeSplit = time.split(':');
    assert(timeSplit.length == 3);
    int hours = int.parse(timeSplit[0]);
    int minutes = int.parse(timeSplit[1]);
    int seconds = int.parse(timeSplit[2]);
    return Duration(
        days: days, hours: hours, minutes: minutes, seconds: seconds);
  }

  static String? tryStringInJson(Duration? duration) {
    if (duration == null) {
      return null;
    }
    return stringInJson(duration);
  }

  static String stringInJson(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitDays = twoDigits(duration.inDays);
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    print("${twoDigitDays}d$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds");
    return "${twoDigitDays}d$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }
}
