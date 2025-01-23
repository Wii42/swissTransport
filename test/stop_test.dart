import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';
import 'package:sbb/transport_api/transport_objects/prognosis.dart';
import 'package:sbb/transport_api/transport_objects/stop.dart';

void main() async {
  final Stop expected = Stop(
      station: Location(
          id: '8507384',
          name: 'Lauterbrunnen',
          score: null,
          coordinates: null,
          distance: null),
      arrival: DateTime.parse('2025-01-23T14:25:00.000Z'),
      arrivalTimestamp: 1737642300,
      departure: null,
      departureTimestamp: null,
      delay: null,
      platform: '3',
      prognosis: Prognosis(
          platform: null,
          arrival: null,
          departure: null,
          capacity1st: null,
          capacity2nd: null),
      realtimeAvailability: null,
      location: Location(
          id: '8507384',
          name: 'Lauterbrunnen',
          score: null,
          coordinates: null,
          distance: null));
  final String testResponse =
      '{"station":{"id":"8507384","name":"Lauterbrunnen","score":null,"coordinate":null,"distance":null},"arrival":"2025-01-23T14:25:00.000Z","arrivalTimestamp":1737642300,"departure":null,"departureTimestamp":null,"delay":null,"platform":"3","prognosis":{"platform":null,"arrival":null,"departure":null,"capacity1st":null,"capacity2nd":null},"realtimeAvailability":null,"location":{"id":"8507384","name":"Lauterbrunnen","score":null,"coordinate":null,"distance":null}}';
  group("Section json de/serialization", () {
    test('deserialization', () async {
      Stop test = Stop.fromJson(jsonDecode(testResponse));
      expect(test, expected);
    });
    test('serialization', () async {
      String encoded = jsonEncode(expected.toJson());
      expect(Stop.fromJson(jsonDecode(encoded)), expected);
    });
  });
}
