import 'package:json_annotation/json_annotation.dart';

class DurationParseConverter implements JsonConverter<Duration, String> {
  const DurationParseConverter();
  @override
  Duration fromJson(String json) => parseDuration(json);

  @override
  String toJson(Duration object) => stringInJson(object);

  Duration parseDuration(String string) {
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

  String stringInJson(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitDays = twoDigits(duration.inDays);
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigitDays}d$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }
}
