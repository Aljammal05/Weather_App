import 'dart:convert';

import 'package:weather_app/data/api_keys.dart';
import 'package:weather_app/data/geocoding/models/city_api_response.dart';
import 'package:weather_app/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class GeocodingApi {
  Future<List<CityApiResponse>> getCitiesGeocodingData({required String cityName}) async {
    final response = await http.get(Uri.parse(
        geocodingApiURL(cityName: cityName)),headers: {'X-Api-Key' : geocodingApiKey});
    final json = jsonDecode(response.body);
    final List<CityApiResponse> citiesApiResponsesList = [];
    json.forEach((cityJson){
      citiesApiResponsesList.add(CityApiResponse.fromJson(cityJson));
    });
    return citiesApiResponsesList;
  }
}