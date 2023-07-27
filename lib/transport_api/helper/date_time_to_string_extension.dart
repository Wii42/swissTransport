import 'package:intl/intl.dart';

extension DateTimeToString on DateTime {
  String get localTimeString {
    return DateFormat("HH:mm").format(toLocal());
  }
}
