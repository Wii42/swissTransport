import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeHelper on DateTime {
  bool isToday() {
    DateTime today = DateTime.now();

    return (year == today.year && month == today.month && day == today.day);
  }

  static DateTime fromTimeOfDay(TimeOfDay time) =>
      DateTime(0, 0, 0, time.hour, time.minute);

  static DateFormat get dayMonthYear => DateFormat("dd.MM.yyyy");
}
