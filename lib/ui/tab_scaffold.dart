import 'package:flutter/material.dart';

import '../generic_ui_elements/widget_with_title.dart';

class TabScaffold extends StatelessWidget {
  const TabScaffold({
    super.key,
    required this.tabs,
    required this.body,
  });

  final Iterable<WidgetWithTitle> tabs;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: WidgetWithTitle.destinations(tabs)
        //child: TabBar(
        //  tabs: WidgetWithTitle.titleTabs(tabs),
        //  labelColor: Theme.of(context).textTheme.bodyMedium?.color,
        //),
      ),
      body: body,
      //TabBarView(
      //),
    );
  }


}
