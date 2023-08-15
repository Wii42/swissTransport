import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeHelper on DateTime {
  bool isToday() {
    DateTime today = DateTime.now();

    return isSameDate(today);
  }

  bool isSameDate(DateTime other) =>
      (year == other.year && month == other.month && day == other.day);

  static DateTime fromTimeOfDay(TimeOfDay time) =>
      DateTime(0, 0, 0, time.hour, time.minute);

  static DateFormat get dayMonthYear => DateFormat("dd.MM.yyyy");
}
