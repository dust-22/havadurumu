import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ETS2Button {
  final String label;
  final IconData icon;

  ETS2Button({required this.label, required this.icon});
}

class ETS2Provider with ChangeNotifier {
  final List<ETS2Button> _buttons = [
    ETS2Button(label: "Fren", icon: Icons.stop),
    ETS2Button(label: "Gaz", icon: Icons.arrow_upward),
    // ... diğer butonlar
  ];

  List<ETS2Button> get buttons => _buttons;

  void addButton(String label, IconData icon) {
    _buttons.add(ETS2Button(label: label, icon: icon));
    notifyListeners();
  }

  void removeButton(int index) {
    _buttons.removeAt(index);
    notifyListeners();
  }

  // KOMUT GÖNDERME FONKSİYONU
  Future<bool> sendCommand(String command) async {
    try {
      // Buradaki IP adresini kendi bilgisayarının IP'siyle değiştir!
      final uri = Uri.parse('http://192.168.1.20:5000/ets2/command');
      final response = await http.post(uri, body: {'command': command});
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}