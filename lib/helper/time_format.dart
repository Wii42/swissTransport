import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../transport_api/helper/date_time_helper.dart';

class TimeFormat {
  late DateFormat dateFormat;

  TimeFormat([String? pattern, String? locale]) {
    dateFormat = DateFormat(pattern, locale);
  }

  String format(TimeOfDay time) {
    return dateFormat.format(DateTimeHelper.fromTimeOfDay(time));
  }

  factory TimeFormat.HHmm() => TimeFormat("HH:mm");
}
