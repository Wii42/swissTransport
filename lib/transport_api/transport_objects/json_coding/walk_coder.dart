import 'package:sbb/transport_api/transport_objects/json_coding/json_coder.dart';

import '../walk.dart';

class WalkCoder extends JsonCoder<Walk> {
  static const String durationKey = 'duration';

  @override
  Walk fromJson(Map<String, dynamic> map) {
    return Walk(duration: Duration(seconds: map[durationKey]));
  }

  @override
  Walk? maybeFromJson(Map<String, dynamic>? map) {
    if (map == null || map[durationKey] == null) {
      return null;
    }
    return fromJson(map);
  }

  @override
  Map<String, dynamic> asJson(Walk object) {
    return {durationKey: object.duration?.inSeconds};
  }
}
