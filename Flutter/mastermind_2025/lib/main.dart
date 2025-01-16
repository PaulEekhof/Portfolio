import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mastermind_2025/models/theme_provider.dart';
import 'package:mastermind_2025/screens/home.dart';
import 'package:mastermind_2025/screens/game.dart';
import 'package:mastermind_2025/screens/options.dart';
import 'package:mastermind_2025/screens/score.dart';
import 'package:mastermind_2025/screens/settings.dart';
import 'package:mastermind_2025/screens/instructions.dart';
import 'package:mastermind_2025/screens/info.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(), // Remove isDarkMode parameter
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Remove isDarkMode parameter

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'Mastermind 2025',
      theme: themeProvider.theme,
      darkTheme: themeProvider.theme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        GameScreen.id: (context) => const GameScreen(),
        OptionsScreen.id: (context) => const OptionsScreen(),
        ScoreScreen.id: (context) => const ScoreScreen(),
        SettingsScreen.id: (context) => const SettingsScreen(),
        InstructionsScreen.id: (context) => const InstructionsScreen(),
        InfoScreen.id: (context) => const InfoScreen(),
      },
    );
  }
}
