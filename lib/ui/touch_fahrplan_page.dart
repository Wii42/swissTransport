import 'package:flutter/material.dart';
import 'package:sbb/ui/touch_fahrplan_editable_grid.dart';
import 'package:sbb/ui/touch_fahrplan_grid.dart';

import '../generic_ui_elements/widget_with_title.dart';

class TouchFahrplanPage extends StatefulWidget with WidgetWithTitle {
  const TouchFahrplanPage({super.key});

  @override
  String get title => 'Touch-Fahrplan';

  @override
  IconData? get icon => null;

  @override
  State<TouchFahrplanPage> createState() => _TouchFahrplanPageState();
}

class _TouchFahrplanPageState extends State<TouchFahrplanPage> {
  bool _editMode = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _editMode
            ? TouchFahrplanEditableGrid(
                maxRows: 6,
              )
            : TouchFahrplanGrid(),
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton.icon(
            onPressed: () => setState(() {
              _editMode = !_editMode;
            }),
            label: Text(_editMode ? "Fertig" : "Bearbeiten"),
            icon: Icon(_editMode ? Icons.done : Icons.edit),
          ),
        )
      ],
    );
  }
}
