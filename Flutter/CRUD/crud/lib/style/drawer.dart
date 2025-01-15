import 'package:flutter/material.dart';
import 'style.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Text(
              'CRUD App',
              style: AppStyles.heading,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.onSecondary),
            title: const Text('Home', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('home_screen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.create, color: AppColors.onSecondary),
            title: const Text('Create', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('create_screen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.read_more, color: AppColors.onSecondary),
            title: const Text('Read', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('read_screen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.update, color: AppColors.onSecondary),
            title: const Text('Update', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('update_screen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: AppColors.onSecondary),
            title: const Text('Delete', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('delete_screen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: AppColors.onSecondary),
            title: const Text('Settings', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail, color: AppColors.onSecondary),
            title: const Text('Contact', style: AppStyles.menu),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/contact');
            },
          ),
        ],
      ),
    );
  }
}