import 'package:json_annotation/json_annotation.dart';
import 'package:sbb/transport_api/transport_objects/stop.dart';
import 'package:sbb/transport_api/transport_objects/walk.dart';
import 'package:sbb/transport_api/enums/transport_vehicles.dart';

import 'journey.dart';

part 'section.g.dart';

@JsonSerializable()
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

  factory Section.fromJson(Map<String, dynamic> map) => _$SectionFromJson(map);

  Map<String, dynamic> toJson() => _$SectionToJson(this);

  @override
  String toString() {
    return "Journey: $journey, Walk: $walk, Departure: $departure, Arrival: $arrival";
  }

  bool get hasWalk => (walk?.duration != null && walk!.duration!.inSeconds > 0);

  String? get direction => journey?.to ?? arrival?.station?.name;

  String? get transportName {
    if (hasWalk) {
      return null;
    }
    return journey?.transportName;
  }

  TransportVehicles? get transportVehicle => journey?.transportVehicle;

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Section &&
        other.journey == journey &&
        other.walk == walk &&
        other.departure == departure &&
        other.arrival == arrival;
  }

  @override
  int get hashCode => Object.hashAll([journey, walk, departure, arrival]);
}
