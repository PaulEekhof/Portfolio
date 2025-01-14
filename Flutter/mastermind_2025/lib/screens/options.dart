// this will contain the options screen

import 'package:flutter/material.dart';
import 'package:mastermind_2025/models/appbar.dart';
import 'package:mastermind_2025/models/drawer.dart';
import 'package:mastermind_2025/models/styles.dart';
import 'package:provider/provider.dart';
import 'package:mastermind_2025/models/theme_provider.dart';

class OptionsScreen extends StatefulWidget {
  static const String id = 'options_Screen';

  const OptionsScreen({super.key});

  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  // Variables
  final Color myColor_text6 = Colors.blue; // Define your color here
  final Color myColor_text3 = Colors.green; // Define your color here

  // Button style
  final ButtonStyle myButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue, // Background color
    foregroundColor: Colors.white, // Text color
    padding: const EdgeInsets.all(16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  // Text style
  final TextStyle myTextStyle2 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Functions
  @override
  void initState() {
    super.initState();
    // _loadInfo();
  }

  //load info
  Future<void> _loadInfo() async {}

  // Build
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        bool isDark = themeProvider.theme.brightness == Brightness.dark;
        return Scaffold(
          appBar: myAppBar('Options'),
          drawer: myDrawer(context),
          backgroundColor: themeProvider.theme.scaffoldBackgroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Button 1
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: getButtonStyle(isDark).copyWith(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.all(16.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'game_Screen');
                    },
                    child: Text(
                      'New Game',
                      style: getBodyStyle(!isDark),
                    ),
                  ),
                ),

                // Button 2
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: getButtonStyle(isDark).copyWith(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.all(16.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'instructions_Screen');
                    },
                    child: Text(
                      'Instructions',
                      style: getBodyStyle(!isDark),
                    ),
                  ),
                ),

                // Button 3
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

                // Button 4
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

                // Button 5 Back
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
                      'Back',
                      style: getBodyStyle(!isDark),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
