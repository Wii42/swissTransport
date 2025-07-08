import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cached_locations.dart';
import '../transport_api/enums/transport_vehicles.dart';
import '../transport_api/transport_api.dart';
import '../transport_api/transport_objects/location.dart';
import '../transport_api/transport_objects/stations.dart';

typedef LocationSuggestion = ({Location location, bool isFromHistory});

class AutocompleteLocationFormField extends StatelessWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const AutocompleteLocationFormField({
    super.key,
    this.controller,
    this.decoration,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<LocationSuggestion>(
      textEditingController: controller,
      focusNode: controller != null ? FocusNode() : null,
      fieldViewBuilder: _fieldViewBuilder,
      optionsBuilder: _optionsBuilder(context),
      optionsViewBuilder: _optionsViewBuilder,
      displayStringForOption: _displayStringForOption,
    );
  }

  Widget _fieldViewBuilder(
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      decoration: decoration,
      validator: validator,
      onSaved: onSaved,
    );
  }

  FutureOr<Iterable<LocationSuggestion>> Function(TextEditingValue)
      _optionsBuilder(BuildContext context) {
    return (TextEditingValue textEditingValue) async {
      final String nameQuery = textEditingValue.text.trim();
      if (nameQuery.isEmpty) {
        return const Iterable<LocationSuggestion>.empty();
      }
      CachedLocations cachedStations = context.read<CachedLocations>();
      Stations? cached = cachedStations.getLocationByName(nameQuery);
      if (cached != null) {
        return toLocationSuggestions(cached.stations);
      }
      Stations stations = await TransportApi().locations(query: nameQuery);
      cachedStations.addLocationByName(nameQuery, stations);
      return toLocationSuggestions(stations.stations);
    };
  }

  Widget _optionsViewBuilder(
      BuildContext context,
      void Function(LocationSuggestion) onSelected,
      Iterable<LocationSuggestion> options) {
    return Material(
      elevation: 4.0,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          LocationSuggestion option = options.toList()[index];
          Location location = option.location;
          return GestureDetector(
            onTap: () {
              onSelected(option);
            },
            child: ListTile(
              leading: option.isFromHistory ? const Icon(Icons.history) : null,
              title: Text(_displayStringForOption(option)),
              trailing: location.icon != TransportVehicles.none
                  ? Opacity(opacity: 0.5, child: Icon(location.icon.icon))
                  : null,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: options.length,
      ),
    );
  }

  String _displayStringForOption(LocationSuggestion suggestion) {
    return suggestion.location.name ?? suggestion.location.id ?? '?';
  }

  Iterable<LocationSuggestion> toLocationSuggestions(
      Iterable<Location> locations,
      {isFromHistory = false}) {
    return locations
        .map((location) => (location: location, isFromHistory: isFromHistory));
  }
}
