import 'package:flutter/material.dart';
import 'style.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Text(
              'CRUD App',
              style: AppStyles.heading,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: AppColors.onSecondary),
            title: Text('Home', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('home_screen');
            },
          ),
          ListTile(
            leading: Icon(Icons.create, color: AppColors.onSecondary),
            title: Text('Create', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('create_screen');
            },
          ),
          ListTile(
            leading: Icon(Icons.read_more, color: AppColors.onSecondary),
            title: Text('Read', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('read_screen');
            },
          ),
          ListTile(
            leading: Icon(Icons.update, color: AppColors.onSecondary),
            title: Text('Update', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('update_screen');
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: AppColors.onSecondary),
            title: Text('Delete', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('delete_screen');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: AppColors.onSecondary),
            title: Text('Settings', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail, color: AppColors.onSecondary),
            title: Text('Contact', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/contact');
            },
          ),
        ],
      ),
    );
  }
}