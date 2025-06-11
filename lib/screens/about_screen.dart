import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hakkında")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "HControl\n",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              "Tüm akıllı cihazlarınızı, oyun ve yayın kontrollerinizi tek bir uygulamada birleştirin. "
              "Açık kaynak kodludur ve sürekli geliştirilmektedir.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text("Sürüm: 1.0.0"),
            SizedBox(height: 8),
            Text("Geliştirici: dust-22"),
          ],
        ),
      ),
    );
  }
}