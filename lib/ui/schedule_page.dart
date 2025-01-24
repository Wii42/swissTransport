import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/ui/routes.dart';
import 'package:sbb/ui/tab_body.dart';
import 'package:url_launcher/url_launcher.dart';

import '../location.dart';
import '../transport_api/enums/location_type.dart';
import '../transport_api/enums/transport_vehicles.dart';
import '../transport_api/transport_objects/coordinates.dart';
import '../transport_api/transport_objects/location.dart';
import 'custom_navigator_page.dart';
import 'custom_tabs_page.dart';
import 'fahrplan_page.dart';
import '../generic_ui_elements/with_space_between.dart';

class SchedulePage extends CustomTabsPage {
  const SchedulePage({
    super.key,
  }) : super(
          title: 'Planen',
          icon: Icons.travel_explore,
          tabs: const [
            FahrplanPage(),
            TabBody(
              title: 'Touch-Fahrplan',
              body: Center(child: Text('Touch-Fahrplan')),
            ),
            MapPage(),
          ],
        );

  factory SchedulePage.inRoute([dynamic params]) => const SchedulePage();
}

class ScheduleNavigatorPage extends CustomNavigatorPage {
  const ScheduleNavigatorPage({super.key})
      : super(initialRoute: Routes.schedule);
}

class MapPage extends StatefulWidget with WidgetWithTitle {
  const MapPage({super.key});

  @override
  IconData? get icon => null;

  @override
  String get title => "Karte";

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController = MapController();
  @override
  Widget build(BuildContext context) {
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
                    if (snapshot2.hasData) {
                      print(snapshot2.data);
                    }
                    return FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        initialCenter: latLng,
                      ),
                      children: [
                        TileLayer(
                          // Display map tiles from any source
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                          userAgentPackageName: 'com.wi42.swiss_transport',
                          // And many more recommended properties!
                        ),
                        MarkerLayer(
                          markers: [
                            if (snapshot2.hasData)
                              for (Location location
                                  in snapshot2.data!.stations)
                                if (location.coordinates?.x != null &&
                                    location.coordinates?.y != null)
                                  Marker(
                                    point: LatLng(
                                      location.coordinates!.x!,
                                      location.coordinates!.y!,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                          location.icon ==
                                                  TransportVehicles.none
                                              ? Icons.location_on
                                              : location.icon.icon,
                                          color: Color(0xFF003366)),
                                      onPressed: () {
                                        mapController.move(
                                            LatLng(
                                              location.coordinates!.x!,
                                              location.coordinates!.y!,
                                            ),
                                            17);
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Row(
                                            children: <Widget>[
                                              Icon(location.icon.icon),
                                              Text(
                                                  location.name ?? '<no name>', style: TextStyle(fontWeight: FontWeight.bold),),
                                              if (location.distance != null)
                                                Text('${location.distance!}m'),
                                            ].withSpaceBetween(width: 12),
                                          ),
                                          showCloseIcon: true,
                                        ));
                                      },
                                    ),
                                  ),
                            Marker(
                              point: latLng,
                              child: Icon(Icons.location_on, color: Colors.red),
                            ),
                          ],
                        ),
                        RichAttributionWidget(
                          // Include a stylish prebuilt attribution widget that meets all requirments
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () => launchUrl(Uri.parse(
                                  'https://openstreetmap.org/copyright')), // (external)
                            ),
                          ],
                        ),
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
}
