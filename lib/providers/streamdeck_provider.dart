import 'package:flutter/material.dart';

class StreamDeckButton {
  final String label;
  final IconData icon;
  final Color color;

  StreamDeckButton({required this.label, required this.icon, required this.color});
}

class StreamDeckProvider with ChangeNotifier {
  final List<List<StreamDeckButton>> _pages = [
    [ // Varsayılan ilk sayfa
      StreamDeckButton(label: "OBS Aç", icon: Icons.videocam, color: Colors.blue),
      StreamDeckButton(label: "Kamera", icon: Icons.camera, color: Colors.purple),
      StreamDeckButton(label: "Ses Kapat", icon: Icons.volume_off, color: Colors.red),
    ]
  ];

  int _currentPage = 0;

  List<StreamDeckButton> get currentButtons => _pages[_currentPage];
  int get currentPage => _currentPage;
  int get totalPages => _pages.length;

  void addButton(StreamDeckButton button) {
    _pages[_currentPage].add(button);
    notifyListeners();
  }

  void removeButton(int index) {
    _pages[_currentPage].removeAt(index);
    notifyListeners();
  }

  void nextPage() {
    if (_currentPage < _pages.length - 1) {
      _currentPage++;
      notifyListeners();
    }
  }

  void prevPage() {
    if (_currentPage > 0) {
      _currentPage--;
      notifyListeners();
    }
  }

  void addPage() {
    _pages.add([]);
    _currentPage = _pages.length - 1;
    notifyListeners();
  }

  void removePage(int pageIndex) {
    if (_pages.length > 1) {
      _pages.removeAt(pageIndex);
      if (_currentPage >= _pages.length) {
        _currentPage = _pages.length - 1;
      }
      notifyListeners();
    }
  }
}