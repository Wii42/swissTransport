import 'package:flutter/material.dart';
import 'package:sbb/routes.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';

class TabApp extends StatelessWidget {
  final List<WidgetWithTitle> tabs;
  const TabApp({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            tabs: WidgetWithTitle.titleTabs(tabs),
          ),
        ),
        body: Navigator(
          onGenerateRoute: (settings) {
            late Widget page;
            for (Routes route in Routes.values) {
              if (settings.name == route.string) {
                page = route.page(settings.arguments);
              }
            }

            return MaterialPageRoute<dynamic>(
              builder: (context) {
                return page;
              },
              settings: settings,
            );
          },
        ),
        //TabBarView(
        // children: tabs
        //),
      ),
    );
  }
}
