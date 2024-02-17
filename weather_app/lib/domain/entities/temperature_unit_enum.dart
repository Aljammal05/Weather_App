enum TemperatureUnit {
  fahrenheit('imperial'),
  celsius('metric');

  const TemperatureUnit(this.value);

  final String value;
}
