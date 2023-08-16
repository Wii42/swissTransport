import 'package:sbb/transport_api/helper/departure_arrival_interface.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';
import 'package:sbb/transport_api/transport_objects/prognosis.dart';

import 'json_coding/stop_coder.dart';

///A checkpoint represents an arrival or a departure point (in time and space) of a connection.
class Stop extends DepartureArrival {
  static final StopCoder jsonCoder = StopCoder();

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

  factory Stop.fromJson(Map<String, dynamic> map) => jsonCoder.fromJson(map);

  static Stop? maybeFromJson(Map<String, dynamic>? map) =>
      jsonCoder.maybeFromJson(map);

  static List<Stop> multipleFromJson(List<dynamic> list) =>
      jsonCoder.multipleFromJson(list);

  static List<Stop>? maybeMultipleFromJson(List<dynamic>? list) =>
      jsonCoder.maybeMultipleFromJson(list);

  Map<String, dynamic> asJson() => jsonCoder.asJson(this);

  static List<Map<String, dynamic>> multipleAsJson(List<Stop> list) =>
      jsonCoder.multipleAsJson(list);

  static List<Map<String, dynamic>>? maybeMultipleAsJson(List<Stop>? list) =>
      jsonCoder.maybeMultipleAsJson(list);

  @override
  String toString() {
    return "Station: $station, Arrival: $arrival, Departure: $departure, Delay: $delay, Plattform: $platform, Prognosis: $prognosis";
  }

  @override
  DateTime? get arrivalTime => arrival;

  @override
  String? get departurePlatformData => platform;

  @override
  DateTime? get departureTime => departure;

  bool get hasDelay => (delay != null && delay! > 0);

  bool get isRealStop => arrival != null || departure != null;
}
