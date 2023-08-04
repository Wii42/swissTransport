import 'json_coding/service_coder.dart';

///Operation information for a connection.
class Service {
  static final ServiceCoder jsonCoder = ServiceCoder();

  ///Information about how regular a connection operates.
  String? regular;

  ///Additional information about irregular operation dates.
  String? irregular;

  Service({this.regular, this.irregular});

  factory Service.fromJson(Map<String, dynamic> map) => jsonCoder.fromJson(map);

  static Service? maybeFromJson(Map<String, dynamic>? map) =>
      jsonCoder.maybeFromJson(map);

  static List<Service> multipleFromJson(List<dynamic> list) =>
      jsonCoder.multipleFromJson(list);

  static List<Service>? maybeMultipleFromJson(List<dynamic>? list) =>
      jsonCoder.maybeMultipleFromJson(list);

  Map<String, dynamic> asJson() => jsonCoder.asJson(this);

  static List<Map<String, dynamic>> multipleAsJson(List<Service> list) =>
      jsonCoder.multipleAsJson(list);

  static List<Map<String, dynamic>>? maybeMultipleAsJson(List<Service>? list) =>
      jsonCoder.maybeMultipleAsJson(list);

  @override
  String toString() {
    return "Regular: $regular, Irregular: $irregular";
  }
}
