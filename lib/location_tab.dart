import 'package:flutter/material.dart';
import 'package:sbb/padded_card.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';
import 'package:sbb/transport_api/transportation_vehicles.dart';

class LocationTab extends StatelessWidget {
  final Location location;

  const LocationTab({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return PaddedCard(
      inset: 5,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (location.name != null)
                Text(
                  location.name!,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              Text(location.toString()),
            ],
          ),
          if (location.icon != TransportationVehicles.none)
            Icon(
              location.icon.icon,
              size: 50,
            )
        ],
      ),
    );
  }
}
