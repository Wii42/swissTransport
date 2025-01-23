import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:sbb/transport_api/transport_objects/journey.dart';
import 'package:sbb/transport_api/transport_objects/section.dart';
import 'package:sbb/transport_api/transport_objects/stop.dart';

void main() async {
  final Connection expected = Connection(
    from: Stop(platform: "E"),
    to: Stop(platform: "3"),
    duration: Duration(days:2, hours: 1, minutes: 32, seconds: 30),
    transfers: 0,
    service: null,
    products: [],
    capacity1st: null,
    capacity2nd: null,
    sections: [
      Section(
        departure: Stop(departure: DateTime.parse("2025-01-23T14:22:00+0100")),
      ),
      Section(
        departure: Stop(arrival: DateTime.parse("2025-01-23T14:44:00+0100")),
      ),
    ],
  );
  final testResponse = {
    "from": {
      "platform": "E",
    },
    "to": {
      "platform": "3",
    },
    "duration": "02d01:32:30",
    "transfers": 0,
    "service": null,
    "products": [],
    "capacity1st": null,
    "capacity2nd": null,
    "sections": [
      {
        "departure": {
          "departure": "2025-01-23T14:22:00+0100",
        },
      },
      {
        "departure": {
          "arrival": "2025-01-23T14:44:00+0100",

      } },
    ]
  };
  group("Connection json de/serialization", () {
    test('deserialization', () async {
      Connection test = Connection.fromJson(testResponse);
      expect(test, expected);
    });
    test('serialization', () async {
      String encoded = jsonEncode(expected.toJson());
      expect(Connection.fromJson(jsonDecode(encoded)), expected);
    });
  });
}
