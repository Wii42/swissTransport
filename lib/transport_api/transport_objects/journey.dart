import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sbb/transport_api/helper/departure_arrival_interface.dart';
import 'package:sbb/transport_api/transport_objects/stop.dart';

import '../enums/transport_vehicles.dart';

part 'journey.g.dart';

@JsonSerializable()
class Journey extends DepartureArrival {

  ///The name of the transportation
  String? name;

  ///Category of the transportation
  String? category;

  String? subcategory;

  ///An internal category code of the transportation
  int? categoryCode;

  ///The number of the transportation line
  String? number;

  ///The company performing the transportation
  String? operator;

  ///Final destination of the train
  String? to;

  ///Checkpoints the train passed on the journey
  List<Stop>? passList;

  ///The maximum estimated occupation load of 1st class coaches
  int? capacity1st;

  ///The maximum estimated occupation load of 2nd class coaches
  int? capacity2nd;

  Stop? stop;

  Journey({
    this.name,
    this.category,
    this.subcategory,
    this.categoryCode,
    this.number,
    this.operator,
    this.to,
    this.passList,
    this.capacity1st,
    this.capacity2nd,
    this.stop,
  });

  factory Journey.fromJson(Map<String, dynamic> map) => _$JourneyFromJson(map);

  Map<String, dynamic> toJson() => _$JourneyToJson(this);

  @override
  String toString() {
    return "Name: $name, Category: $category, Category Code: $categoryCode, Number: $number, Operator: $operator, To: $to, Pass List: $passList, Capacity 1st class: $capacity1st, Capacity 2nd class: $capacity2nd";
  }

  @override
  DateTime? get departureTime => passList?.firstOrNull?.departure?.toLocal();

  @override
  String? get departurePlatformData => passList?.firstOrNull?.platform;

  @override
  DateTime? get arrivalTime => passList?.lastOrNull?.arrival?.toLocal();

  TransportVehicles? get transportVehicle {
    return TransportVehicles.fromProduct(category);
  }

  String? get transportName {
    String? tNumber;
    if (number != null && number!.length < 4) {
      tNumber = number;
    }
    if (category != null && tNumber != null) {
      return "$category $tNumber";
    }
    if (category != null) {
      return category;
    }
    if (tNumber != null) {
      return tNumber;
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    if (other is Journey) {
      return name == other.name &&
          category == other.category &&
          categoryCode == other.categoryCode &&
          number == other.number &&
          operator == other.operator &&
          to == other.to &&
          ListEquality().equals(passList, other.passList) &&
          capacity1st == other.capacity1st &&
          capacity2nd == other.capacity2nd;
    }
    return false;
  }

  @override
  int get hashCode => Object.hashAll([
        name,
        category,
        categoryCode,
        number,
        operator,
        to,
        ListEquality().hash(passList),
        capacity1st,
        capacity2nd,
      ]);
}
