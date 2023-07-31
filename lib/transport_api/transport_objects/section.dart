import 'package:sbb/transport_api/transport_objects/stop.dart';
import 'package:sbb/transport_api/transport_objects/walk.dart';
import 'package:sbb/transport_api/transportation_vehicles.dart';

import 'journey.dart';

class Section {
  ///A journey, the transportation used by this section. Can be null
  Journey? journey;

  ///Information about walking distance, if available
  Walk? walk;

  ///The departure checkpoint of the connection
  Stop? departure;

  ///The arrival checkpoint of the connection
  Stop? arrival;

  Section({this.journey, this.walk, this.departure, this.arrival});

  factory Section.fromJson(Map<String, dynamic> map) {
    return Section(
      journey: Journey.maybeFromJson(map['journey']),
      walk: Walk.maybeFromJson(map['walk']),
      departure: Stop.maybeFromJson(map['departure']),
      arrival: Stop.maybeFromJson(map['arrival']),
    );
  }

  static Section? maybeFromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    return Section.fromJson(map);
  }

  static List<Section> multipleFromJson(List<dynamic> list) {
    return [for (Map<String, dynamic> map in list) Section.fromJson(map)];
  }

  static List<Section>? maybeMultipleFromJson(List<dynamic>? list) {
    if (list == null) {
      return null;
    }
    return Section.multipleFromJson(list);
  }

  @override
  String toString() {
    return "Journey: $journey, Walk: $walk, Departure: $departure, Arrival: $arrival";
  }

  bool get hasWalk => (walk?.duration != null && walk!.duration! > 0);

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

  TransportVehicles? get transportVehicle{
    return TransportVehicles.fromProduct(journey?.category);
  }
}
