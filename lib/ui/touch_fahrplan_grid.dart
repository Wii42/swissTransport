import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sbb/helper/go_subroute_extension.dart';
import 'package:sbb/provider/touch_fahrplan_tiles.dart';
import 'package:sbb/ui/routes.dart';

import '../db/app_database.dart';
import '../location.dart';
import '../provider/location_history.dart';
import '../transport_api/enums/location_type.dart';
import '../transport_api/transport_api.dart';
import '../transport_api/transport_objects/connections.dart';
import '../transport_api/transport_objects/coordinates.dart';
import '../transport_api/transport_objects/location.dart';
import '../transport_api/transport_objects/stations.dart';

class TouchFahrplanGrid extends StatefulWidget {
  const TouchFahrplanGrid({super.key});

  @override
  State<TouchFahrplanGrid> createState() => TouchFahrplanGridState();
}

class TouchFahrplanGridState extends State<TouchFahrplanGrid> {
  static String currentLocation = "Aktueller Standort";
  static const String from = "von";
  static const String to = "nach";

  static const double spacing = 5;

  String? _dragSourceStation;

  @override
  Widget build(BuildContext context) {
    LocationHistory locationHistory = context.watch<LocationHistory>();
    TouchFahrplanTiles touchFahrplanTiles = context.watch<TouchFahrplanTiles>();
    Iterable<StationTile> manuallyAddedLocations =
        touchFahrplanTiles.stationTiles;

    Iterable<LocationHistoryData> historyLocations =
        locationHistory.locationHistory.whereNot((h) =>
            h.location.name == null ||
            h.location.name!.isEmpty ||
            manuallyAddedLocations
                .any((m) => h.location.nameCompare(m.location)));
    return Padding(
      padding: const EdgeInsets.all(spacing),
      child: Column(
        children: [
          stationsGrid([
            ...historyLocations
                .take(2 * touchFahrplanTiles.historyTileRows)
                .map((h) => stationTile(
                    stationName: h.location.name ?? h.location.id ?? '?',
                    crossAxisCellCount: 2,
                    icon: Icons.history)),
            ...manuallyAddedLocations.map((m) => stationTile(
                stationName: m.location.name ?? m.location.id ?? '?',
                crossAxisCellCount: m.crossAxisCellCount,
                mainAxisCellCount: m.mainAxisCellCount)),
          ], spacing: spacing),
          SizedBox(height: spacing),
          stationsGrid([
            stationTile(
                stationName: currentLocation,
                icon: Icons.my_location_outlined,
                crossAxisCellCount: 2),
            stationTile(stationName: from, icon: Icons.start),
            stationTile(stationName: to, icon: Icons.arrow_forward),
          ], spacing: spacing)
        ],
      ),
    );
  }

  StaggeredGridTile stationTile(
      {required String stationName,
      IconData? icon,
      int mainAxisCellCount = 1,
      int crossAxisCellCount = 1}) {
    return StaggeredGridTile.count(
      crossAxisCellCount: crossAxisCellCount,
      mainAxisCellCount: mainAxisCellCount,
      child: GridTile(
          child: DragTarget<String>(
        onAcceptWithDetails: (details) {
          log("launch connection ${details.data} -> $stationName");
          showConnections(details.data, stationName);
        },
        onWillAcceptWithDetails: (details) => details.data != stationName,
        builder: (context, candidateData, rejectedData) {
          bool darken = _dragSourceStation != null &&
              _dragSourceStation != stationName &&
              candidateData.isEmpty;
          return Draggable<String>(
              maxSimultaneousDrags: _dragSourceStation == null ||
                      _dragSourceStation != stationName
                  ? 1
                  : 0,
              data: stationName,
              dragAnchorStrategy: pointerDragAnchorStrategy,
              onDragStarted: () {
                if (_dragSourceStation == null) {
                  setState(() {
                    _dragSourceStation = stationName;
                    log("Drag started from $_dragSourceStation");
                  });
                }
              },
              onDragEnd: (_) {
                if (_dragSourceStation == stationName) {
                  setState(() {
                    log("Drag ended from $_dragSourceStation");
                    _dragSourceStation = null;
                  });
                }
              },
              feedback: Icon(Icons.circle, size: 16, color: Colors.blue),
              child: Opacity(
                opacity: darken ? 0.5 : 1.0,
                child: tileBody(stationName, icon: icon),
              ));
        },
      )),
    );
  }

  static Container tileBody(String stationName, {IconData? icon}) {
    return Container(
        color: Colors.grey[800],
        child: Column(
          children: [
            Expanded(
                child: (icon != null)
                    ? Opacity(opacity: 0.5, child: Center(child: Icon(icon)))
                    : Container()),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    stationName,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
          ],
        ));
  }

  static StaggeredGrid stationsGrid(List<StaggeredGridTile> stations,
      {double spacing = 0}) {
    return StaggeredGrid.count(
      axisDirection: AxisDirection.down,
      crossAxisCount: 4,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: stations,
    );
  }

  void showConnections(String from, String to) {
    Future<Connections> connections = createRequest(from: from, to: to);
    LocationHistory.saveEndpointsOfConnectionsRequest(context, connections);
    context.pushSubRoute(Routes.connections.string, extra: connections);
    //pushRoute(routeName: Routes.connections.string, connections: connections);
  }

  Future<Connections> createRequest(
      {required String from, required String to}) async {
    TransportApi api = const TransportApi();
    if (from == currentLocation) {
      String closestStation = await getClosestStationName();
      log('Closest station as "from": $closestStation');
      from = closestStation;
    } else if (to == currentLocation) {
      String closestStation = await getClosestStationName();
      log('Closest station as "to": $closestStation');
      to = closestStation;
    }
    String fromKey = TouchFahrplanGridState.from;
    String toKey = TouchFahrplanGridState.to;
    bool hasEmptyFrom = from == toKey || from == fromKey;
    bool hasEmptyTo = to == toKey || to == fromKey;
    if (hasEmptyFrom || hasEmptyTo) {
      log('Incomplete query: from: $from, to: $to');
      return Future.value(Connections(
          connections: [],
          from: Location(name: hasEmptyFrom ? null : from),
          to: hasEmptyTo ? null : Location(name: hasEmptyTo ? null : to)));
    }
    log('Creating request from: $from to: $to');
    return api.connections(from: from, to: to, limit: 10);
  }

  Future<String> getClosestStationName() async {
    Position position = await determinePosition();
    log('Position: $position');
    Stations closeStations = await TransportApi().locations(
      coordinates: Coordinates(
        x: position.longitude,
        y: position.latitude,
        type: LocationType.all.name,
      ),
    );
    Iterable<Location> stationsWithDistance =
        closeStations.stations.where((s) => s.distance != null);
    return stationsWithDistance
            .sortedByCompare(
                (s) => s.distance!, (a, b) => a.compareTo(b)) // reverse order
            .firstOrNull
            ?.name ??
        closeStations.stations.firstOrNull?.name ??
        '';
  }
}
