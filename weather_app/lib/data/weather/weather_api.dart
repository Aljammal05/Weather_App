import 'dart:convert';

import 'package:weather_app/data/weather/models/weather_list_api_response.dart';
import 'package:weather_app/domain/entities/temperature_unit_enum.dart';
import 'package:weather_app/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class WeatherAPI {
  Future<WeatherListApiResponse> getWeatherData({
    required double latitude,
    required double longitude,
    TemperatureUnit unit = TemperatureUnit.celsius,
  }) async {
    final response = await http.get(Uri.parse(
        weatherApiURL(latitude: latitude, longitude: longitude, unit: unit)));
    final json = jsonDecode(response.body);
    final weatherListApiResponse = WeatherListApiResponse.fromJson(json);
    return weatherListApiResponse;
  }
}
