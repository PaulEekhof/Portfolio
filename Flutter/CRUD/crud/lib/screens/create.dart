import 'package:crud/style/style.dart';
import 'package:flutter/material.dart';
import '../style/drawer.dart';
import '../widgets/custom_form.dart';
import '../classes/crudop.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  bool isLoading = false;

  Future<void> _handleSubmit(Map<String, dynamic> data) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try {
      // Add unique ID and timestamp to the data
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      data['id'] = timestamp.toString();
      data['created_at'] = timestamp;
      
      await CrudOperations('crud_data').create(data);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Record created successfully'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate back to the list screen
        Navigator.pushReplacementNamed(context, 'read_screen');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating record: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Record', style: AppStyles.heading),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () => Navigator.pushReplacementNamed(context, 'read_screen'),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: CustomForm(
              submitLabel: 'Create Record',
              onSubmit: _handleSubmit,
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
