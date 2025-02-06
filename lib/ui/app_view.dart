import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../generic_ui_elements/widget_with_title.dart';
import 'home.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (newIndex) {
            // go to the initial Location of the branch, if active destination is clicked again.
            bool goToInitialLocation = newIndex == navigationShell.currentIndex;
            navigationShell.goBranch(newIndex,
                initialLocation: goToInitialLocation);
          },
          destinations: [
            for (WidgetWithTitle page in Home.bottomTabs)
              NavigationDestination(icon: Icon(page.icon), label: page.title)
          ],
        ));
  }
}