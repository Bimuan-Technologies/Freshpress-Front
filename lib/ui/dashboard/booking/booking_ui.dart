import 'package:flutter/material.dart';


class BookingUI extends StatefulWidget {
  static const routeName = '/dashboard-booking';
  const BookingUI({super.key});

  @override
  State<BookingUI> createState() => _BookingUIState();
}

class _BookingUIState extends State<BookingUI> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
        ));
  }
}
