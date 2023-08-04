import 'package:sbb/transport_api/transport_objects/journey.dart';
import 'package:sbb/transport_api/transport_objects/json_coding/json_coder.dart';

import '../stop.dart';

class JourneyCoder extends JsonCoder<Journey> {
  static const String nameKey = 'name',
      categoryKey = 'category',
      categoryCodeKey = 'categoryCode',
      numberKey = 'number',
      operatorKey = 'operator',
      toKey = 'to',
      passListKey = 'passList',
      capacity1stKey = 'capacity1st',
      capacity2ndKey = 'capacity2nd',
      stopKey = 'stop';

  @override
  Journey fromJson(Map<String, dynamic> map) {
    return Journey(
      name: map[nameKey],
      category: map[categoryKey],
      categoryCode: map[categoryCodeKey],
      number: map[numberKey],
      operator: map[operatorKey],
      to: map[toKey],
      passList: Stop.maybeMultipleFromJson(map[passListKey]),
      capacity1st: map[capacity1stKey],
      capacity2nd: map[capacity2ndKey],
      stop: Stop.maybeFromJson(map[stopKey]),
    );
  }

  @override
  Map<String, dynamic> asJson(Journey object) {
    return {
      nameKey: object.name,
      categoryKey: object.category,
      categoryCodeKey: object.categoryCode,
      numberKey: object.number,
      operatorKey: object.operator,
      toKey: object.to,
      passListKey: Stop.maybeMultipleAsJson(object.passList),
      capacity1stKey: object.capacity1st,
      capacity2ndKey: object.capacity2nd,
      stopKey: object.stop?.asJson(),
    };
  }
}
