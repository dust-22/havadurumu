import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';
import '../widgets/responsive_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<_Feature> features = [
      _Feature(
        title: "Hava Durumu",
        description: "Konum tabanlı ve şehir seçmeli canlı hava durumu.",
        icon: Icons.wb_sunny_rounded,
        color: Colors.blueAccent,
        route: '/weather',
      ),
      _Feature(
        title: "ETS2 Buton Box",
        description: "Sürükle bırak, özelleştirilebilir ETS2 kontrol paneli.",
        icon: Icons.directions_car,
        color: Colors.green,
        route: '/ets2',
      ),
      _Feature(
        title: "Stream Deck",
        description: "Sınırsız sayfa, ikon ve renk desteğiyle yayın kontrolü.",
        icon: Icons.stream,
        color: Colors.deepPurple,
        route: '/streamdeck',
      ),
      _Feature(
        title: "Ayarlar",
        description: "Tema, dil, profil ve daha fazlası.",
        icon: Icons.settings,
        color: Colors.teal,
        route: '/settings',
      ),
      _Feature(
        title: "Hakkında",
        description: "Uygulama ve geliştirici bilgileri.",
        icon: Icons.info,
        color: Colors.orange,
        route: '/about',
      ),
      _Feature(
        title: "Geri Bildirim",
        description: "Öneri ve hatalarını ilet.",
        icon: Icons.feedback,
        color: Colors.pink,
        route: '/feedback',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("HControl"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ResponsiveGrid(
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return FeatureCard(
              title: feature.title,
              description: feature.description,
              icon: feature.icon,
              color: feature.color,
              onTap: () => Navigator.pushNamed(context, feature.route),
            );
          },
        ),
      ),
    );
  }
}

class _Feature {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String route;

  _Feature({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
  });
}