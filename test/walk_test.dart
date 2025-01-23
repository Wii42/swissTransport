import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sbb/transport_api/transport_objects/walk.dart';

void main() async {
  group("Walk json de/serialization", () {
    test('deserialization', () async {
      String response = '{"duration":360}';
      Walk walk = Walk.fromJson(jsonDecode(response));
      expect(walk, Walk(duration: Duration(seconds: 360)));
    });
    test('deserialization: faulty response', () async {
      String response = '{"durationn":360}';
      Walk walk = Walk.fromJson(jsonDecode(response));
      expect(walk.duration, null);
    });
    test('serialization', () async {
      Walk walk = Walk(duration: Duration(seconds: 360));
      String encoded = jsonEncode(walk.toJson());
      expect(encoded, '{"duration":360}');
    });
  });
}
