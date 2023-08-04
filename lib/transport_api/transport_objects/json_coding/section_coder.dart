import 'package:sbb/transport_api/transport_objects/json_coding/json_coder.dart';

import '../journey.dart';
import '../section.dart';
import '../stop.dart';
import '../walk.dart';

class SectionCoder extends JsonCoder<Section> {
  static const String journeyKey = 'journey',
      walkKey = 'walk',
      departureKey = 'departure',
      arrivalKey = 'arrival';

  @override
  Section fromJson(Map<String, dynamic> map) {
    return Section(
      journey: Journey.maybeFromJson(map[journeyKey]),
      walk: Walk.maybeFromJson(map[walkKey]),
      departure: Stop.maybeFromJson(map[departureKey]),
      arrival: Stop.maybeFromJson(map[arrivalKey]),
    );
  }

  @override
  Map<String, dynamic> asJson(Section object) {
    return {
      journeyKey: object.journey?.asJson(),
      walkKey: object.walk?.asJson(),
      departureKey: object.departure?.asJson(),
      arrivalKey: object.arrival?.asJson(),
    };
  }
}
