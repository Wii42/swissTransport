import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sbb/transport_api/transport_objects/journey.dart';
import 'package:sbb/transport_api/transport_objects/stop.dart';

void main() async {
  final Journey expected = Journey(
    name: "000356",
    category: "CC",
    subcategory: null,
    categoryCode: null,
    number: "63",
    operator: "WAB",
    to: "Lauterbrunnen",
    passList: [
      Stop(platform: "1"),
      Stop(platform: "3"),
    ],
    capacity1st: null,
    capacity2nd: null,
  );
  final testResponse = {
    "name": "000356",
    "category": "CC",
    "subcategory": null,
    "categoryCode": null,
    "number": "63",
    "operator": "WAB",
    "to": "Lauterbrunnen",
    "passList": [
      {
        "platform": "1",
      },
      {
        "platform": "3",
      }
    ],
    "capacity1st": null,
    "capacity2nd": null
  };
  group("Journey json de/serialization", () {
    test('deserialization', () async {
      Journey test = Journey.fromJson(testResponse);
      expect(test, expected);
    });
    test('serialization', () async {
      String encoded = jsonEncode(expected.toJson());
      expect(Journey.fromJson(jsonDecode(encoded)), expected);
    });
  });
}
