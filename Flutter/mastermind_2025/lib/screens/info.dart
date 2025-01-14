// this contains the info screen with the information about the app
// - the app name
// - the app version
// - the app description
// - the app developer

import 'package:flutter/material.dart';
import 'package:mastermind_2025/models/appbar.dart';
import 'package:mastermind_2025/models/styles.dart';
import 'package:provider/provider.dart';
import 'package:mastermind_2025/models/theme_provider.dart';

class InfoScreen extends StatefulWidget {
  static const String id = 'info_Screen';

  const InfoScreen({super.key});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  // Define the colors
  final Color myColor_text6 = Colors.blue;
  final Color myColor_text3 = Colors.green;

  // Define the text style
  final TextStyle myTextStyle2 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: myAppBar('Info'),
      backgroundColor: getBackgroundColor(isDark),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Mastermind 2025',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: getAccentColor(isDark),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18.0,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Mastermind 2025 is a game where you have to guess the secret code. '
                'The code is a sequence of 4 colors. You have 10 attempts to guess the code. '
                'After each guess, you will receive feedback on how many colors are correct and '
                'how many colors are in the correct position. Good luck!',
                style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18.0,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Developed by: Paul Eekhof 2025',
                style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18.0,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
