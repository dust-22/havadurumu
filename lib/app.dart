import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/ets2_screen.dart';
import 'screens/streamdeck_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/weather_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/about_screen.dart';

class HControlApp extends StatelessWidget {
  const HControlApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HControl',
      theme: ThemeData(primarySwatch: Colors.blue),
      supportedLocales: const [
        Locale('tr', 'TR'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeScreen(),
      routes: {
        '/weather': (context) => WeatherScreen(),
        '/ets2': (context) => ETS2Screen(),
        '/streamdeck': (context) => StreamDeckScreen(),
        '/settings': (context) => SettingsScreen(),
        '/feedback': (context) => FeedbackScreen(),
        '/about': (context) => AboutScreen(),
        // diğer sayfalar...
      },
    );
  }
}