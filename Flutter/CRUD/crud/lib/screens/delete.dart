import 'package:flutter/material.dart';
import '../classes/crudop.dart';

class DeleteScreen extends StatelessWidget {
  final CrudOperations crudOperations;

  const DeleteScreen({super.key, required this.crudOperations});

  @override
  Widget build(BuildContext context) {
    final items = crudOperations.readItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Item'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text(item['description']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                crudOperations.deleteItem(item['id']);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
