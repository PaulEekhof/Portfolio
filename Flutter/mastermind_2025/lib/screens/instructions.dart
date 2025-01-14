// this will show the instructions to the user

import 'package:flutter/material.dart';
import 'package:mastermind_2025/models/appbar.dart';
import 'package:mastermind_2025/models/drawer.dart';
import 'package:mastermind_2025/models/styles.dart';
import 'package:provider/provider.dart';
import 'package:mastermind_2025/models/theme_provider.dart';

class InstructionsScreen extends StatefulWidget {
  static const String id = 'instructions_Screen';

  const InstructionsScreen({super.key});

  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: myAppBar('Instructions'),
      drawer: myDrawer(context),
      backgroundColor: getBackgroundColor(isDark),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Mastermind 2025 is a game where you have to guess the correct combination '
                    'of colors. The game will provide you with feedback on your guesses. You can '
                    'choose the number of colors and the number of guesses you want to make. You '
                    'can also choose the difficulty level of the game. The game will keep track '
                    'of your score and the number of levels you have completed. You can save '
                    'your game and continue later.',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Card(
                child: ElevatedButton(
                  style: getButtonStyle(isDark).copyWith(
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.all(16.0),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Back',
                    style: getBodyStyle(!isDark),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
