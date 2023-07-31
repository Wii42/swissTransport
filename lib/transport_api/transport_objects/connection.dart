import 'package:sbb/transport_api/helper/interfaces.dart';
import 'package:sbb/transport_api/transport_objects/section.dart';
import 'package:sbb/transport_api/transport_objects/service.dart';
import 'package:sbb/transport_api/transport_objects/stop.dart';
import 'package:sbb/transport_api/transportation_vehicles.dart';

///A connection represents a possible journey between two locations.
class Connection extends DepartureArrival {
  ///The departure checkpoint of the connection
  Stop? from;

  ///The arrival checkpoint of the connection
  Stop? to;

  ///Duration of the journey
  Duration? duration;

  ///Service information about how regular the connection operates
  Service? service;

  /// Array with transport products
  List<String>? products;

  ///The maximum estimated occupation load of 1st class coaches
  int? capacity1st;

  ///The maximum estimated occupation load of 2nd class coaches
  int? capacity2nd;

  ///A list of sections
  List<Section>? sections;

  Connection({
    this.from,
    this.to,
    this.duration,
    this.service,
    this.products,
    this.capacity1st,
    this.capacity2nd,
    this.sections,
  });

  factory Connection.fromJson(Map<String, dynamic> map) {
    return Connection(
      from: Stop.maybeFromJson(map['from']),
      to: Stop.maybeFromJson(map['to']),
      duration: tryParseDuration(map['duration']),
      service: Service.maybeFromJson(map['service']),
      products: map['products'] != null
          ? [for (String product in map['products']) product]
          : null,
      capacity1st: map['capacity1st'],
      capacity2nd: map['capacity2nd'],
      sections: Section.maybeMultipleFromJson(map['sections']),
    );
  }

  static Connection? maybeFromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    return Connection.fromJson(map);
  }

  static List<Connection> multipleFromJson(List<dynamic> list) {
    return [for (Map<String, dynamic> map in list) Connection.fromJson(map)];
  }

  static List<Connection>? maybeMultipleFromJson(List<dynamic>? list) {
    if (list == null) {
      return null;
    }
    return Connection.multipleFromJson(list);
  }

  @override
  String toString() {
    return "From: $from, To: $to, Duration: $duration, Service: $service, Products: $products, Capacity 1st class: $capacity1st, Capacity 2nd class: $capacity2nd, Sections: $sections";
  }

  static Duration? tryParseDuration(String? string) {
    if (string == null) {
      return null;
    }
    try {
      return parseDuration(string);
    } on Exception {
      return null;
    }
  }

  static Duration parseDuration(String string) {
    List<String> daySplit = string.split('d');
    assert(daySplit.length == 2);
    int days = int.parse(daySplit[0]);

    String time = daySplit[1];
    List<String> timeSplit = time.split(':');
    assert(timeSplit.length == 3);
    int hours = int.parse(timeSplit[0]);
    int minutes = int.parse(timeSplit[1]);
    int seconds = int.parse(timeSplit[2]);
    return Duration(
        days: days, hours: hours, minutes: minutes, seconds: seconds);
  }

  String? get transportProduct {
    Section? firstSection = sections?.firstOrNull;
    if (firstSection != null) {
      String? product = firstSection.transportProduct;
      if (product != null) {
        return product;
      }
    }

    List<String>? products = this.products;
    if (products == null) {
      return null;
    }
    return products.firstOrNull;
  }

  String? get direction => sections?.firstOrNull?.direction;

  @override
  DateTime? get departureTime => from?.departure;

  @override
  String? get departurePlatform => from?.platform;

  @override
  DateTime? get arrivalTime => to?.arrival;

  int? get totalWalkingSecs {
    if (sections == null) {
      return null;
    }
    int walkingSecs = 0;
    for (Section section in sections!) {
      if (section.hasWalk) {
        walkingSecs += section.walk!.duration!;
      }
    }
    return walkingSecs;
  }

  bool get hasWalkingTime => totalWalkingSecs != null && totalWalkingSecs != 0;

  bool get isStartingWithWalk {
    if (sections?.firstOrNull == null) {
      return false;
    }
    return sections!.first.hasWalk;
  }

  TransportVehicles? get transportVehicle {
    Section? firstSection = sections?.firstOrNull;
    if (firstSection != null) {
      TransportVehicles? vehicle = firstSection.transportVehicle;
      if (vehicle != null) {
        return vehicle;
      }
    }

    List<String>? products = this.products;
    if (products == null) {
      return null;
    }
    return TransportVehicles.fromProduct(products.firstOrNull);
  }
}
