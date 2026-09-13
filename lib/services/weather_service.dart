// lib/services/weather_service.dart

import 'dart:convert'; // to turn the raw HTTP response into JSON (Map).
import 'package:http/http.dart'
    as http; // The http package to make the web request.
import '../models/weather_model.dart';

// The Service Class
class WeatherService {
  static const String _baseUrl =
      'https://api.open-meteo.com/v1/forecast?latitude=8.9806&longitude=38.7578&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m,wind_direction_10m';

  //The fetch function
  static Future<CurrentWeather> fetchCurrentWeather() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      return CurrentWeather.fromJson(decodedJson);
    } else {
      throw Exception(
          'Failed to load weather. Status code: ${response.statusCode}');
    }
  }
}
