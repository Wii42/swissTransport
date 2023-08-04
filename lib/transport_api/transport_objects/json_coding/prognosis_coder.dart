import 'package:sbb/transport_api/transport_objects/json_coding/json_coder.dart';
import 'package:sbb/transport_api/transport_objects/json_coding/stop_coder.dart';
import 'package:sbb/transport_api/transport_objects/prognosis.dart';

class PrognosisCoder extends JsonCoder<Prognosis> {
  static const String platformKey = 'platform',
      departureKey = 'departure',
      arrivalKey = 'arrival',
      capacity1stKey = 'capacity1st',
      capacity2ndKey = 'capacity2nd';

  @override
  Prognosis fromJson(Map<String, dynamic> map) {
    return Prognosis(
      platform: map[platformKey],
      departure: StopCoder.maybeParse(map[departureKey]),
      arrival: StopCoder.maybeParse(map[arrivalKey]),
      capacity1st: map[capacity1stKey],
      capacity2nd: map[capacity2ndKey],
    );
  }

  @override
  Map<String, dynamic> asJson(Prognosis object) {
    return {
      platformKey: object.platform,
      departureKey: object.departure.toString(),
      arrivalKey: object.arrival.toString(),
      capacity1stKey: object.capacity1st,
      capacity2ndKey: object.capacity2nd,
    };
  }
}
