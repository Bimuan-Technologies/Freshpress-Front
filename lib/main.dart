import 'package:flutter/material.dart';
import 'package:freshpress_customer/screen/identity/get_started_screen.dart';
import 'package:freshpress_customer/screen/walkthrough/splash_screen.dart';
import 'package:freshpress_customer/util/caching/local_caching.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalCache().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreshPress App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        GetStartedScreen.routeName: (context) => const GetStartedScreen()
      },
    );
  }
}


