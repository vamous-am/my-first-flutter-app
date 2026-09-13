// lib/widgets/weather_hero.dart

import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_icon_mapper.dart';

class WeatherHero extends StatelessWidget {
  final CurrentWeather weather;

  const WeatherHero({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final String imagePath = getWeatherImage(weather.weatherCode);
    final String description = getWeatherDescription(weather.weatherCode);

    return Column(
      children: [
        // --- Location ---
        const Text(
          'Addis Ababa',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const Text(
          'Ethiopia',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 12,
            letterSpacing: 0.3,
          ),
        ),

        const SizedBox(height: 16),

        // --- Weather Image ---
        Image.asset(
          imagePath,
          width: 120,
          height: 120,
          fit: BoxFit.contain,
          // If the image fails to load (wrong filename, not registered in pubspec),
          // this shows a fallback icon instead of a red error box.
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.cloud,
              size: 120,
              color: Colors.white54,
            );
          },
        ),

        const SizedBox(height: 16),

        // --- Temperature ---
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${weather.temperature.round()}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 64,
                fontWeight: FontWeight.w200,
                height: 1.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                '°C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // --- Condition Description ---
        Text(
          description,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          ),
        ),

        const SizedBox(height: 4),

        // --- Feels Like ---
        Text(
          'Feels like ${weather.apparentTemperature.round()}°C',
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
