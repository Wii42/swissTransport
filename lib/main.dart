import 'package:flutter/material.dart';
import 'package:sbb/saved_connections.dart';
import 'package:sbb/tab_app.dart';
import 'package:sbb/transport_api/transport_api.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenTransport',
      theme: ThemeData(primarySwatch: Colors.red, brightness: Brightness.light),
      darkTheme:
          ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark),
      builder: (context, widget) => SavedConnections(child: const TestWidget()),
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
