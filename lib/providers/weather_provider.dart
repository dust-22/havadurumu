import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherProvider with ChangeNotifier {
  String _city = "Ankara";
  double? _temperature;
  String? _description;
  bool _loading = false;
  String? _weatherIcon;
  double? _latitude;
  double? _longitude;

  // Saatlik hava durumu
  List<HourlyWeather> _hourlyWeather = [];

  String get city => _city;
  double? get temperature => _temperature;
  String? get description => _description;
  bool get loading => _loading;
  String? get weatherIcon => _weatherIcon;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  List<HourlyWeather> get hourlyWeather => _hourlyWeather;

  Future<void> fetchWeather({String? cityName, bool useLocation = false}) async {
    _loading = true;
    notifyListeners();

    double lat = 39.93;
    double lon = 32.86;
    String city = cityName ?? _city;

    if (useLocation) {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        lat = position.latitude;
        lon = position.longitude;
        _latitude = lat;
        _longitude = lon;
        final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          city = placemarks[0].locality ?? city;
        }
      } catch (e) {
        // Lokasyon alınamazsa varsayılan Ankara
      }
    }

    final url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&hourly=temperature_2m,weathercode&timezone=auto'
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      _temperature = data["current_weather"]["temperature"];
      int code = data["current_weather"]["weathercode"];
      _description = _weatherCodeToText(code);
      _weatherIcon = _weatherCodeToIcon(code);
      _city = city;

      // Saatlik hava durumu verisini işle
      _hourlyWeather = [];
      if (data["hourly"] != null &&
          data["hourly"]["time"] != null &&
          data["hourly"]["temperature_2m"] != null &&
          data["hourly"]["weathercode"] != null) {
        final times = List<String>.from(data["hourly"]["time"]);
        final temps = List<double>.from(data["hourly"]["temperature_2m"]);
        final codes = List<int>.from(data["hourly"]["weathercode"]);
        for (int i = 0; i < times.length; i++) {
          _hourlyWeather.add(HourlyWeather(
            time: DateTime.parse(times[i]),
            temperature: temps[i],
            icon: _weatherCodeToIcon(codes[i]),
          ));
        }
      }
    } catch (e) {
      _temperature = null;
      _description = "Veri alınamadı";
      _weatherIcon = null;
      _hourlyWeather = [];
    }
    _loading = false;
    notifyListeners();
  }

  void setCity(String cityName) {
    _city = cityName;
    fetchWeather(cityName: cityName);
  }

  // Open-Meteo weather code açıklamalarını Türkçeye çeviren fonksiyon:
  String _weatherCodeToText(int code) {
    if (code == 0) return "Açık";
    if ([1, 2, 3].contains(code)) return "Az Bulutlu";
    if ([45, 48].contains(code)) return "Sis";
    if ([51, 53, 55].contains(code)) return "Çiseleme";
    if ([61, 63, 65].contains(code)) return "Yağmurlu";
    if ([71, 73, 75, 77].contains(code)) return "Kar";
    if ([80, 81, 82].contains(code)) return "Sağanak";
    if ([95].contains(code)) return "Fırtına";
    if ([96, 99].contains(code)) return "Dolu Fırtına";
    return "Bilinmiyor";
  }

  String _weatherCodeToIcon(int code) {
    if (code == 0) return "☀️";
    if ([1, 2, 3].contains(code)) return "🌤️";
    if ([45, 48].contains(code)) return "🌫️";
    if ([51, 53, 55].contains(code)) return "🌦️";
    if ([61, 63, 65].contains(code)) return "🌧️";
    if ([71, 73, 75, 77].contains(code)) return "❄️";
    if ([80, 81, 82].contains(code)) return "🌧️";
    if ([95].contains(code)) return "🌩️";
    if ([96, 99].contains(code)) return "⛈️";
    return "❓";
  }
}

class HourlyWeather {
  final DateTime time;
  final double temperature;
  final String icon;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.icon,
  });
}