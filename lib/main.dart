import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sbb/routes.dart';
import 'package:sbb/saved_connections.dart';
import 'package:sbb/tab_app.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.home.string,
        builder: (context, state) => Routes.home.pageWrappedInScaffold(),
      ),
      GoRoute(
        path: Routes.connections.string,
        builder: (context, state) =>
            Routes.connections.pageWrappedInScaffold(state.extra),
      ),
      GoRoute(
        path: Routes.connection.string,
        builder: (context, state) =>
            Routes.connection.pageWrappedInScaffold(state.extra),
      ),
    ],
  );

  // This widget is the root of your application.
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
      routerConfig: _router,
    );
  }
}
