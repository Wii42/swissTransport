import 'package:json_annotation/json_annotation.dart';
import 'package:sbb/transport_api/helper/departure_arrival_interface.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';
import 'package:sbb/transport_api/transport_objects/prognosis.dart';

part 'stop.g.dart';

///A checkpoint represents an arrival or a departure point (in time and space) of a connection.
@JsonSerializable()
class Stop extends DepartureArrival {
  ///A location object showing this line's stop at the requested station.
  Location? station;

  ///The arrival time to the checkpoint
  DateTime? arrival;

  ///The departure time from the checkpoint
  DateTime? departure;

  ///The delay at this checkpoint, can be null if no prognosis is available.
  int? delay;

  ///The arrival/departure platform
  String? platform;

  ///The checkpoint prognosis
  Prognosis? prognosis;

  int? arrivalTimestamp;
  int? departureTimestamp;
  String? realtimeAvailability;
  Location? location;

  Stop({
    this.station,
    this.arrival,
    this.departure,
    this.delay,
    this.platform,
    this.prognosis,
    this.arrivalTimestamp,
    this.departureTimestamp,
    this.realtimeAvailability,
    this.location,
  });

  factory Stop.fromJson(Map<String, dynamic> map) => _$StopFromJson(map);

  Map<String, dynamic> toJson() => _$StopToJson(this);

  @override
  String toString() {
    return "Station: $station, Arrival: $arrival, Departure: $departure, Delay: $delay, Plattform: $platform, Prognosis: $prognosis, ArrivalTimestamp: $arrivalTimestamp, DepartureTimestamp: $departureTimestamp, RealtimeAvailability: $realtimeAvailability, Location: $location";
  }

  @override
  DateTime? get arrivalTime => arrival;

  @override
  String? get departurePlatformData => platform;

  @override
  DateTime? get departureTime => departure;

  bool get hasDelay => (delay != null && delay! > 0);

  bool get isRealStop => arrival != null || departure != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Stop &&
        other.station == station &&
        other.arrival == arrival &&
        other.departure == departure &&
        other.delay == delay &&
        other.platform == platform &&
        other.prognosis == prognosis &&
        other.arrivalTimestamp == arrivalTimestamp &&
        other.departureTimestamp == departureTimestamp &&
        other.realtimeAvailability == realtimeAvailability &&
        other.location == location;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      station,
      arrival,
      departure,
      delay,
      platform,
      prognosis,
      arrivalTimestamp,
      departureTimestamp,
      realtimeAvailability,
      location,
    ]);
  }
}
