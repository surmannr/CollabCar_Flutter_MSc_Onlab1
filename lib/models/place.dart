class Place {
  final double latitude;
  final double longitude;
  final String address;

  Place({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  static Map<String, dynamic> toJson(Place value) => {
        'latitude': value.latitude,
        'longitude': value.longitude,
        'address': value.address,
      };
}
