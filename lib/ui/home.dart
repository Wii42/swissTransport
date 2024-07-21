import 'package:flutter/material.dart';
import 'package:sbb/generic_ui_elements/padded_card.dart';
import 'package:sbb/ui/saved_connections_page.dart';
import 'package:sbb/ui/schedule_page.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';

import 'api_user.dart';
import 'custom_page.dart';
import '../generic_ui_elements/widget_with_title.dart';

class Home extends StatefulWidget with WidgetWithTitle {
  static const TransportApi api = TransportApi();

  @override
  final String title = 'Home';

  @override
  final IconData icon = Icons.home;

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  factory Home.inRoute([dynamic params]) => const Home();

  static Widget _response(Connections data) {
    return ListView(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (Connection connection in data.connections!)
          PaddedCard(child: Text(connection.toString())),
        //for (Location station in snapshot.data!.stations)
        //LocationTab(location: station),
      ],
    );
  }

  static List<WidgetWithTitle> bottomTabs = [
    const ScheduleNavigatorPage(),
    const SavedConnectionsNavigatorPage(),
    CustomPage(
      title: 'API Testing',
      icon: Icons.api_outlined,
      body: Center(
        child:
            //  child: Text('Api Testing was successful'),
            //)
            ApiUser<Connections>(
          apiCall: api.connections(from: "Wengen", to: "Lauterbrunnen"),
          displayResponse: _response,
        ),
      ),
    ),
  ];
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          for (WidgetWithTitle page in Home.bottomTabs)
            NavigationDestination(icon: Icon(page.icon), label: page.title)
        ],
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: Home.bottomTabs[selectedIndex],
    );
  }
}
