// this will contain the settings screen

import 'package:flutter/material.dart';
import 'package:mastermind_2025/models/appbar.dart';
import 'package:mastermind_2025/models/save_load.dart';
import 'package:mastermind_2025/models/styles.dart';
import 'package:provider/provider.dart';
import 'package:mastermind_2025/models/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_Screen';

  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final isDarkMode = await SaveLoad.loadThemePreference();
    setState(() {
      _isDarkMode = isDarkMode ?? false;
    });
  }

  Future<void> _toggleTheme(bool isDarkMode) async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleTheme(isDarkMode);
  }

  Future<void> _resetScores() async {
    await SaveLoad.resetScores();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Scores reset successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: myAppBar('Settings'),
      backgroundColor: getBackgroundColor(isDark),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SwitchListTile(
            title: Text(
              'Dark Mode',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 18.0,
              ),
            ),
            value: themeProvider.isDarkMode,
            onChanged: (value) async {
              await _toggleTheme(value);
            },
          ),
          ElevatedButton(
            onPressed: _resetScores,
            style: getButtonStyle(isDark),
            child: Text(
              'Reset Scores',
              style: getBodyStyle(!isDark),
            ),
          ),
          // back button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: getButtonStyle(isDark),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Back',
                style: getBodyStyle(!isDark),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
