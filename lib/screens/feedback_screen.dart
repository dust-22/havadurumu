import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _controller = TextEditingController();
  bool _sent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Geri Bildirim")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _sent
            ? Center(child: Text("Teşekkürler! Geri bildiriminiz alındı.", style: TextStyle(fontSize: 18)))
            : Column(
                children: [
                  const Text(
                    "Uygulama ile ilgili görüş, öneri ya da hataları buradan iletebilirsin.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _controller,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      labelText: "Mesajınız",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text("Gönder"),
                    onPressed: () {
                      setState(() => _sent = true);
                      // Burada backend/email entegrasyonu eklenebilir.
                      _controller.clear();
                    },
                  )
                ],
              ),
      ),
    );
  }
}