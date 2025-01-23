import 'package:json_annotation/json_annotation.dart';

class DurationInSecondsConverter implements JsonConverter<Duration, int> {
  const DurationInSecondsConverter();
  @override
  Duration fromJson(int json) {
    return Duration(seconds: json);
  }

  @override
  int toJson(Duration object) {
    return object.inSeconds;
  }
}