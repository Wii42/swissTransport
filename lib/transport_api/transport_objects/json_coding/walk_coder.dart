import 'package:sbb/transport_api/transport_objects/json_coding/json_coder.dart';

import '../walk.dart';

class WalkCoder extends JsonCoder<Walk> {
  static const String durationKey = 'duration';

  @override
  Walk fromJson(Map<String, dynamic> map) {
    return Walk(duration: map[durationKey]);
  }

  @override
  Map<String, dynamic> asJson(Walk object) {
    return {durationKey: object.duration};
  }
}
