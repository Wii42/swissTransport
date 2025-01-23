import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sbb/transport_api/transport_objects/coordinates.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';

void main() async {
  final Location testLocation = Location(
      id: "100",
      name: "Fribourg",
      score: null,
      coordinates: Coordinates(type: "WGS84", x: 46.803151, y: 7.151052),
      distance: null);
  final String testResponse = '{"id":"100","type":"none","name":"Fribourg","score":null,"coordinate":{"type":"WGS84","x":46.803151,"y":7.151052},"distance":null,"icon":"none"}';
  group("Location json de/serialization", () {
    test('deserialization', () async {
      Location test = Location.fromJson(jsonDecode(testResponse));
      expect(
          test,
          testLocation);
    });
    test('serialization', () async {
      String encoded = jsonEncode(testLocation.toJson());
      expect(encoded, testResponse);
    });
  });
}
