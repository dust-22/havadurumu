import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme => ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      fontFamily: 'Arial'
  );

  ThemeData get darkTheme => ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      fontFamily: 'Arial'
  );

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}