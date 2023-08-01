import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sbb/routes.dart';
import 'package:sbb/saved_connections.dart';
import 'package:sbb/tab_app.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialColor primary = Colors.blue;
    return MaterialApp.router(
      title: 'OpenTransport',
      theme: ThemeData(primarySwatch: primary, brightness: Brightness.light),
      darkTheme: ThemeData(primarySwatch: primary, brightness: Brightness.dark),
      builder: (context, widget) => SavedConnections(
        child: TabApp(
          tabs: Home.bottomTabs(),
          body: widget,
        ),
      ),
      routerConfig: GoRouter(
        initialLocation: Routes.home.string,
        routes: [
          Routes.home.route,
          Routes.connections.route,
          Routes.connection.route,
        ],
      ),
    );
  }
}
