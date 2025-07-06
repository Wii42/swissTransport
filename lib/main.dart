import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';
import 'package:sbb/ui/api_user.dart';
import 'package:sbb/ui/app_view.dart';
import 'package:sbb/ui/custom_page.dart';
import 'package:sbb/ui/routes.dart';
import 'package:sbb/ui/saved_connections.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/home.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    List<Routes> sharedSubRoutes = [
      Routes.connections,
      Routes.connection,
      Routes.journey
    ];
    final GoRouter router = GoRouter(
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
                  builder: (context, state) => CustomPage(
                    title: 'API Testing',
                    icon: Icons.api_outlined,
                    body: Center(
                      child: ApiUser<Connections>(
                        apiCall: TransportApi()
                            .connections(from: "Wengen", to: "Lauterbrunnen"),
                        displayResponse: Home.response,
                      ),
                    ),
                  ),
                )
              ])
            ]),
        Routes.connections.goRoute(),
      ],
      initialLocation: Routes.schedule.string,
    );
    return ChangeNotifierProvider(
        create: (_) => SavedConnections(sharedPrefs: sharedPreferences),
        child: MaterialApp.router(
            title: 'OpenTransport',
            themeMode: ThemeMode.system,
            theme: theme(Brightness.light),
            darkTheme: theme(Brightness.dark),
            routerConfig: router));
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

  List<GoRoute> goSubRoutes(List<Routes> routes) {
    return routes.map((route) => route.goRoute()).toList();
  }
}
