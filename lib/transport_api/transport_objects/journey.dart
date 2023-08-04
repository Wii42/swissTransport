import 'package:sbb/transport_api/helper/interfaces.dart';
import 'package:sbb/transport_api/transport_objects/stop.dart';

import 'json_coding/journey_coder.dart';

class Journey extends DepartureArrival {
  static final JourneyCoder jsonCoder = JourneyCoder();

  ///The name of the transportation
  String? name;

  ///Category of the transportation
  String? category;

  ///An internal category code of the transportation
  int? categoryCode;

  ///The number of the transportation line
  String? number;

  ///The company performing the transportation
  String? operator;

  ///Final destination of the train
  String? to;

  ///Checkpoints the train passed on the journey
  List<Stop>? passList;

  ///The maximum estimated occupation load of 1st class coaches
  int? capacity1st;

  ///The maximum estimated occupation load of 2nd class coaches
  int? capacity2nd;

  Stop? stop;

  Journey({
    this.name,
    this.category,
    this.categoryCode,
    this.number,
    this.operator,
    this.to,
    this.passList,
    this.capacity1st,
    this.capacity2nd,
    this.stop,
  });

  factory Journey.fromJson(Map<String, dynamic> map) => jsonCoder.fromJson(map);

  static Journey? maybeFromJson(Map<String, dynamic>? map) =>
      jsonCoder.maybeFromJson(map);

  static List<Journey> multipleFromJson(List<dynamic> list) =>
      jsonCoder.multipleFromJson(list);

  static List<Journey>? maybeMultipleFromJson(List<dynamic>? list) =>
      jsonCoder.maybeMultipleFromJson(list);

  Map<String, dynamic> asJson() => jsonCoder.asJson(this);

  static List<Map<String, dynamic>> multipleAsJson(List<Journey> list) =>
      jsonCoder.multipleAsJson(list);

  static List<Map<String, dynamic>>? maybeMultipleAsJson(List<Journey>? list) =>
      jsonCoder.maybeMultipleAsJson(list);

  @override
  String toString() {
    return "Name: $name, Category: $category, Category Code: $categoryCode, Number: $number, Operator: $operator, To: $to, Pass List: $passList, Capacity 1st class: $capacity1st, Capacity 2nd class: $capacity2nd";
  }

  @override
  DateTime? get departureTime => passList?.firstOrNull?.departure?.toLocal();

  @override
  String? get departurePlatform => passList?.firstOrNull?.platform;

  @override
  DateTime? get arrivalTime => passList?.lastOrNull?.arrival?.toLocal();
}
