import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

///Operation information for a connection.
@JsonSerializable()
class Service {
  ///Information about how regular a connection operates.
  String? regular;

  ///Additional information about irregular operation dates.
  String? irregular;

  Service({this.regular, this.irregular});

  factory Service.fromJson(Map<String, dynamic> map) => _$ServiceFromJson(map);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  @override
  String toString() {
    return "Regular: $regular, Irregular: $irregular";
  }
}
