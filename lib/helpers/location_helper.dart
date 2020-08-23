import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as UsingHttp;

// getting maps api key from environment variables
final googleApiKey = FlutterConfig.get('google_map_api');

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:green%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey";
  }

  static Future<String> getPlaceAddress(double lat, double, lng) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey";
    final response = await UsingHttp.get(url);
    return json.decode(response.body)['results'][0]['formatted_adddress'];
  }
}
