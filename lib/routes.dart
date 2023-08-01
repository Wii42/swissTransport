import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sbb/connection_page/connection_page.dart';
import 'package:sbb/tab_app.dart';

import 'connections_page/connections_page.dart';
import 'home.dart';

enum Routes {
  home(page: Home.inRoute, string: '/'),
  connections(page: ConnectionsPage.inRoute, string: '/connections'),
  connection(page: ConnectionPage.inRoute, string: '/connection');

  final Widget Function([dynamic params]) page;
  final String string;

  const Routes({required this.page, required this.string});

  Future<T?> push<T extends Object?>(BuildContext context, {dynamic params}) {
    return context.push(string, extra: params);
  }

  Widget pageWrappedInScaffold([dynamic params]){
    return TabScaffold(tabs: Home.bottomTabs(), body: page(params));
  }
}
