import 'package:flutter/material.dart';
import 'package:mastermind_2025/models/styles.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get theme => _isDarkMode ? _darkTheme : _lightTheme;

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: getBackgroundColor(false),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: getTextColor(true),
      elevation: 4,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: getButtonStyle(false),
    ),
    cardTheme: CardTheme(
      color: getCardColor(false),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: getBackgroundColor(true),
    appBarTheme: AppBarTheme(
      backgroundColor: getCardColor(true),
      foregroundColor: getTextColor(true),
      elevation: 4,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: getButtonStyle(true),
    ),
    cardTheme: CardTheme(
      color: getCardColor(true),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
