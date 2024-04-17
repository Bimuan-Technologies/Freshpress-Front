import 'package:flutter/material.dart';

class ServiceUI extends StatefulWidget {
  static const routeName = '/dashboard-service';
  const ServiceUI({super.key});

  @override
  State<ServiceUI> createState() => _ServiceUIState();
}

class _ServiceUIState extends State<ServiceUI> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.pink,
        )
    );
  }
}
