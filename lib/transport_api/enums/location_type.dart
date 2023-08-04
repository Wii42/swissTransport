enum LocationType {
  ///Looks up for all types of locations
  all,

  /// Location is a train station, bus station
  station,

  ///Location is a point of interest (Clock tower, China garden)
  poi,

  /// Location is an address
  address,

  ///Location is not defined, the user has to relocate
  refine,
  none;

  factory LocationType.fromJson(String string) {
    for (LocationType icon in values) {
      if (icon.name == string) {
        return icon;
      }
    }
    return LocationType.none;
  }

  static LocationType maybeFromJson(String? string) {
    if (string == null) {
      return LocationType.none;
    }
    return LocationType.fromJson(string);
  }
}