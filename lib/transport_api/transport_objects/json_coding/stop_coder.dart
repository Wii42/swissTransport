import 'package:intl/intl.dart';
import 'package:sbb/transport_api/transport_objects/json_coding/json_coder.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';

import '../prognosis.dart';
import '../stop.dart';

class StopCoder extends JsonCoder<Stop> {
  static const String stationKey = 'station',
      arrivalKey = 'arrival',
      arrivalTimestampKey = 'arrivalTimestamp',
      departureKey = 'departure',
      departureTimestampKey = 'departureTimestamp',
      delayKey = 'delay',
      platformKey = 'platform',
      prognosisKey = 'prognosis',
      realtimeAvailabilityKey = 'realtimeAvailability',
      locationKey = 'location';

  @override
  Stop fromJson(Map<String, dynamic> map) {
    return Stop(
      station: Location.maybeFromJson(map[stationKey]),
      arrival: maybeParse(map[arrivalKey]),
      departure: maybeParse(map[departureKey]),
      delay: map[delayKey],
      platform: map[platformKey],
      prognosis: Prognosis.maybeFromJson(map[prognosisKey]),
      arrivalTimestamp: map[arrivalTimestampKey],
      departureTimestamp: map[departureTimestampKey],
      realtimeAvailability: map[realtimeAvailabilityKey],
      location: Location.maybeFromJson(map[locationKey]),
    );
  }

  @override
  Map<String, dynamic> asJson(Stop object) {
    return {
      stationKey: object.station?.asJson(),
      arrivalKey: object.arrival.toString(),
      departureKey: object.departure.toString(),
      delayKey: object.delay,
      platformKey: object.platform,
      prognosisKey: object.prognosis?.asJson(),
      arrivalTimestampKey: object.arrivalTimestamp,
      departureTimestampKey: object.departureTimestamp,
      realtimeAvailabilityKey: object.realtimeAvailability,
      locationKey: object.location?.asJson(),
    };
  }

  static maybeParse(String? string) {
    if (string == null || string == 'null') {
      return null;
    }
    return DateTime.parse(string);
  }
}
