import 'package:flutter/material.dart';
import 'package:sbb/api_user.dart';
import 'package:sbb/custom_page.dart';
import 'package:sbb/custom_tabs_page.dart';
import 'package:sbb/fahrplan_page.dart';
import 'package:sbb/tab_app.dart';
import 'package:sbb/tab_body.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';
import 'package:sbb/transport_api/transport_api.dart';

void main() {
  //TransportApi api = const TransportApi();
  //api.connections(from: 'Wengen', to: "Lauterbrunnen");
  //api.locations(query: 'Wengen');
  //api.stationBoard(station: "Wengen");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.red, brightness: Brightness.light),
      darkTheme:
          ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      builder:  (context, widget)=> const TestWidget(),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  final TransportApi api = const TransportApi();

  @override
  Widget build(BuildContext context) {
    return TabApp(
      tabs: [
        const CustomTabsPage(
          title: 'Planen',
          icon: Icons.travel_explore,
          tabs: [FahrplanPage(), TabBody(title: 'Karte', body: Text('Karte'))],
        ),
        CustomPage(
          title: 'API Testing',
          icon: Icons.api_outlined,
          body: ApiUser<Connections>(
            apiCall: api.connections(from: "Wengen", to: "Lauterbrunnen"),
            displayResponse: (data) {
              return ListView(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (Connection connection in data.connections!)
                    Text(connection.toString()),
                  //for (Location station in snapshot.data!.stations)
                  //LocationTab(location: station),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
