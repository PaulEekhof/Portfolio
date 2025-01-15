import 'package:flutter/material.dart';

const Color primaryColor = Colors.blue;
const Color accentColor = Colors.orange;
const Color backgroundColor = Colors.white;

class AppStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 50.0,
    color: Colors.black,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14.0,
    color: Colors.black54,
  );

    static const TextStyle bodyText3 = TextStyle(
    fontSize: 14.0,
    color: Colors.white,
  );




  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
    scaffoldBackgroundColor: backgroundColor,
    textTheme: const TextTheme(
      headlineLarge: headline1,
      headlineMedium: headline2,
      bodyLarge: bodyText1,
      bodyMedium: bodyText2,
    ),
  );
}