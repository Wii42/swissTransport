import 'package:flutter/material.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

class SavedConnections extends InheritedWidget {
  final List<Connection> savedConnections = [];

  SavedConnections({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant SavedConnections oldWidget) {
    return true;
  }

  static List<Connection>? of(BuildContext context) {
    SavedConnections? inherited =
        (context.dependOnInheritedWidgetOfExactType<SavedConnections>());
    return inherited?.savedConnections;
  }
}
