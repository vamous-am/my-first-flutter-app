# Flutter Weather App

A simple weather app built with Flutter as an introduction to mobile development. It fetches live weather data from a public API and displays it in a clean, dark-themed UI.

## Features

- Live weather data fetched from [Open-Meteo](https://open-meteo.com/) (no API key required)
- Displays current temperature, wind speed, humidity, and precipitation
- Weather condition icon changes based on actual weather code
- Hourly forecast section (placeholder)
- Dark themed UI with floating navigation bar

## Tech Stack

- **Flutter** — UI framework
- **Dart** — programming language
- **http** — for making API requests
- **Open-Meteo API** — free, open weather API

## Project Structure

```
lib/
  models/
    weather_model.dart        # Data class for weather response
  services/
    weather_service.dart      # API call logic
    weather_icon_mapper.dart  # Maps weather codes to images
  screens/
    home_screen.dart          # Main screen with state management
  widgets/
    weather_hero.dart         # Location, image, temperature display
    metrics_row.dart          # Wind, rain, humidity cards
    hourly_forecast.dart      # Horizontal forecast cards
  main.dart                   # App entry point

assets/
  images/
    sunny.png
    cloudy.png
    rainy.png
```

## Getting Started

**Prerequisites:** Flutter SDK installed on your machine.

```bash
# Clone the repo
git clone https://github.com/vamous-am/my-first-flutter-app.git

# Navigate into the project
cd my-first-flutter-app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## API

This app uses the [Open-Meteo](https://open-meteo.com/) forecast API — free with no authentication required.

**Endpoint used:**
```
https://api.open-meteo.com/v1/forecast
  ?latitude=8.9806
  &longitude=38.7578
  &current=temperature_2m,relative_humidity_2m,apparent_temperature,
           precipitation,weather_code,wind_speed_10m,wind_direction_10m
```

Coordinates are fixed to **Addis Ababa, Ethiopia**.

## What I Learned

- Structuring a Flutter project with separated concerns (models, services, screens, widgets)
- Making asynchronous HTTP requests and handling loading/error states
- Building custom UI components with Flutter widgets
- Working with JSON APIs and mapping responses to Dart data classes
- Managing state in a `StatefulWidget` using `setState`

## License

Open source — feel free to use or build on this.
