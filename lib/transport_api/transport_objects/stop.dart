import 'package:sbb/transport_api/helper/interfaces.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';
import 'package:sbb/transport_api/transport_objects/prognosis.dart';

///A checkpoint represents an arrival or a departure point (in time and space) of a connection.
class Stop extends DepartureArrival{
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

  Stop(
      {this.station,
      this.arrival,
      this.departure,
      this.delay,
      this.platform,
      this.prognosis});

  factory Stop.fromJson(Map<String, dynamic> map) {
    return Stop(
      station: Location.maybeFromJson(map['station']),
      arrival: map['arrival'] != null ? DateTime.parse(map['arrival']) : null,
      departure:
          map['departure'] != null ? DateTime.parse(map['departure']) : null,
      delay: map['delay'],
      platform: map['platform'],
      prognosis: Prognosis.maybeFromJson(map['prognosis']),
    );
  }

  static Stop? maybeFromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    return Stop.fromJson(map);
  }

  static List<Stop> multipleFromJson(List<dynamic> list) {
    return [for (Map<String, dynamic> map in list) Stop.fromJson(map)];
  }

  static List<Stop>? maybeMultipleFromJson(List<dynamic>? list) {
    if (list == null) {
      return null;
    }
    return Stop.multipleFromJson(list);
  }

  @override
  String toString() {
    return "Station: $station, Arrival: $arrival, Departure: $departure, Delay: $delay, Plattform: $platform, Prognosis: $prognosis";
  }

  @override
  DateTime? get arrivalTime => arrival;

  @override
  String? get departurePlatform => platform;

  @override
  DateTime? get departureTime => departure;
}
