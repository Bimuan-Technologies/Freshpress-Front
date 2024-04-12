import 'package:flutter/material.dart';

class DashboardNavigation extends StatefulWidget {

  static const routeName = '/dashboard-bottom-navigation';

  const DashboardNavigation({super.key});

  @override
  State<DashboardNavigation> createState() => _DashboardNavigationState();
}

class _DashboardNavigationState extends State<DashboardNavigation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Login successful dashboard"),
        ),
      ),
    );
  }
}
