import 'package:flutter/material.dart';
import 'package:sbb/connection_page/connection_page.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';
import 'package:sbb/ui/saved_connections_page.dart';
import 'package:sbb/ui/schedule_page.dart';
import 'package:sbb/ui/tab_scaffold.dart';

import '../connections_page/connections_page.dart';
import '../journey_page/journey_page.dart';
import 'home.dart';

enum Routes {
  home(page: Home.inRoute, string: '/'),
  connections(page: ConnectionsPage.inRoute, string: '/connections'),
  connection(page: ConnectionPage.inRoute, string: '/connection'),
  journey(page: JourneyPage.inRoute, string: '/journey'),
  schedule(page: SchedulePage.inRoute, string: '/schedule'),
  savedConnections(
      page: SavedConnectionsPage.inRoute, string: '/savedConnections');

  final WidgetWithTitle Function([dynamic params]) page;
  final String string;

  const Routes({required this.page, required this.string});

  Widget pageWrappedInScaffold([dynamic params]) {
    return TabScaffold(tabs: Home.bottomTabs, body: page(params));
  }
}
