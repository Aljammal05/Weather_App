import 'package:weather_app/data/weather/api_keys.dart';
import 'package:weather_app/domain/entities/temperature_unit_enum.dart';

String weatherApiURL({
  required double latitude,
  required double longitude,
  TemperatureUnit unit = TemperatureUnit.celsius,
}) {
  String url;
  url =
      "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$weatherApiKey&units=${unit.value}";
  return url;
}

String geocodingApiURL({
  required String cityName,
}) {
  String url;
  url =
  "https://api.api-ninjas.com/v1/geocoding?city=$cityName";
  return url;
}
