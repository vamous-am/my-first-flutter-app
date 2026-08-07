// lib/models/weather_model.dart

class CurrentWeather {
  // The 'final' keyword means these values are set once when the object is created,
  final double temperature;
  final int humidity;
  final double apparentTemperature;
  final double precipitation;
  final int weatherCode;
  final double windSpeed;
  final int windDirection;

  // CONSTRUCTOR
  CurrentWeather({
    required this.temperature,
    required this.humidity,
    required this.apparentTemperature,
    required this.precipitation,
    required this.weatherCode,
    required this.windSpeed,
    required this.windDirection,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    return CurrentWeather(
      temperature: (current['temperature_2m'] as num).toDouble(),
      humidity: current['relative_humidity_2m'] as int,
      apparentTemperature: (current['apparent_temperature'] as num).toDouble(),
      precipitation: (current['precipitation'] as num).toDouble(),
      weatherCode: current['weather_code'] as int,
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      windDirection: current['wind_direction_10m'] as int,
    );
  }
}
