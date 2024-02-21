import 'dart:convert';

import 'package:weather_app/data/geocoding/geocoding_api.dart';
import 'package:weather_app/data/geocoding/models/city_api_response.dart';
import 'package:weather_app/domain/entities/city_entity.dart';
import 'package:weather_app/utils/demo_response.dart';

abstract class CitiesRepository {
  Future<List<CityEntity>> getCities({
    required String cityName,
  });
}

class OnlineCitiesRepository implements CitiesRepository {
  @override
  Future<List<CityEntity>> getCities({required String cityName}) async {
    try {
      final response =
          (await GeocodingApi().getCitiesGeocodingData(cityName: cityName));

      return cityEntitiesListFromCitiesResponses(response);
    } catch (e) {
      rethrow;
    }
  }
}

class OfflineCitiesRepository implements CitiesRepository {
  @override
  Future<List<CityEntity>> getCities({required String cityName}) async {
    final json = jsonDecode(DemoResponse.geocodingResponse);
    final List<CityEntity> citiesList = [];
    json.forEach((cityJson) {
      citiesList.add(
        CityEntity.fromResponse(
          CityApiResponse.fromJson(cityJson),
        ),
      );
    });
    return citiesList;
  }
}
