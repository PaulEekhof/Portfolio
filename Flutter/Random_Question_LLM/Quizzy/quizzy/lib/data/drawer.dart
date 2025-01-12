import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Quizzy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('Question'),
            onTap: () {
              Navigator.of(context).pushNamed('/question');
            },
          ),
          ListTile(
            leading: Icon(Icons.radar_rounded),
            title: Text('Random'),
            onTap: () {
              Navigator.of(context).pushNamed('/generate');
            },
          ),
          // favorites
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Favorites'),
            onTap: () {
              Navigator.of(context).pushNamed('/favorites');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              // Handle exit
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}