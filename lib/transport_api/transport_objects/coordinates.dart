class Coordinates {
  ///The type of the given coordinate
  String? type;

  ///Latitude
  double? x;

  ///Longitude
  double? y;

  Coordinates({this.type, this.x, this.y});

  factory Coordinates.fromJson(Map<String, dynamic> map) {
    return Coordinates(
      type: map['type'],
      x: map['x'],
      y: map['y'],
    );
  }

  static Coordinates? maybeFromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    return Coordinates.fromJson(map);
  }

  @override
  String toString() {
    return "Type: $type, x: $x, y: $y";
  }
}
