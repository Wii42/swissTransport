import 'package:flutter/material.dart';

enum TransportationVehicles {
  bus(apiName: "bus", icon: Icons.directions_bus),
  train(apiName: "train", icon: Icons.directions_train),
  tram(apiName: "tram", icon: Icons.tram),
  ship(apiName: "ship", icon: Icons.directions_boat),
  cableWay(apiName: "cableway", icon: Icons.cable),
  none(apiName: "none", icon: Icons.question_mark);

  final IconData icon;
  final String apiName;

  const TransportationVehicles({required this.apiName, required this.icon});

  factory TransportationVehicles.fromJson(String string) {
    for (TransportationVehicles icon in values) {
      if (icon.apiName == string) {
        return icon;
      }
    }
    print("$string does not match any TransportIcon");
    return TransportationVehicles.none;
  }
}
