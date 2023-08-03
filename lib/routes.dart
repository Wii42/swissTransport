import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sbb/connection_page/connection_page.dart';
import 'package:sbb/tab_scaffold.dart';

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

  Widget pageWrappedInScaffold([dynamic params]) {
    return TabScaffold(tabs: Home.bottomTabs(), body: page(params));
  }

  GoRoute get route {
    return GoRoute(
      path: string,
      pageBuilder: (context, state) => pageBuilder(state),
    );
  }

  Page pageBuilder(GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: pageWrappedInScaffold(state.extra),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
