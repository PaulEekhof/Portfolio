import 'package:flutter/material.dart';
import '../style/drawer.dart';
import '../style/style.dart';
import '../classes/crudop.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  String? error;
  
  // load data from the json
  Future<List<Map<String, dynamic>>> loadJsonData() async {
    try {
      final data = await CrudOperations('crud_data').getAll();
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final data = await loadJsonData();
      setState(() {
        items = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _deleteItem(Map<String, dynamic> item) async {
    try {
      await CrudOperations('crud_data').delete(item['id']);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Record deleted successfully')),
      );
      _refreshData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting record: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Records', style: AppStyles.heading),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, 'create_screen')
                .then((_) => _refreshData()),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error!, style: AppStyles.body),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refreshData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No records found', style: AppStyles.body),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, 'create_screen')
                  .then((_) => _refreshData()),
              child: const Text('Create New Record'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text(item['name'] ?? 'No name', style: AppStyles.subheading),
            subtitle: Text(item['email'] ?? 'No email', style: AppStyles.body),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(
                      context, 
                      'update_screen',
                      arguments: item,
                    ).then((_) => _refreshData());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Record'),
                      content: const Text('Are you sure you want to delete this record?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _deleteItem(item);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            onTap: () => Navigator.pushNamed(
              context, 
              'detail_screen',
              arguments: item,
            ),
          ),
        );
      },
    );
  }
}
