import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${item['name']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Description: ${item['description']}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
