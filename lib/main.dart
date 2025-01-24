import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return MaterialApp(
      title: 'OpenTransport',
      themeMode: ThemeMode.system,
      theme: theme(Brightness.light),
      darkTheme: theme(Brightness.dark),
      home: ChangeNotifierProvider(
        create: (_) => SavedConnections(sharedPrefs: sharedPreferences),
        child: const Home(),
      ),
    );
  }

  ThemeData theme(Brightness brightness) {
    const MaterialAccentColor primary = Colors.blueAccent;
    ColorScheme scheme = ColorScheme.fromSeed(seedColor: primary, brightness: brightness);
    return ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: primary, brightness: brightness),
        primaryColor: primary,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
