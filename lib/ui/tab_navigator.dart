import 'package:flutter/material.dart';
import 'package:sbb/ui/routes.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
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
    );
  }
}