import 'package:sbb/transport_api/transport_objects/json_coding/json_coder.dart';

import '../service.dart';

class ServiceCoder extends JsonCoder<Service> {
  static const String regularKey = 'regular', irregularKey = 'irregular';

  @override
  Service fromJson(Map<String, dynamic> map) {
    return Service(regular: map[regularKey], irregular: map[irregularKey]);
  }

  @override
  Map<String, dynamic> asJson(Service object) {
    return {
      regularKey: object.regular,
      irregularKey: object.irregular,
    };
  }
}
