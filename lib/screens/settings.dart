import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
     
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6, color: Colors.green),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.green),
            title: const Text('Rate the App'),
            onTap: () {
              // Implement rate app functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.green),
            title: const Text('About the App'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Agromate",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2025 FYP AgroMate",
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback, color: Colors.green),
            title: const Text('Send Feedback'),
            onTap: () {
              // Implement feedback functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign Out'),
            onTap: () {
              // Implement sign-out functionality
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
