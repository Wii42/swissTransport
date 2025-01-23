import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbb/ui/routes.dart';
import 'package:sbb/ui/saved_connections.dart';
import 'package:sbb/ui/tab_app.dart';
import 'package:sbb/ui/tab_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generic_ui_elements/widget_with_title.dart';
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
    MaterialColor primary = Colors.blue;
    return MaterialApp(
      title: 'OpenTransport',
      theme: ThemeData(primarySwatch: primary, brightness: Brightness.light),
      darkTheme: ThemeData(primarySwatch: primary, brightness: Brightness.dark),
      home: ChangeNotifierProvider(
        create: (_) => SavedConnections(sharedPrefs: sharedPreferences),
        child: const Home(),
      ),
    );
  }
}
