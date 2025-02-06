import 'package:flutter/material.dart';
import 'package:sbb/ui/routes.dart';
import 'package:sbb/ui/tab_body.dart';

import 'custom_navigator_page.dart';
import 'custom_tabs_page.dart';
import 'fahrplan_page.dart';
import 'map_page.dart';

class SchedulePage extends CustomTabsPage {
  const SchedulePage({
    super.key,
  }) : super(
          title: 'Planen',
          icon: Icons.travel_explore,
          tabs: const [
            FahrplanPage(),
            TabBody(
              title: 'Touch-Fahrplan',
              body: Center(child: Text('Touch-Fahrplan')),
            ),
            MapPage(),
          ],
        );

  factory SchedulePage.inRoute([dynamic params]) => const SchedulePage();
}

class ScheduleNavigatorPage extends CustomNavigatorPage {
  const ScheduleNavigatorPage({super.key})
      : super(initialRoute: Routes.schedule);
}
