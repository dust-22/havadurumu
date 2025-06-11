import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hava Durumu"),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            tooltip: "Konumdan güncelle",
            onPressed: () => weather.fetchWeather(useLocation: true),
          ),
        ],
      ),
      body: Center(
        child: weather.loading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weather.weatherIcon ?? "",
              style: const TextStyle(fontSize: 64),
            ),
            const SizedBox(height: 8),
            Text(
              weather.city,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              weather.description ?? "",
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
              weather.temperature != null ? "${weather.temperature!.round()}°C" : "--°C",
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Şehir gir (ör: İstanbul)",
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (val) {
                  if (val.isNotEmpty) {
                    weather.setCity(val);
                  }
                },
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text("Yenile"),
              onPressed: () => weather.fetchWeather(cityName: weather.city),
            ),
          ],
        ),
      ),
    );
  }
}