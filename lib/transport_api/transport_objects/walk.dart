class Walk {
  int? duration;

  Walk({this.duration});

  factory Walk.fromJson(Map<String, dynamic> map) {
    return Walk(duration: map['duration']);
  }

  static Walk? maybeFromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    return Walk.fromJson(map);
  }
}
