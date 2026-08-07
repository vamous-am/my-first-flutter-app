// lib/widgets/hourly_forecast.dart

import 'package:flutter/material.dart';

// Static placeholder data for one hourly card
class _HourlyData {
  final String time;
  final String temperature;
  final String imagePath;

  const _HourlyData({
    required this.time,
    required this.temperature,
    required this.imagePath,
  });
}

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  // Placeholder cards matching the screenshot's "Now / 5pm / 6pm / 7pm" style.
  // These are static because the API only provides current weather.
  // The assignment explicitly sanctions placeholder data for this section.
  static const List<_HourlyData> _placeholderHours = [
    _HourlyData(
        time: 'Now', temperature: '14°', imagePath: 'assets/images/cloudy.png'),
    _HourlyData(
        time: '5pm', temperature: '13°', imagePath: 'assets/images/cloudy.png'),
    _HourlyData(
        time: '6pm', temperature: '12°', imagePath: 'assets/images/cloudy.png'),
    _HourlyData(
        time: '7pm', temperature: '11°', imagePath: 'assets/images/cloudy.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Section Header ---
        Row(
          children: [
            const Icon(Icons.access_time,
                color: Colors.white60, size: 16), // ← Reduced
            const SizedBox(width: 6), // ← Reduced
            const Text(
              'Hourly Forecast',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15, // ← Reduced from 16
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10), // ← Reduced from 16

        // --- Horizontal Scrolling Cards ---
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _placeholderHours.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final hour = _placeholderHours[index];
              return _HourlyCard(data: hour);
            },
          ),
        ),
      ],
    );
  }
}

class _HourlyCard extends StatelessWidget {
  final _HourlyData data;

  const _HourlyCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            data.time,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Image.asset(
            data.imagePath,
            width: 32,
            height: 32,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.cloud,
              color: Colors.white54,
              size: 28,
            ),
          ),
          Text(
            data.temperature,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
