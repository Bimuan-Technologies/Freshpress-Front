import 'package:flutter/material.dart';



class SettingsUI extends StatefulWidget {

  static const routeName = '/dashboard-settings';
  const SettingsUI({super.key});

  @override
  State<SettingsUI> createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
    );
  }
}
