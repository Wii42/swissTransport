import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sbb/provider/touch_fahrplan_tiles.dart';
import 'package:sbb/ui/autocomplete_location_form_field.dart';
import 'package:sbb/ui/touch_fahrplan_grid.dart';

import '../transport_api/transport_objects/location.dart';

class TouchFahrplanEditableGrid extends StatelessWidget {
  final int maxRows;

  const TouchFahrplanEditableGrid({super.key, required this.maxRows});

  @override
  Widget build(BuildContext context) {
    TouchFahrplanTiles tiles = context.watch<TouchFahrplanTiles>();
    int fillableRows = maxRows - tiles.historyTileRows - 1;
    return Padding(
      padding: const EdgeInsets.all(TouchFahrplanGridState.spacing),
      child: TouchFahrplanGridState.stationsGrid([
        placeHolderTile(Text("Dynamische Kacheln"),
            height: tiles.historyTileRows),
        ...tiles.stationTiles.map((tile) => removableTile(tile, context)),
        addNewTile(context),
        placeHolderTile(Text("Reserviert"))
      ], spacing: TouchFahrplanGridState.spacing),
    );
  }

  StaggeredGridTile removableTile(StationTile tile, BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: tile.crossAxisCellCount,
      mainAxisCellCount: tile.mainAxisCellCount,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Kachel entfernen"),
                    content: Text(
                        'Wollen Sie die Kachel "${tile.location.name}" wirklich entfernen?'),
                    actions: [
                      TextButton(
                          onPressed: () => context.pop(),
                          child: Text("Abbrechen")),
                      ElevatedButton(
                          onPressed: () {
                            TouchFahrplanTiles tiles =
                                context.read<TouchFahrplanTiles>();
                            tiles.remove(tile);
                            context.pop();
                          },
                          child: Text("Entfernen")),
                    ],
                  ));
        },
        child: GridTile(
          child: TouchFahrplanGridState.tileBody(tile.location.name ?? '?'),
        ),
      ),
    );
  }

  StaggeredGridTile addNewTile(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: GridTile(
        child: Center(
            child: TextButton(
          onPressed: () {
            showDialog(context: context, builder: (context) => NewTileDialog());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Icon(Icons.add_circle), Text("Kachel hinzufügen")],
          ),
        )),
      ),
    );
  }

  StaggeredGridTile placeHolderTile(Widget text, {int height = 1}) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 4,
      mainAxisCellCount: height,
      child: GridTile(
        child: Container(color: Colors.grey[600], child: Center(child: text)),
      ),
    );
  }
}

class NewTileDialog extends StatefulWidget {
  const NewTileDialog({
    super.key,
  });

  @override
  State<NewTileDialog> createState() => _NewTileDialogState();
}

class _NewTileDialogState extends State<NewTileDialog> {
  final formKey = GlobalKey<FormState>();

  Location? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        title: Text("Kachel hinzufügen"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedLocation != null)
              Text("Ausgewählte Station: ${selectedLocation!.name}"),
            AutocompleteLocationFormField(
              onSelected: (LocationSuggestion suggestion) {
                setState(() {
                  selectedLocation = suggestion.location;
                });
              },
              validator: (_) {
                if (selectedLocation == null) {
                  return "Bitte eine Station via Dropdown auswählen.";
                }
                return null;
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: Text("Abbrechen")),
          ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                TouchFahrplanTiles tiles = context.read<TouchFahrplanTiles>();
                assert(selectedLocation != null);
                tiles.add(StationTile(
                    location: selectedLocation!,
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1));
                context.pop();
              },
              child: Text("Speichern")),
        ],
      ),
    );
  }
}
