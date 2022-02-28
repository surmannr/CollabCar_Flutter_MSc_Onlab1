import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationHelper {
  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$lng&apiKey=bf928145edaa4291b0c7022331777575');

    final response = await http.get(url);
    return json.decode(response.body)['features'][0]['properties']['formatted'];
  }
}
