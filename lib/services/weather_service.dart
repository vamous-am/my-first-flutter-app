// lib/services/weather_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

// Default location: Addis Ababa, Ethiopia
const double kDefaultLat = 8.9806;
const double kDefaultLon = 38.7578;

// Represents a geocoding result (city search hit)
typedef CityResult = ({
  String name,
  String country,
  double lat,
  double lon,
});

class WeatherService {
  static const String _forecastBase = 'https://api.open-meteo.com/v1/forecast';
  static const String _geocodingBase =
      'https://geocoding-api.open-meteo.com/v1/search';
  static const String _currentFields =
      'temperature_2m,relative_humidity_2m,apparent_temperature,'
      'precipitation,weather_code,wind_speed_10m,wind_direction_10m';

  // Fetch current weather for the given coordinates.
  // Defaults to Addis Ababa so existing callers need no changes.
  static Future<CurrentWeather> fetchCurrentWeather({
    double lat = kDefaultLat,
    double lon = kDefaultLon,
  }) async {
    final uri = Uri.parse(
      '$_forecastBase?latitude=$lat&longitude=$lon&current=$_currentFields',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return CurrentWeather.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load weather. Status code: ${response.statusCode}');
    }
  }

  // Search for a city by name. Returns up to 5 results.
  // Throws if the request fails; returns empty list if nothing found.
  static Future<List<CityResult>> searchCity(String query) async {
    final uri = Uri.parse(
      '$_geocodingBase?name=${Uri.encodeComponent(query)}&count=5&language=en&format=json',
    );
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Geocoding failed. Status code: ${response.statusCode}');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>? ?? [];

    return results.map((r) {
      return (
        name: r['name'] as String,
        country: r['country'] as String? ?? '',
        lat: (r['latitude'] as num).toDouble(),
        lon: (r['longitude'] as num).toDouble(),
      );
    }).toList();
  }
}
