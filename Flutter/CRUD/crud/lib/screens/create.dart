import 'package:flutter/material.dart';
import '../widgets/custom_form.dart';
import '../classes/crudop.dart';

class CreateScreen extends StatelessWidget {
  final CrudOperations crudOperations;

  const CreateScreen({super.key, required this.crudOperations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomForm(
          onSubmit: (name, description) {
            crudOperations.createItem(name, description);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
