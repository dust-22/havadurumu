import 'package:flutter/material.dart';

class ETS2Button {
  final String label;
  final IconData icon;

  ETS2Button({required this.label, required this.icon});
}

class ETS2Provider with ChangeNotifier {
  final List<ETS2Button> _buttons = [
    ETS2Button(label: "Fren", icon: Icons.stop),
    ETS2Button(label: "Gaz", icon: Icons.arrow_upward),
    ETS2Button(label: "Sol Sinyal", icon: Icons.arrow_back),
    ETS2Button(label: "Sağ Sinyal", icon: Icons.arrow_forward),
    ETS2Button(label: "Korna", icon: Icons.campaign),
    ETS2Button(label: "Işıklar", icon: Icons.lightbulb),
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
}