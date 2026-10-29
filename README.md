# Flutter Weather App

A simple weather app built with Flutter as an introduction to mobile development. It fetches live weather data from a public API and displays it in a clean, dark-themed UI.

## Features

- Live weather data fetched from [Open-Meteo](https://open-meteo.com/) (no API key required)
- Displays current temperature, wind speed, humidity, and precipitation
- Weather condition icon (sunny / cloudy / rainy) driven by WMO weather codes
- Loading indicator while fetching and a Retry button on network error
- Hourly forecast section (static placeholder — API hourly data not wired up)
- Dark themed UI with a custom floating pill navigation bar

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

## Known Limitations

- Location is hardcoded to Addis Ababa — no search or GPS support
- Hourly forecast cards show static placeholder data, not real hourly API data
- Bottom nav bar icons (Search, Notifications, Map) & the header icons are decorative — no navigation is wired up
- `apparent_temperature` is fetched and stored in the model but not rendered anywhere in the UI
- Debug `print` statements remain active in `WeatherService` (harmless, but worth cleaning before a real release)

## What I Learned from building it

- Structuring a Flutter project with separated concerns (models, services, screens, widgets)
- Making asynchronous HTTP requests and handling loading/error states with `setState`
- Mapping WMO weather codes to assets and descriptions with pure functions
- Building fully custom UI components (status bar, floating nav, metric cards) without relying on Material defaults
- Working with the `http` package and `json.decode` to map API responses to typed Dart models

## License

Open source - feel free to use or build on this.
