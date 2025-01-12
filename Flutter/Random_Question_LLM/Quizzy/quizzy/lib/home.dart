import 'package:flutter/material.dart';
import 'package:quizzy/data/drawer.dart';
import 'package:quizzy/data/style.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Quizzy Home', style: AppStyles.headline2),
      ), backgroundColor: primaryColor,
      body: Center(
        child: Text('Welcome to Quizzy!', style: AppStyles.bodyText1),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: AppStyles.themeData,
    home: HomePage(),
  ));
}