import 'package:flutter/material.dart';
import 'package:sbb/tab_app.dart';
import 'package:sbb/transport_api/transport_api.dart';

import 'home.dart';

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
      builder: (context, widget) => const TestWidget(),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  final TransportApi api = const TransportApi();

  @override
  Widget build(BuildContext context) {
    return TabApp(
      tabs: Home.bottomTabs(),
    );
  }
}
