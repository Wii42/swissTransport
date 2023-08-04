import 'package:sbb/transport_api/transport_objects/stop.dart';
import 'package:sbb/transport_api/transport_objects/walk.dart';
import 'package:sbb/transport_api/transportation_vehicles.dart';

import 'journey.dart';
import 'json_coding/section_coder.dart';

class Section {
  static final SectionCoder jsonCoder = SectionCoder();

  ///A journey, the transportation used by this section. Can be null
  Journey? journey;

  ///Information about walking distance, if available
  Walk? walk;

  ///The departure checkpoint of the connection
  Stop? departure;

  ///The arrival checkpoint of the connection
  Stop? arrival;

  Section({this.journey, this.walk, this.departure, this.arrival});

  factory Section.fromJson(Map<String, dynamic> map) => jsonCoder.fromJson(map);

  static Section? maybeFromJson(Map<String, dynamic>? map) =>
      jsonCoder.maybeFromJson(map);

  static List<Section> multipleFromJson(List<dynamic> list) =>
      jsonCoder.multipleFromJson(list);

  static List<Section>? maybeMultipleFromJson(List<dynamic>? list) =>
      jsonCoder.maybeMultipleFromJson(list);

  Map<String, dynamic> asJson() => jsonCoder.asJson(this);

  static List<Map<String, dynamic>> multipleAsJson(List<Section> list) =>
      jsonCoder.multipleAsJson(list);

  static List<Map<String, dynamic>>? maybeMultipleAsJson(List<Section>? list) =>
      jsonCoder.maybeMultipleAsJson(list);

  @override
  String toString() {
    return "Journey: $journey, Walk: $walk, Departure: $departure, Arrival: $arrival";
  }

  bool get hasWalk => (walk != null && walk!.duration.inSeconds > 0);

  String? get direction => journey?.to ?? arrival?.station?.name;

  String? get transportProduct {
    if (hasWalk) {
      return null;
    }
    if (journey?.category != null || journey?.number != null) {
      return "${journey?.category} ${journey?.number}";
    }
    return null;
  }

  TransportVehicles? get transportVehicle {
    return TransportVehicles.fromProduct(journey?.category);
  }
}
