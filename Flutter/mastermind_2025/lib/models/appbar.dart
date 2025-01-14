// this will contain the app bar

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mastermind_2025/models/styles.dart';
import 'package:provider/provider.dart';
import 'package:mastermind_2025/models/theme_provider.dart';

// ---------------------------------------------------
// APPBAR
// ---------------------------------------------------
AppBar myAppBar(String name) {
  return AppBar(
    foregroundColor: secondaryColor,
    title: Builder(
      builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final isDark = themeProvider.isDarkMode;
        return Text(
          name,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 24,
          ),
        );
      },
    ),
    centerTitle: true,
    toolbarOpacity: 1,
    backgroundColor: Colors.blue,
    shadowColor: Colors.black,
    elevation: 10,
    toolbarHeight: 100,
    leading: null,
    automaticallyImplyLeading: true,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
