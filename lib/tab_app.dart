import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';

class TabApp extends StatelessWidget {
  final List<WidgetWithTitle> tabs;
  final Widget? body;

  const TabApp({super.key, required this.tabs, this.body});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: body  ?? const Center(child: Text('Etwas ist schiefgelaufen')),
    );
  }
}

class TabScaffold extends StatelessWidget {
  const TabScaffold({
    super.key,
    required this.tabs,
    required this.body,
  });

  final List<WidgetWithTitle> tabs;
  final Widget? body;

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
      body: body ?? const Center(child: Text('Etwas ist schiefgelaufen')),
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
