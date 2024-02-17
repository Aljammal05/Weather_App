import 'package:flutter/material.dart';
import 'package:weather_app/data/geocoding/models/city_api_response.dart';
import 'package:weather_app/utils/widgets/country_flag_widget.dart';

class CityEntity {
  String name;
  double latitude;
  double longitude;
  Widget countryFlag;
  String? state;

  CityEntity({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.countryFlag,
    this.state,
  });

  factory CityEntity.fromResponse(CityApiResponse response) {
    return CityEntity(
        name: response.name ?? 'Amman',
        latitude: response.latitude ?? 31.9539,
        longitude: response.longitude ?? 35.9106,
        countryFlag: CountryFlagWidget(country: response.country),
        state: response.state);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityEntity &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          countryFlag == other.countryFlag &&
          state == other.state;

  @override
  int get hashCode =>
      name.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      countryFlag.hashCode ^
      state.hashCode;
}
