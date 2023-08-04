import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../generic_ui_elements/widget_with_title.dart';

class TabScaffold extends StatelessWidget {
  const TabScaffold({
    super.key,
    required this.tabs,
    required this.body,
  });

  final List<WidgetWithTitle> tabs;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          onTap: returnToHome(context),
          tabs: WidgetWithTitle.titleTabs(tabs),
          labelColor: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      body: body,
      //TabBarView(
      //),
    );
  }

  void Function(int) returnToHome(BuildContext context) {
    return (_) {
      while (context.canPop()) {
        context.pop();
      }
    };
  }
}
