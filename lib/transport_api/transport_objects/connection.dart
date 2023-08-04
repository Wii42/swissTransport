import 'package:sbb/transport_api/helper/interfaces.dart';
import 'package:sbb/transport_api/transport_objects/section.dart';
import 'package:sbb/transport_api/transport_objects/service.dart';
import 'package:sbb/transport_api/transport_objects/stop.dart';
import 'package:sbb/transport_api/transport_objects/walk.dart';
import 'package:sbb/transport_api/transportation_vehicles.dart';

import 'json_coding/connection_coder.dart';

///A connection represents a possible journey between two locations.
class Connection extends DepartureArrival {
  static final ConnectionCoder jsonCoder = ConnectionCoder();

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

  factory Connection.fromJson(Map<String, dynamic> map) =>
      jsonCoder.fromJson(map);

  static Connection? maybeFromJson(Map<String, dynamic>? map) =>
      jsonCoder.maybeFromJson(map);

  static List<Connection> multipleFromJson(List<dynamic> list) =>
      jsonCoder.multipleFromJson(list);

  static List<Connection>? maybeMultipleFromJson(List<dynamic>? list) =>
      jsonCoder.maybeMultipleFromJson(list);

  Map<String, dynamic> asJson() => jsonCoder.asJson(this);

  static List<Map<String, dynamic>> multipleAsJson(List<Connection> list) =>
      jsonCoder.multipleAsJson(list);

  static List<Map<String, dynamic>>? maybeMultipleAsJson(
          List<Connection>? list) =>
      jsonCoder.maybeMultipleAsJson(list);

  @override
  String toString() {
    return "From: $from, To: $to, Duration: $duration, Service: $service, Products: $products, Capacity 1st class: $capacity1st, Capacity 2nd class: $capacity2nd, Sections: $sections";
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

  Section? get firstSection => sections?.firstOrNull;

  Walk? get startWalk => firstSection?.walk;

  bool get isStartingWithWalk => firstSection?.hasWalk ?? false;

  TransportVehicles? get transportVehicle {
    if (firstSection != null) {
      TransportVehicles? vehicle = firstSection?.transportVehicle;
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

  bool stringCompare(Connection other) {
    return (toString() == other.toString());
  }
}

extension StringContains on List<Connection> {
  bool stringContains(Connection other) {
    for (Connection connection in this) {
      if (connection.stringCompare(other)) {
        return true;
      }
    }
    return false;
  }
}
