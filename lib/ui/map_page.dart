import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sbb/generic_ui_elements/with_space_between.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generic_ui_elements/widget_with_title.dart';
import '../location.dart';
import '../transport_api/enums/location_type.dart';
import '../transport_api/enums/transport_vehicles.dart';
import '../transport_api/transport_api.dart';
import '../transport_api/transport_objects/coordinates.dart';
import '../transport_api/transport_objects/location.dart';

class MapPage extends StatefulWidget with WidgetWithTitle {
  const MapPage({super.key});

  @override
  IconData? get icon => null;

  @override
  String get title => "Karte";

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late final AnimatedMapController mapController;
  @override
  void initState() {
    super.initState();
    mapController = AnimatedMapController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              Position position = snapshot.data!;
              log('Position: $position');
              LatLng latLng = LatLng(position.latitude, position.longitude);
              return FutureBuilder(
                  future: TransportApi().locations(
                    coordinates: Coordinates(
                      x: position.longitude,
                      y: position.latitude,
                      type: LocationType.station.name,
                    ),
                  ),
                  builder: (context, snapshot2) {
                    return FlutterMap(
                      mapController: mapController.mapController,
                      options: MapOptions(
                        initialCenter: latLng,
                      ),
                      children: [
                        tileLayer(),
                        MarkerLayer(
                          markers: [
                            if (snapshot2.hasData)
                              ...stationMarkers(snapshot2.data!.stations),
                            geolocationMarker(latLng),
                          ],
                        ),
                        attributionWidget(),
                      ],
                    );
                  });
            } else {
              return Center(child: Text('No data'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Marker geolocationMarker(LatLng latLng) {
    return Marker(
        point: latLng,
        child: Icon(Icons.location_on, color: Colors.red),
        rotate: true);
  }

  Widget attributionWidget() {
    return RichAttributionWidget(
      // Include a stylish prebuilt attribution widget that meets all requirments
      attributions: [
        TextSourceAttribution(
          'OpenStreetMap contributors',
          onTap: () => launchUrl(
              Uri.parse('https://openstreetmap.org/copyright')), // (external)
        ),
      ],
    );
  }

  TileLayer tileLayer() {
    return TileLayer(
      // Display map tiles from any source
      urlTemplate:
          'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
      userAgentPackageName: 'com.wi42.swiss_transport',
      // And many more recommended properties!
    );
  }

  List<Marker> stationMarkers(List<Location> locations) {
    return [
      for (Location location in locations)
        if (location.coordinates?.x != null && location.coordinates?.y != null)
          Marker(
            point: LatLng(
              location.coordinates!.x!,
              location.coordinates!.y!,
            ),
            rotate: true,
            child: IconButton(
              icon: Icon(
                  location.icon == TransportVehicles.none
                      ? Icons.location_on
                      : location.icon.icon,
                  color: Color(0xFF003366)),
              onPressed: _onStationClicked(location),
            ),
          )
    ];
  }

  void Function() _onStationClicked(Location location) => () {
        mapController.animateTo(
            dest: LatLng(
              location.coordinates!.x!,
              location.coordinates!.y!,
            ),
            zoom: 17);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: <Widget>[
              Icon(location.icon.icon),
              Expanded(
                child: Text(
                  location.name ?? '<no name>',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ),
              if (location.distance != null) Text('${location.distance!}m'),
            ].withSpaceBetween(width: 12),
          ),
          showCloseIcon: true,
        ));
      };

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
