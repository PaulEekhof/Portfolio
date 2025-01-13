import 'package:flutter/material.dart';
import '../style/drawer.dart';
import '../style/style.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> item = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen', style: AppStyles.heading),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${item['name']}', style: AppStyles.subheading),
            const SizedBox(height: 8),
            Text('Email: ${item['email']}', style: AppStyles.body),
            const SizedBox(height: 8),
            Text('Phone: ${item['phone']}', style: AppStyles.body),
            const SizedBox(height: 8),
            Text('Address: ${item['address']}', style: AppStyles.body),
            const SizedBox(height: 8),
            Text('City: ${item['city']}', style: AppStyles.body),
            const SizedBox(height: 8),
            Text('State: ${item['state']}', style: AppStyles.body),
          ],
        ),
      ),
    );
  }
}