import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          ListTile(title: Text('Theme'), subtitle: Text('System default')),
          SwitchListTile(
            value: true,
            onChanged: null,
            title: Text('Sound Effects'),
            subtitle: Text('Placeholder setting'),
          ),
          ListTile(
            title: Text('Default AI Difficulty'),
            subtitle: Text('Easy'),
          ),
        ],
      ),
    );
  }
}
