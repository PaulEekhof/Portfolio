import 'package:flutter/material.dart';
import '../widgets/custom_form.dart';
import '../classes/crudop.dart';

class UpdateScreen extends StatelessWidget {
  final CrudOperations crudOperations;

  const UpdateScreen({super.key, required this.crudOperations});

  @override
  Widget build(BuildContext context) {
    final items = crudOperations.readItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Item'),
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
                  builder: (context) => UpdateFormScreen(item: item, crudOperations: crudOperations),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UpdateFormScreen extends StatelessWidget {
  final Map<String, dynamic> item;
  final CrudOperations crudOperations;

  const UpdateFormScreen({super.key, required this.item, required this.crudOperations});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: item['name']);
    final descriptionController = TextEditingController(text: item['description']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomForm(
          onSubmit: (name, description) {
            crudOperations.updateItem(item['id'], name, description);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
