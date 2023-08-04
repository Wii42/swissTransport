import 'package:flutter/material.dart';

enum TransportCapacity {
  low(Icons.no_accounts),
  medium(Icons.emoji_people),
  full(Icons.people);

  final IconData icon;

  const TransportCapacity(this.icon);
}
