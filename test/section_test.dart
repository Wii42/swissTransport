import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sbb/transport_api/transport_objects/journey.dart';
import 'package:sbb/transport_api/transport_objects/section.dart';
import 'package:sbb/transport_api/transport_objects/stop.dart';

void main() async {
  final Section expected = Section(
    journey: Journey(name: "000356"),
    walk: null,
    departure: Stop(platform: "1"),
    arrival: Stop(platform: "3"),
  );
  final testResponse = {
    "journey": {
      "name": "000356",
    },
    "walk": null,
    "departure": {
      "platform": "1",
    },
    "arrival": {
      "platform": "3",
    }
  };
  group("Section json de/serialization", () {
    test('deserialization', () async {
      Section test = Section.fromJson(testResponse);
      expect(test, expected);
    });
    test('serialization', () async {
      String encoded = jsonEncode(expected.toJson());
      expect(Section.fromJson(jsonDecode(encoded)), expected);
    });
  });
}
