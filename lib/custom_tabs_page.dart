import 'package:flutter/material.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';

import 'custom_page.dart';

class CustomTabsPage extends WidgetWithTitle {
  @override
  final String title;

  @override
  final IconData? icon;

  final List<WidgetWithTitle> tabs;

  const CustomTabsPage({
    super.key,
    required this.title,
    required this.tabs,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: CustomPage(
        title: title,
        body: TabBarView(children: tabs),
        tabBar: TabBar(
          tabs: WidgetWithTitle.titleTabs(tabs),
        ),
      ),
    );
  }
}
