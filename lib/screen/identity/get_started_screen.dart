import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/immutable/freshpress_color.dart';


class GetStartedScreen extends StatefulWidget {
  static const routeName = '/getting-started';

  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: FreshPressColors.lightGrey,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: FreshPressColors.lightGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Text("Get Started Screen"),
          ),
        ),
      ),
    );
  }
}
