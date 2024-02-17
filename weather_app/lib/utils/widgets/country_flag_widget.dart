import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class CountryFlagWidget extends StatelessWidget {
  const CountryFlagWidget({required this.country, super.key});

  final String? country;

  @override
  Widget build(BuildContext context) {
    return CountryFlag.fromCountryCode(
      country ?? 'JO',
      height: 27,
      width: 35,
      borderRadius: 10,
    );
  }
}
