import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sbb/provider/cached_locations.dart';
import 'package:sbb/provider/location_history.dart';
import 'package:sbb/provider/saved_connections.dart';
import 'package:sbb/provider/touch_fahrplan_tiles.dart';
import 'package:sbb/ui/app_view.dart';
import 'package:sbb/ui/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db/app_database.dart';
import 'ui/home.dart';

late SharedPreferences sharedPreferences;
late AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = AppDatabase();
  await getSharedPrefs();
  runApp(const MyApp());
}

Future<void> getSharedPrefs() async {
  sharedPreferences = await SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SavedConnections>(
            create: (_) => SavedConnections(database: database),
          ),
          ChangeNotifierProvider<CachedLocations>(
              create: (_) => CachedLocations()),
          ChangeNotifierProvider<LocationHistory>(
              create: (_) => LocationHistory(database: database)),
          ChangeNotifierProvider(
            create: (_) => TouchFahrplanTiles(sharedPreferences),
          )
        ],
        child: MaterialApp.router(
            title: 'OpenTransport',
            themeMode: ThemeMode.system,
            theme: theme(Brightness.light),
            darkTheme: theme(Brightness.dark),
            routerConfig: routerConfig()));
  }

  ThemeData theme(Brightness brightness) {
    const MaterialAccentColor primary = Colors.blueAccent;
    ColorScheme scheme =
        ColorScheme.fromSeed(seedColor: primary, brightness: brightness);
    return ThemeData(
      colorScheme: scheme,
      primaryColor: primary,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  static List<GoRoute> goSubRoutes(List<Routes> routes) {
    return routes.map((route) => route.goRoute()).toList();
  }

  static GoRouter routerConfig() {
    List<Routes> sharedSubRoutes = [
      Routes.connections,
      Routes.connection,
      Routes.journey
    ];
    return GoRouter(
      routes: [
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return AppView(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(routes: [
                Routes.schedule.goRoute(
                  subRoutes: goSubRoutes(sharedSubRoutes),
                )
              ]),
              StatefulShellBranch(routes: [
                Routes.savedConnections
                    .goRoute(subRoutes: goSubRoutes(sharedSubRoutes))
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: '/apiTesting',
                  builder: (context, state) => Home.apiTestingPage(),
                )
              ])
            ]),
        Routes.connections.goRoute(),
      ],
      initialLocation: Routes.schedule.string,
    );
  }
}
