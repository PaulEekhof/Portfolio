import 'package:flutter/material.dart';
import '../style/drawer.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Screen'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Welcome to the Update Screen!'),
      ),
    );
  }
}
