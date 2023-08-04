import 'json_coding/walk_coder.dart';

class Walk {
  static final WalkCoder jsonCoder = WalkCoder();

  /// walking duration in seconds
  int? duration;

  Walk({this.duration});

  factory Walk.fromJson(Map<String, dynamic> map) => jsonCoder.fromJson(map);

  static Walk? maybeFromJson(Map<String, dynamic>? map) =>
      jsonCoder.maybeFromJson(map);

  static List<Walk> multipleFromJson(List<dynamic> list) =>
      jsonCoder.multipleFromJson(list);

  static List<Walk>? maybeMultipleFromJson(List<dynamic>? list) =>
      jsonCoder.maybeMultipleFromJson(list);

  Map<String, dynamic> asJson() => jsonCoder.asJson(this);

  static List<Map<String, dynamic>> multipleAsJson(List<Walk> list) =>
      jsonCoder.multipleAsJson(list);

  static List<Map<String, dynamic>>? maybeMultipleAsJson(List<Walk>? list) =>
      jsonCoder.maybeMultipleAsJson(list);
}
