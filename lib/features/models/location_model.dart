class LocationModel {
  final String longitude;
  final String latitude;
  final String address;

  LocationModel({
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        address: json['address'],
        longitude: json['longitude'],
        latitude: json['latitude']);
  }

  Map<String, dynamic> toJson() {
    return {'address': address, 'latitude': latitude, 'longitude': longitude};
  }
}
