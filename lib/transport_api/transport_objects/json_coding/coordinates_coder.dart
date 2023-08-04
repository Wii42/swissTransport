import 'package:sbb/transport_api/transport_objects/coordinates.dart';
import 'package:sbb/transport_api/transport_objects/json_coding/json_coder.dart';

class CoordinatesCoder extends JsonCoder<Coordinates> {
  static const String typeKey = 'type', xKey = 'x', yKey = 'y';

  @override
  Coordinates fromJson(Map<String, dynamic> map) {
    return Coordinates(
      type: map[typeKey],
      x: map[xKey],
      y: map[yKey],
    );
  }

  @override
  Map<String, dynamic> asJson(Coordinates object) {
    return {
      typeKey: object.type,
      xKey: object.x,
      yKey: object.y,
    };
  }
}
