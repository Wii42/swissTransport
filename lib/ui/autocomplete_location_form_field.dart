import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/app_database.dart';
import '../provider/cached_locations.dart';
import '../provider/location_history.dart';
import '../transport_api/enums/transport_vehicles.dart';
import '../transport_api/transport_api.dart';
import '../transport_api/transport_objects/location.dart';
import '../transport_api/transport_objects/stations.dart';

typedef LocationSuggestion = ({Location location, bool isFromHistory});

class AutocompleteLocationFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(LocationSuggestion)? onSelected;

  const AutocompleteLocationFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.validator,
    this.onSaved,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<LocationSuggestion>(
      textEditingController: controller,
      focusNode: focusNode,
      fieldViewBuilder: _fieldViewBuilder,
      optionsBuilder: _optionsBuilder(context),
      optionsViewBuilder: _optionsViewBuilder,
      displayStringForOption: _displayStringForOption,
      onSelected: onSelected,
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
    LocationHistory locationHistory = context.watch<LocationHistory>();
    CachedLocations cachedStations = context.watch<CachedLocations>();

    return (TextEditingValue textEditingValue) async {
      final String nameQuery = textEditingValue.text.trim();

      if (nameQuery.isEmpty) {
        List<LocationHistoryData> history = await locationHistory.getAsync();
        return toLocationSuggestionsFromHistory(history.take(10));
      }
      List<LocationSuggestion> suggestions = [];
      List<LocationHistoryData> history = await locationHistory.getAsync();
      suggestions.addAll(toLocationSuggestionsFromHistory(history.take(5).where(
          (loc) =>
              loc.location.name
                  ?.toLowerCase()
                  .contains(nameQuery.toLowerCase()) ??
              false)));

      Stations? cached = cachedStations.getLocationByName(nameQuery);
      if (cached != null) {
        suggestions.addAll(toLocationSuggestions(cached.stations));
      } else {
        Stations stations = await TransportApi().locations(query: nameQuery);
        cachedStations.addLocationByName(nameQuery, stations);
        suggestions.addAll(toLocationSuggestions(stations.stations));
      }
      return suggestions;
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

  Iterable<LocationSuggestion> toLocationSuggestionsFromHistory(
      Iterable<LocationHistoryData> history) {
    return history
        .map((data) => (location: data.location, isFromHistory: true));
  }
}
