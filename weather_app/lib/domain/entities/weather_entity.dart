import 'package:weather_app/data/weather/models/weather_api_response.dart';

class WeatherEntity {
  double temperature;
  double temperatureMin;
  double temperatureMax;
  int humidity;
  double windSpeed;
  String weatherCondition;
  String weatherConditionDesc;
  String weatherIconPath;
  DateTime dateTime;

  WeatherEntity({
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCondition,
    required this.weatherConditionDesc,
    required this.weatherIconPath,
    required this.dateTime,
  });

  factory WeatherEntity.fromResponse(WeatherApiResponse response) {
    return WeatherEntity(
      temperature: response.main?.temp ?? 0,
      temperatureMin: response.main?.tempMin ?? 0,
      temperatureMax: response.main?.tempMax ?? 0,
      humidity: response.main?.humidity ?? 0,
      windSpeed: response.wind?.speed ?? 0,
      weatherCondition: response.weather?[0].main ?? '',
      weatherConditionDesc: response.weather?[0].description ?? '',
      weatherIconPath:
          'assets/weather/${response.weather?[0].icon ?? '01d'}.png',
      dateTime: DateTime.fromMicrosecondsSinceEpoch(
          response.dt ?? DateTime.now().microsecondsSinceEpoch),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherEntity &&
          runtimeType == other.runtimeType &&
          temperature == other.temperature &&
          temperatureMin == other.temperatureMin &&
          temperatureMax == other.temperatureMax &&
          humidity == other.humidity &&
          windSpeed == other.windSpeed &&
          weatherCondition == other.weatherCondition &&
          weatherConditionDesc == other.weatherConditionDesc &&
          weatherIconPath == other.weatherIconPath &&
          dateTime == other.dateTime;

  @override
  int get hashCode =>
      temperature.hashCode ^
      temperatureMin.hashCode ^
      temperatureMax.hashCode ^
      humidity.hashCode ^
      windSpeed.hashCode ^
      weatherCondition.hashCode ^
      weatherConditionDesc.hashCode ^
      weatherIconPath.hashCode ^
      dateTime.hashCode;
}

List<WeatherEntity> weatherEntitiesListFromWeatherResponses(List<WeatherApiResponse> listResponses) =>
    List.from(
      listResponses.map(
            (response) => WeatherEntity.fromResponse(response),
      ),
    );

