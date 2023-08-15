enum Weekday {
  monday(dayNr: 1, fullName: 'Montag', shortName: 'Mo'),
  tuesday(dayNr: 2, fullName: 'Dienstag', shortName: 'Di'),
  wednesday(dayNr: 3, fullName: 'Mittwoch', shortName: 'Mi'),
  thursday(dayNr: 4, fullName: 'Donnerstag', shortName: 'Do'),
  friday(dayNr: 5, fullName: 'Freitag', shortName: 'Fr'),
  saturday(dayNr: 6, fullName: 'Samstag', shortName: 'Sa'),
  sunday(dayNr: 7, fullName: 'Sonntag', shortName: 'So');

  final String fullName, shortName;
  final int dayNr;

  const Weekday(
      {required this.dayNr, required this.fullName, required this.shortName});

  factory Weekday.byNrOfDay(int weekday) {
    for (Weekday day in values) {
      if (day.dayNr == weekday) {
        return day;
      }
    }
    throw Exception(
        '$weekday is not in range 1-7 and is therefore not a weekday');
  }
}
