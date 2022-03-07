class Place {
  late double latitude;
  late double longitude;
  late String address;

  Place({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  Place.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
  }

  static Map<String, dynamic> toJson(Place value) => {
        'latitude': value.latitude,
        'longitude': value.longitude,
        'address': value.address,
      };
}
