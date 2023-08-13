import 'package:flutter/material.dart';

import 'package:sbb/generic_ui_elements/widget_with_title.dart';
import 'package:sbb/ui/routes.dart';

class CustomNavigatorPage extends WidgetWithTitle {
  final Routes initialRoute;

  const CustomNavigatorPage({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return HeroControllerScope.none(
      child: Navigator(
        onGenerateInitialRoutes: (_, __) => [
          MaterialPageRoute<dynamic>(builder: (context) {
            return initialRoute.page();
          })
        ],
        initialRoute: initialRoute.string,
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
    );
  }

  @override
  IconData? get icon => initialRoute.page().icon;

  @override
  String get title => initialRoute.page().title;
}
