// this will contain the drawer

import 'package:flutter/material.dart';

Drawer myDrawer(context) {
  return Drawer(
    width: 200,
    elevation: 10,
    backgroundColor: Colors.blue,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
//  header
Column(
  children: <Widget>[
    Container(
      width: double.infinity,
      height: 100,
      color: Colors.blue,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 25,
              margin: const EdgeInsets.only(top: 30),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Text(
              'Mastermind 2025',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),
        ListTile(
          title: const Text('Home'),
          onTap: () {
            Navigator.pushNamed(context, 'home_Screen');
          },
        ),
        ListTile(
          title: const Text('Game'),
          onTap: () {
            Navigator.pushNamed(context, 'options_Screen');
          },
        ),
        ListTile(
          title: const Text('Settings'),
          onTap: () {
            Navigator.pushNamed(context, 'settings_Screen');
          },
        ),
        ListTile(
          title: const Text('Score'),
          onTap: () {
            Navigator.pushNamed(context, 'score_Screen');
          },
        ),
        ListTile(
          title: const Text('Instructions'),
          onTap: () {
            Navigator.pushNamed(context, 'instructions_Screen');
          },
        ),
        // info
        ListTile(
          title: const Text('Info'),
          onTap: () {
            Navigator.pushNamed(context, 'info_Screen');
          },
        ),
        // exit
        ListTile(
          title: const Text('Exit'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
