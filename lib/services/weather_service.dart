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
    try {
      // Step A: Hit the API.
      // http.get returns a Future<Response>.
      // 'await' pauses this function until the response comes back.
      final response = await http.get(Uri.parse(_baseUrl));

      // Step B: Check the status code.
      // 200 means "OK". Anything else means something went wrong.
      if (response.statusCode == 200) {
        // Step C: Decode the JSON string into a Dart Map (dynamic).
        final Map<String, dynamic> decodedJson = json.decode(response.body);

        // Step D: Use our Factory constructor to turn the Map into our Model.
        // The model extracts the nested 'current' data.
        final CurrentWeather weather = CurrentWeather.fromJson(decodedJson);

        // 🧪 DEBUGGING LINE
        // This prints the temperature to the console so you can see it works.
        // You can delete this line later, but keep it for now to verify.
        print('✅ Weather fetched successfully! Temp: ${weather.temperature}°C');

        // Step E: Return the clean object.
        return weather;
      } else {
        // If the status code is not 200, throw a descriptive error.
        throw Exception(
            'Failed to load weather. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // If the internet is off, or the URL is wrong, this catches it.
      // We re-throw the error so the UI can handle it (show an error message).
      print('❌ Error in WeatherService: $e');
      throw Exception('Network error: $e');
    }
  }
}
