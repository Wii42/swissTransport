import 'package:flutter/material.dart';

enum TransportVehicles {
  bus(apiName: "bus", icon: Icons.directions_bus, productAbbreviations: ['B']),
  train(
      apiName: "train",
      icon: Icons.directions_train,
      productAbbreviations: ['S', 'IC', 'ICE', 'R', 'RE', 'IR', 'CC']),
  tram(apiName: "tram", icon: Icons.tram, productAbbreviations: ['T']),
  ship(apiName: "ship", icon: Icons.directions_boat),
  cableWay(
      apiName: "cableway",
      icon: Icons.cable,
      productAbbreviations: ['GB', 'PB']),
  none(apiName: "none", icon: Icons.question_mark);

  final IconData icon;
  final String apiName;
  final List<String> productAbbreviations;

  const TransportVehicles(
      {required this.apiName,
      required this.icon,
      this.productAbbreviations = const []});

  factory TransportVehicles.fromJson(String string) {
    for (TransportVehicles icon in values) {
      if (icon.apiName == string) {
        return icon;
      }
    }
    print("$string does not match any TransportIcon");
    return TransportVehicles.none;
  }

  static TransportVehicles maybeFromJson(String? string) {
    if (string == null) {
      return TransportVehicles.none;
    }
    return TransportVehicles.fromJson(string);
  }

  static TransportVehicles? fromProduct(String? product) {
    for (TransportVehicles vehicle in values) {
      if (vehicle.productAbbreviations.contains(product)) {
        return vehicle;
      }
    }
    return null;
  }
}
