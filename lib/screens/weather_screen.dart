import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'package:intl/intl.dart';

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
            : SingleChildScrollView(
          child: Column(
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
              // SAATLİK HAVA DURUMU
              if (weather.hourlyWeather.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Saatlik Tahmin",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weather.hourlyWeather.length,
                        itemBuilder: (context, index) {
                          final hour = weather.hourlyWeather[index];
                          return Container(
                            width: 80,
                            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat.Hm().format(hour.time),
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(hour.icon, style: const TextStyle(fontSize: 28)),
                                const SizedBox(height: 4),
                                Text("${hour.temperature.round()}°C", style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
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
      ),
    );
  }
}