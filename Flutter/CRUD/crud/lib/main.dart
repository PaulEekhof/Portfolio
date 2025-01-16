import 'package:flutter/material.dart';
import 'screens/create.dart';
import 'screens/read.dart';
import 'screens/update.dart';
import 'screens/delete.dart';
import 'classes/crudop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CrudOperations crudOperations = CrudOperations();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(crudOperations: crudOperations),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final CrudOperations crudOperations;

  const HomeScreen({super.key, required this.crudOperations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter CRUD'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateScreen(crudOperations: crudOperations),
                  ),
                );
              },
              child: Text('Create'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadScreen(crudOperations: crudOperations),
                  ),
                );
              },
              child: Text('Read'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateScreen(crudOperations: crudOperations),
                  ),
                );
              },
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeleteScreen(crudOperations: crudOperations),
                  ),
                );
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
