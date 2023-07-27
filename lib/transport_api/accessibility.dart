enum Accessibility {
  independentBoarding("independent_boarding"),
  assistedBoarding("assisted_boarding"),
  advancedNotice("advanced_notice");

  final String apiName;

  const Accessibility(this.apiName);
}
