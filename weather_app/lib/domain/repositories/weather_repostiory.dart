import 'dart:convert';

import 'package:weather_app/data/weather/models/weather_api_response.dart';
import 'package:weather_app/data/weather/models/weather_list_api_response.dart';
import 'package:weather_app/data/weather/weather_api.dart';
import 'package:weather_app/domain/entities/temperature_unit_enum.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/utils/demo_response.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getCurrentWeather({
    required double latitude,
    required double longitude,
    TemperatureUnit? unit,
  });

  Future<List<WeatherEntity>> get5DaysWeather({
    required double latitude,
    required double longitude,
    TemperatureUnit? unit,
  });
}

class OnlineWeatherRepository implements WeatherRepository {
  @override
  Future<List<WeatherEntity>> get5DaysWeather(
      {required double latitude,
      required double longitude,
      TemperatureUnit? unit}) async {
    try {
      final response = (await WeatherAPI().getWeatherData(
        latitude: latitude,
        longitude: longitude,
        unit: unit ?? TemperatureUnit.celsius,
      ));
      List<WeatherApiResponse> list5DaysWeathers = [];

      for (int i = 0; i < (response.cnt ?? -1); i++) {
        if (i % 8 == 0) {
          if (response.list?[i] != null) {
            list5DaysWeathers.add(response.list![i]);
          }
        }
      }

      return weatherEntitiesListFromWeatherResponses(list5DaysWeathers);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeatherEntity> getCurrentWeather(
      {required double latitude,
      required double longitude,
      TemperatureUnit? unit}) async {
    try {
      final response = (await WeatherAPI().getWeatherData(
        latitude: latitude,
        longitude: longitude,
        unit: unit ?? TemperatureUnit.celsius,
      ));

      return WeatherEntity.fromResponse(response.list![0]);
    } catch (e) {
      rethrow;
    }
  }
}

class OfflineWeatherRepository implements WeatherRepository {
  @override
  Future<List<WeatherEntity>> get5DaysWeather({
    required double latitude,
    required double longitude,
    TemperatureUnit? unit,
  }) async {
    try {
      final json = jsonDecode(DemoResponse.weatherResponse);
      final response = WeatherListApiResponse.fromJson(json);

      List<WeatherApiResponse> list5DaysWeathers = [];

      for (int i = 0; i < (response.cnt ?? -1); i++) {
        if (i % 8 == 0) {
          if (response.list?[i] != null) {
            list5DaysWeathers.add(response.list![i]);
          }
        }
      }

      return weatherEntitiesListFromWeatherResponses(list5DaysWeathers);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeatherEntity> getCurrentWeather({
    required double latitude,
    required double longitude,
    TemperatureUnit? unit,
  }) async {
    final fiveDaysWeather = await get5DaysWeather(
      latitude: latitude,
      longitude: longitude,
      unit: unit,
    );
    return fiveDaysWeather
        .firstWhere((weather) => weather.dateTime.isBefore(DateTime.now()));
  }
}
