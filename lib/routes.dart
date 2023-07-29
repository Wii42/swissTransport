import 'package:flutter/material.dart';

import 'connections_page/connections_page.dart';
import 'home.dart';

enum Routes {
  home(page: Home.inRoute, string: '/'),
  connections(page: ConnectionsPage.inRoute, string: '/connections'),
  connection(page: _connection, string: '/connection');

  final Widget Function([dynamic params]) page;
  final String string;

  const Routes({required this.page, required this.string});

  static Widget _connection([dynamic params]) => const Text('Connection');
}
