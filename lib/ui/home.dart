import 'package:flutter/material.dart';
import 'package:sbb/generic_ui_elements/padded_card.dart';
import 'package:sbb/ui/saved_connections_page.dart';
import 'package:sbb/ui/tab_body.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';

import 'api_user.dart';
import 'custom_page.dart';
import 'custom_tabs_page.dart';
import 'fahrplan_page.dart';
import '../generic_ui_elements/widget_with_title.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const TransportApi api = TransportApi();

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: bottomTabs(),
    );
  }

  static Widget inRoute([dynamic params]) => const Home();

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

  static List<WidgetWithTitle> bottomTabs() {
    return [
      const CustomTabsPage(
        title: 'Planen',
        icon: Icons.travel_explore,
        tabs: [
          FahrplanPage(),
          TabBody(
            title: 'Touch-Fahrplan',
            body: Center(child: Text('Touch-Fahrplan')),
          ),
          TabBody(title: 'Karte', body: Center(child: Text('Karte'))),
        ],
      ),
      const CustomPage(
        title: 'Reisen',
        body: SavedConnectionsPage(),
        icon: Icons.label_important,
      ),
      const CustomPage(
          title: 'API Testing',
          icon: Icons.api_outlined,
          body: Center(
            child: Text('Api Testing was successful'),
          )
          //ApiUser<Connections>(
          //  apiCall: api.connections(from: "Wengen", to: "Lauterbrunnen"),
          //  displayResponse: _response,
          //),
          ),
    ];
  }
}
