import 'package:flutter/material.dart';

// Theme-aware colors
Color getBackgroundColor(bool isDark) => isDark ? const Color(0xFF1F1F1F) : Colors.white;
Color getTextColor(bool isDark) => isDark ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 255, 255, 255);
Color getText2Color(bool isDark) => isDark ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 0, 0, 0);
Color getAccentColor(bool isDark) => isDark ? const Color(0xFF3F51B5) : Colors.blue;
Color getCardColor(bool isDark) => isDark ? const Color(0xFF2F2F2F) : Colors.white;

// Base colors
const Color primaryColor = Color(0xFF3F51B5);
const Color secondaryColor = Color(0xFF303F9F);
const Color accentColor = Color(0xFF448AFF);

// Get theme-aware text style
TextStyle getTextStyle(bool isDark, {double size = 16, FontWeight weight = FontWeight.normal}) {
  return TextStyle(
    color: getTextColor(isDark),
    fontSize: size,
    fontWeight: weight,
  );
}

// Get theme-aware button style
ButtonStyle getButtonStyle(bool isDark) {
  return ElevatedButton.styleFrom(
    backgroundColor: getAccentColor(isDark),
    foregroundColor: getTextColor(!isDark),
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 4,
    minimumSize: const Size(200, 50),
  ).copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return getAccentColor(isDark).withOpacity(0.8);
        }
        return null;
      },
    ),
  );
}

// Get theme-aware card decoration
BoxDecoration getCardDecoration(bool isDark) {
  return BoxDecoration(
    color: getCardColor(isDark),
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

// Pre-defined text styles
TextStyle getTitleStyle(bool isDark) => getTextStyle(isDark, size: 24, weight: FontWeight.bold);
TextStyle getSubtitleStyle(bool isDark) => getTextStyle(isDark, size: 18, weight: FontWeight.w500);
TextStyle getBodyStyle(bool isDark) => getTextStyle(isDark, size: 16);
