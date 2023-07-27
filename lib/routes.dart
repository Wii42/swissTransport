import 'package:flutter/material.dart';
import 'package:sbb/tab_body.dart';
import 'package:sbb/widget_with_title.dart';

import 'fahrplan_page.dart';

const List<WidgetWithTitle> tabs = [
  FahrplanPage(),
  TabBody(title: 'Karte', body: Text('Karte'))
];

enum Routes {
  home(
      page: TabBarView(children: [
        FahrplanPage(),
        TabBody(title: 'Karte', body: Text('Karte'))
      ]),
      string: '/'),
  connections(page: Text('Connections'), string: '/connections'),
  connection(page: Text('Connection'), string: '/connection');

  final Widget page;
  final String string;

  const Routes({required this.page, required this.string});
}
