import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sbb/transport_api/transport_objects/prognosis.dart';

void main() async {
  final Prognosis expected = Prognosis( platform: "1", arrival: DateTime.parse("2025-01-23T14:40:00+0100"), departure: DateTime.parse("2025-01-23T14:45:00+0100"), capacity1st: null, capacity2nd: null);
  final String testResponse = '{"platform":"1","departure":"2025-01-23T13:45:00.000Z","arrival":"2025-01-23T13:40:00.000Z","capacity1st":null,"capacity2nd":null}';
  group("Prognosis json de/serialization", () {
    test('deserialization', () async {
      Prognosis test = Prognosis.fromJson(jsonDecode(testResponse));
      expect(
          test,
          expected);
    });
    test('serialization', () async {
      String encoded = jsonEncode(expected.toJson());
      expect(encoded, testResponse);
    });
  });
}
