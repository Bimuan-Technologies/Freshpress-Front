import 'package:flutter/material.dart';


class MeUI extends StatefulWidget {
  static const routeName = '/dashboard-me';
  const MeUI({super.key});

  @override
  State<MeUI> createState() => _MeUIState();
}

class _MeUIState extends State<MeUI> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.deepPurple,
        ) );
  }
}
