// lib/services/weather_icon_mapper.dart

String getWeatherImage(int code) {
  if (code == 0 || code == 1) {
    return 'assets/images/sunny.png';
  }
  // 2 = Partly cloudy, 3 = Overcast, 45/48 = Fog
  else if (code == 2 || code == 3 || code == 45 || code == 48) {
    return 'assets/images/cloudy.png';
  }
  // 51-67 = Drizzle/Rain, 80-82 = Rain showers, 95-99 = Thunderstorm
  else if ((code >= 51 && code <= 67) ||
      (code >= 80 && code <= 82) ||
      (code >= 95 && code <= 99)) {
    return 'assets/images/rainy.png';
  } else {
    return 'assets/images/cloudy.png';
  }
}

String getWeatherDescription(int code) {
  if (code == 0 || code == 1) {
    return 'Clear skies today';
  } else if (code == 2 || code == 3) {
    return 'Cloudy skies today';
  } else if (code == 45 || code == 48) {
    return 'Foggy conditions today';
  } else if ((code >= 51 && code <= 67) || (code >= 80 && code <= 82)) {
    return 'Expect rain today';
  } else if (code >= 95 && code <= 99) {
    return 'Thunderstorms expected';
  } else {
    return 'Mixed conditions today';
  }
}
