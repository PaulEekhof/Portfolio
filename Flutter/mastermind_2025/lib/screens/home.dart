// this will contain the home screen

import 'package:flutter/material.dart';
import 'package:mastermind_2025/models/appbar.dart';
import 'package:mastermind_2025/models/drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_Screen';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define the colors
  final Color myColor_text6 = Colors.blue;
  final Color myColor_text3 = Colors.green;
  // Define the button style
  final ButtonStyle myButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    textStyle: const TextStyle(fontSize: 18),
  );

  // Define the text style
  final TextStyle myTextStyle2 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Home Screen'),	
      drawer: myDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Home Screen',
              style: myTextStyle2,
            ),
            ElevatedButton(
              style: myButtonStyle,
              onPressed: () {
                // Button press action
              },
              child: Text(
                'Press Me',
                style: TextStyle(color: myColor_text6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
