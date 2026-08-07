// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/weather_hero.dart';
import '../widgets/metrics_row.dart';
import '../widgets/hourly_forecast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CurrentWeather? _weather;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final weather = await WeatherService.fetchCurrentWeather();
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildStatusBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Clock
          const Text(
            '9:41',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          // Right side: signal + wifi + battery
          Row(
            children: [
              // Signal bars — built from 3 small containers of increasing height
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(3, (i) {
                  return Container(
                    width: 4,
                    height: 6.0 + (i * 3),  // 6, 9, 12
                    margin: const EdgeInsets.only(left: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: i == 0 ? 0.4 : 1.0),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  );
                }),
              ),
              const SizedBox(width: 6),
              // WiFi icon
              const Icon(Icons.wifi, color: Colors.white, size: 14),
              const SizedBox(width: 6),
              // Battery
              Container(
                width: 22,
                height: 11,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(1.5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Battery tip nub
              Container(
                width: 2,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(1),
                    bottomRight: Radius.circular(1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Hamburger menu
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (_) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    width: 18,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Calendar icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No SafeArea or Padding here — Stack handles layout directly
      body: Stack(
        children: [
          // --- Main Scrollable Content ---
          SafeArea(
            child: SingleChildScrollView(
              // Bottom padding so content doesn't hide behind the floating nav bar
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
                bottom: 100, // clears the floating nav bar height
              ),
              child: _buildContent(),
            ),
          ),

          // --- Floating Bottom Nav Bar ---
          Positioned(
            bottom: 16,
            left: 24,
            right: 24,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const SizedBox(
        height: 500,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Loading weather...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return SizedBox(
        height: 500,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 48),
              const SizedBox(height: 16),
              Text(
                'Error: $_errorMessage',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loadWeather,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_weather == null) {
      return const SizedBox(
        height: 500,
        child: Center(
          child: Text(
            'No weather data',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatusBar(),
        _buildAppHeader(),
        WeatherHero(weather: _weather!),
        const SizedBox(height: 16),
        MetricsRow(weather: _weather!),
        const SizedBox(height: 24),
        const HourlyForecast(),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        // Dark semi-transparent pill matching the screenshot
        color: const Color(0xFF1E1E3A).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavIcon(Icons.home_rounded, isActive: true),
          _buildNavIcon(Icons.search_rounded),
          _buildNavIcon(Icons.notifications_none_rounded),
          _buildNavIcon(Icons.map_outlined),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, {bool isActive = false}) {
    return Icon(
      icon,
      color: isActive ? Colors.white : Colors.white38,
      size: 26,
    );
  }
}
