///Operation information for a connection.
class Service {
  ///Information about how regular a connection operates.
  String? regular;

  ///Additional information about irregular operation dates.
  String? irregular;

  Service({this.regular, this.irregular});

  factory Service.fromJson(Map<String, dynamic> map) {
    return Service(regular: map['regular'], irregular: map['irregular']);
  }

  static Service? maybeFromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    return Service.fromJson(map);
  }

  @override
  String toString() {
    return "Regular: $regular, Irregular: $irregular";
  }
}
