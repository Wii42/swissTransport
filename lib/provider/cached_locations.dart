import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../transport_api/transport_objects/stations.dart';

/// CachedLocations is a provider that stores locations by name and coordinates, to avoid redundant API calls.
class CachedLocations extends ChangeNotifier {
  final Map<String, Stations> _locationsByName = {};

  final Map<LatLng, Stations> _locationsByCoordinates = {};

  Stations? getLocationByName(String name) {
    return _locationsByName[name];
  }

  Stations? getLocationByCoordinates(LatLng coordinates) {
    return _locationsByCoordinates[coordinates];
  }

  void addLocationByName(String name, Stations stations) {
    _locationsByName[name] = stations;
    notifyListeners();
  }

  void addLocationByCoordinates(LatLng coordinates, Stations stations) {
    _locationsByCoordinates[coordinates] = stations;
    notifyListeners();
  }
}
