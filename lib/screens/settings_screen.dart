import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  Future<bool?> showConfirmDialog(BuildContext context, String title, String content) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
              child: const Text('Hayır'),
              onPressed: () => Navigator.pop(context, false)),
          TextButton(
              child: const Text('Evet'),
              onPressed: () => Navigator.pop(context, true)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text("Tema"),
            trailing: DropdownButton<ThemeMode>(
              value: themeProvider.themeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text("Aydınlık"),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text("Karanlık"),
                ),
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text("Sistem"),
                ),
              ],
              onChanged: (mode) async {
                if (mode != null && mode != themeProvider.themeMode) {
                  bool? confirmed = await showConfirmDialog(
                    context,
                    "Onay",
                    "Temayı değiştirmek istediğinize emin misiniz?",
                  );
                  if (confirmed == true) {
                    themeProvider.setTheme(mode);
                  }
                }
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Dil"),
            trailing: DropdownButton<Locale>(
              value: localeProvider.locale,
              items: const [
                DropdownMenuItem(
                  value: Locale('tr', 'TR'),
                  child: Text("Türkçe"),
                ),
                DropdownMenuItem(
                  value: Locale('en', 'US'),
                  child: Text("English"),
                ),
              ],
              onChanged: (locale) async {
                if (locale != null && locale != localeProvider.locale) {
                  bool? confirmed = await showConfirmDialog(
                    context,
                    "Onay",
                    "Dili değiştirmek istediğinize emin misiniz?",
                  );
                  if (confirmed == true) {
                    localeProvider.setLocale(locale);
                  }
                }
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profil"),
            onTap: () => Navigator.pushNamed(context, '/profile'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("Hakkında"),
            onTap: () => Navigator.pushNamed(context, '/about'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text("Geri Bildirim"),
            onTap: () => Navigator.pushNamed(context, '/feedback'),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}