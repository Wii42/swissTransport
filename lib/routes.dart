import 'package:flutter/material.dart';
import 'package:sbb/tab_body.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';
import 'package:sbb/widget_with_title.dart';
import 'package:sbb/custom_tabs_page.dart';
import 'package:sbb/custom_page.dart';

import 'api_user.dart';
import 'fahrplan_page.dart';

const CustomTabsPage planen = CustomTabsPage(
  title: 'Planen',
  icon: Icons.travel_explore,
  tabs: [FahrplanPage(), TabBody(title: 'Karte', body: Text('Karte'))],
);

const CustomPage apiTesting = CustomPage(
  title: 'API Testing',
  icon: Icons.api_outlined,
  body: ApiUser<Connections>(
    apiCall: _apiCall,
    displayResponse: _response,
  ),
);

Future<Connections> _apiCall() {
  return const TransportApi().connections(from: "Wengen", to: "Lauterbrunnen");
}

Widget _response(Connections data) {
  return ListView(
    //crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (Connection connection in data.connections!)
        Text(connection.toString()),
      //for (Location station in snapshot.data!.stations)
      //LocationTab(location: station),
    ],
  );
}

const List<WidgetWithTitle> tabs = [planen, apiTesting];

enum Routes {
  home(page: TabBarView(children: tabs), string: '/'),
  connections(page: Text('Connections'), string: '/connections'),
  connection(page: Text('Connection'), string: '/connection');

  final Widget page;
  final String string;

  const Routes({required this.page, required this.string});
}
