import 'package:flutter/material.dart';
import 'package:sbb/ui/routes.dart';
import 'package:sbb/ui/saved_connections_widget.dart';

import 'custom_navigator_page.dart';
import 'custom_page.dart';

class SavedConnectionsPage extends CustomPage {
  const SavedConnectionsPage({
    super.key,
  }) : super(
    title: 'Reisen',
    body: const SavedConnectionsWidget(),
    icon: Icons.label_important,
  );

  factory SavedConnectionsPage.inRoute([dynamic params]) =>
      const SavedConnectionsPage();
}

class SavedConnectionsNavigatorPage extends CustomNavigatorPage {
  const SavedConnectionsNavigatorPage({super.key})
      : super(initialRoute: Routes.savedConnections);
}