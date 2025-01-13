import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1E1E1E);
  static const Color primaryVariant = Color(0xFF121212);
  static const Color secondary = Color(0xFFBB86FC);
  static const Color secondaryVariant = Color(0xFF3700B3);
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color error = Color(0xFFCF6679);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color onError = Color(0xFF000000);
}

class AppStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.onBackground,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.onBackground,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.onBackground,
  );

  static const TextStyle menu = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.onSecondary,
    // backgroundColor: AppColors.primaryVariant,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.onBackground,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.onPrimary,
  );

  static const CardTheme cardTheme = CardTheme(
    elevation: 4,
    margin: EdgeInsets.all(8),
    color: AppColors.surface,
  );

  static const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(),
    labelStyle: TextStyle(color: AppColors.onBackground),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondary),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondaryVariant, width: 2),
    ),
  );
}