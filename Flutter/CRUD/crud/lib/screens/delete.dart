import 'package:flutter/material.dart';
import '../style/drawer.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  _DeleteScreenState createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Screen'),
      ),
      drawer: AppDrawer(),
      body: const Center(
        child: Text('Welcome to the Delete Screen!'),
      ),
    );
  }
}

