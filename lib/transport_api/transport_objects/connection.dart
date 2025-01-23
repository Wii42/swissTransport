import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sbb/transport_api/helper/date_time_helper.dart';
import 'package:sbb/transport_api/helper/departure_arrival_interface.dart';
import 'package:sbb/transport_api/transport_objects/json_converters/duration_parse_converter.dart';
import 'package:sbb/transport_api/transport_objects/section.dart';
import 'package:sbb/transport_api/transport_objects/service.dart';
import 'package:sbb/transport_api/transport_objects/stop.dart';
import 'package:sbb/transport_api/transport_objects/walk.dart';
import 'package:sbb/transport_api/enums/transport_vehicles.dart';

part 'connection.g.dart';

///A connection represents a possible journey between two locations.
@JsonSerializable()
class Connection extends DepartureArrival {
  ///The departure checkpoint of the connection
  Stop? from;

  ///The arrival checkpoint of the connection
  Stop? to;

  ///Duration of the journey
  @DurationParseConverter()
  Duration? duration;

  int? transfers;

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
    this.transfers,
    this.service,
    this.products,
    this.capacity1st,
    this.capacity2nd,
    this.sections,
  });

  factory Connection.fromJson(Map<String, dynamic> map) {
    try {
      return _$ConnectionFromJson(map);
    } catch (e) {
      //print(map);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$ConnectionToJson(this);

  @override
  String toString() {
    return "From: $from, To: $to, Duration: $duration, Service: $service, Products: $products, Capacity 1st class: $capacity1st, Capacity 2nd class: $capacity2nd, Sections: $sections";
  }

  String? get transportProduct {
    Section? firstSection = sections?.firstOrNull;
    if (firstSection != null) {
      String? product = firstSection.transportName;
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
  String? get departurePlatformData => from?.platform;

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

  bool get hasCapacityInfo => (capacity1st != null || capacity2nd != null);

  bool stringCompare(Connection other) {
    return (toString() == other.toString());
  }

  bool isSameDate(Connection other) {
    DateTime? connectionDateTime = departureTime?.toLocal();
    DateTime? previousConnectionDateTime = other.departureTime?.toLocal();
    if (connectionDateTime == null || previousConnectionDateTime == null) {
      return false;
    }
    return connectionDateTime.isSameDate(previousConnectionDateTime);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    ListEquality eq = ListEquality();
    return other is Connection &&
        other.from == from &&
        other.to == to &&
        other.duration == duration &&
        other.service == service &&
        eq.equals(products, other.products) &&
        other.capacity1st == capacity1st &&
        other.capacity2nd == capacity2nd &&
        eq.equals(sections, other.sections);
  }

  @override
  int get hashCode {
    ListEquality eq = ListEquality();
    return Object.hashAll([
      from,
      to,
      duration,
      service,
      eq.hash(products),
      capacity1st,
      capacity2nd,
      eq.hash(sections),
    ]);
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
