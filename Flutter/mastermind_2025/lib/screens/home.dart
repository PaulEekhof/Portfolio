// this will contain the home screen

import 'package:flutter/material.dart';
import 'package:mastermind_2025/models/appbar.dart';
import 'package:mastermind_2025/models/drawer.dart';
import 'package:mastermind_2025/models/styles.dart';
import 'package:provider/provider.dart';
import 'package:mastermind_2025/models/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_Screen';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define the colors
  final Color myColor_text6 = Colors.blue;
  final Color myColor_text3 = Colors.green;
  // Define the button style
  final ButtonStyle myButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    textStyle: const TextStyle(fontSize: 18),
  );

  // Define the text style
  final TextStyle myTextStyle2 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  //
  @override
  void initState() {
    super.initState();
    // _loadInfo();
  }

  //load info
  Future<void> _loadInfo() async {}

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      drawer: myDrawer(context),
      appBar: myAppBar('Home'),
      backgroundColor: getBackgroundColor(isDark),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Welcome to Mastermind 2025!',
                style: getBodyStyle(!isDark),
              ),
            ),
            Column(
              // a row of buttons in cards
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Button 1 Game
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: getButtonStyle(isDark).copyWith(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.all(16.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'options_Screen');
                    },
                    child: Text(
                      'Game',
                      style: getBodyStyle(!isDark),
                    ),
                  ),
                ),
                // Button 2 Score
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: getButtonStyle(isDark).copyWith(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.all(16.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'score_Screen');
                    },
                    child: Text(
                      'Score',
                      style: getBodyStyle(!isDark),
                    ),
                  ),
                ),
                // Button 3 Settings
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: getButtonStyle(isDark).copyWith(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.all(16.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'settings_Screen');
                    },
                    child: Text(
                      'Settings',
                      style: getBodyStyle(!isDark),
                    ),
                  ),
                ),
                // Button 4 Exit
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: getButtonStyle(isDark).copyWith(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.all(16.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Exit',
                      style: getBodyStyle(!isDark),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
