import 'package:flutter/material.dart';
import '../style/style.dart';
import '../classes/crudop.dart';

class CustomForm extends StatelessWidget {
  final void Function(Map<String, String>) onSubmit;
  final String submitLabel;
  
  const CustomForm({
    Key? key, 
    required this.onSubmit,
    this.submitLabel = 'Submit',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final fields = <String>['Name', 'Email', 'Phone', 'Address', 'City', 'State'];
    final controllers = {
      for (var field in fields)
        field: TextEditingController(),
    };

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...fields.map((field) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: controllers[field],
                decoration: InputDecoration(
                  labelText: field,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return '$field is required';
                  }
                  return null;
                },
              ),
            )),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  final data = {
                    for (var field in fields)
                      field: controllers[field]!.text,
                  };
                  await CrudOperations('crud_data').create(data);
                  onSubmit(data);
                }
              },
              child: Text(submitLabel, style: AppStyles.buttonText),
            ),
          ],
        ),
      ),
    );
  }
}