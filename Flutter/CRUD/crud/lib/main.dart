import 'package:crud/screens/home.dart';
import 'package:crud/screens/settings.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'screens/home.dart';
import 'screens/create.dart';
import 'screens/read.dart';
import 'screens/update.dart';
import 'screens/delete.dart';
import 'screens/detail.dart';

void main() async {
  runApp(MaterialApp(
    home: const Scaffold(),
    initialRoute: 'home_screen',
    routes: {
      // Home
      'home_screen': (context) => HomeScreen(),
      // Detail
      'detail_screen': (context) => DetailScreen(),
      // CRUD
      'create_screen': (context) => CreateScreen(),
      'read_screen': (context) => ReadScreen(),
      'update_screen': (context) => UpdateScreen(),
      'delete_screen': (context) => DeleteScreen(),
      // settings
      'settings_screen': (context) => SettingsScreen(),
    },
   ));
}
