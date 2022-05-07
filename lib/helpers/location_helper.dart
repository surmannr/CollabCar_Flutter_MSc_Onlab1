import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class LocationHelper {
  UserLocation? _userLocation;

  var location = Location();

  Future<UserLocation?> getLocation() async {
    try {
      var userlocation = await location.getLocation();
      _userLocation = UserLocation(
          latitude: userlocation.latitude!, longitude: userlocation.longitude!);
    } catch (e) {
      print("Could not get the location");
    }
    return _userLocation;
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$lng&apiKey=bf928145edaa4291b0c7022331777575');

    final response = await http.get(url);
    return json.decode(response.body)['features'][0]['properties']['formatted'];
  }
}

class UserLocation {
  final double latitude;
  final double longitude;

  UserLocation({required this.latitude, required this.longitude});
}
