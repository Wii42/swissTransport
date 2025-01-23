import 'package:json_annotation/json_annotation.dart';

part 'coordinates.g.dart';

@JsonSerializable()
class Coordinates {

  ///The type of the given coordinate
  String? type;

  ///Latitude
  double? x;

  ///Longitude
  double? y;

  Coordinates({this.type, this.x, this.y});

  factory Coordinates.fromJson(Map<String, dynamic> map) =>
      _$CoordinatesFromJson(map);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);

  @override
  String toString() {
    return "Type: $type, x: $x, y: $y";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coordinates &&
        other.type == type &&
        other.x == x &&
        other.y == y;
  }

  @override
  int get hashCode => Object.hashAll([type, x, y]);
}
