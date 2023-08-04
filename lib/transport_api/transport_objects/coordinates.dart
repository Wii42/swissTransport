import 'json_coding/coordinates_coder.dart';

class Coordinates {
  static final CoordinatesCoder jsonCoder = CoordinatesCoder();

  ///The type of the given coordinate
  String? type;

  ///Latitude
  double? x;

  ///Longitude
  double? y;

  Coordinates({this.type, this.x, this.y});

  factory Coordinates.fromJson(Map<String, dynamic> map) =>
      jsonCoder.fromJson(map);

  static Coordinates? maybeFromJson(Map<String, dynamic>? map) =>
      jsonCoder.maybeFromJson(map);

  static List<Coordinates> multipleFromJson(List<dynamic> list) =>
      jsonCoder.multipleFromJson(list);

  static List<Coordinates>? maybeMultipleFromJson(List<dynamic>? list) =>
      jsonCoder.maybeMultipleFromJson(list);

  Map<String, dynamic> asJson() => jsonCoder.asJson(this);

  static List<Map<String, dynamic>> multipleAsJson(List<Coordinates> list) =>
      jsonCoder.multipleAsJson(list);

  static List<Map<String, dynamic>>? maybeMultipleAsJson(
          List<Coordinates>? list) =>
      jsonCoder.maybeMultipleAsJson(list);

  @override
  String toString() {
    return "Type: $type, x: $x, y: $y";
  }
}
