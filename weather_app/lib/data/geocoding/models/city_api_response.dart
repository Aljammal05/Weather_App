class CityApiResponse {
  String? name;
  double? latitude;
  double? longitude;
  String? country;
  String? state;

  CityApiResponse(
      {this.name, this.latitude, this.longitude, this.country, this.state});

  CityApiResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    latitude = json['latitude'].toDouble();
    longitude = json['longitude'].toDouble();
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}
