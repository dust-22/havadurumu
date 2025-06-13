import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  String _username = "Kullanıcı";
  String? _avatar;

  String get username => _username;
  String? get avatar => _avatar;

  ProfileProvider() {
    loadProfile();
  }

  void setUsername(String name) {
    _username = name;
    notifyListeners();
  }

  void setAvatar(String? path) {
    _avatar = path;
    notifyListeners();
  }

  Future<void> pickAvatar(BuildContext context) async {
    // Örnek: asset avatar seçimi (ileride galeri desteği eklenebilir)
    final options = [
      "assets/images/avatar1.png",
      "assets/images/avatar2.png",
      "assets/images/avatar3.png",
    ];
    String? selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Avatar Seç"),
        children: options
            .map((o) => SimpleDialogOption(
                  child: CircleAvatar(backgroundImage: AssetImage(o), radius: 24),
                  onPressed: () => Navigator.pop(context, o),
                ))
            .toList(),
      ),
    );
    if (selected != null) {
      setAvatar(selected);
    }
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("username", _username);
    if (_avatar != null) prefs.setString("avatar", _avatar!);
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString("username") ?? "Kullanıcı";
    _avatar = prefs.getString("avatar");
    notifyListeners();
  }
}