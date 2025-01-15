import 'package:flutter/material.dart';
import '../classes/crudop.dart';
import 'detail.dart';

class ReadScreen extends StatelessWidget {
  final CrudOperations crudOperations;

  ReadScreen({required this.crudOperations});

  @override
  Widget build(BuildContext context) {
    final items = crudOperations.readItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('Read Items'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text(item['description']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(item: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
