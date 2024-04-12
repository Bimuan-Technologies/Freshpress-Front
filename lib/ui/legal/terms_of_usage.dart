
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/constants/freshpress_color.dart';
import '../walkthrough/get_started_screen.dart';

class TermsOfUsageScreen extends StatefulWidget {
  static const routeName = '/terms-of-usage';

  const TermsOfUsageScreen({super.key});

  @override
  State<TermsOfUsageScreen> createState() => _TermsOfUsageScreenState();
}

class _TermsOfUsageScreenState extends State<TermsOfUsageScreen> {


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: FreshPressColors.lightGrey,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    final h = MediaQuery.of(context).size.height, w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SizedBox(
                  height: 50,
                  width: w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                          left: 0,
                          top: 10,
                          child: InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed(GetStartedScreen.routeName);
                              },
                              child: const Icon(FontAwesomeIcons.arrowLeft, size: 20,))
                      ),
                      Positioned(
                          top: 20,
                          child: Text(
                            "Terms of Usage",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    const Text(
                      'FreshPress Terms and Conditions',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    const Text(
                      'Last Updated: July 1, 2024',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Text(
                      'Welcome to FreshPress Cleaning Service',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),

                SizedBox(height: 10,),
                Text(
                  'These Terms and Conditions ("Terms") govern your use of the FreshPress mobile application ("App"). By downloading, installing, or using the App, you agree to be bound by these Terms. If you do not agree to all the terms and conditions of this agreement, you may not use the App.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5,),
                Text(
                  '1. Introduction',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5,),
                Text(
                  "Wow is a mobile application designed to cleaning services pick up and drop off. Whether you're sending money internationally, paying for education abroad, or accessing essential services, Wow provides a convenient and secure platform for all your global financial needs.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5,),
                Text(
                  '2. Eligibility',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5,),
                Text(
                  "To use the App, you must be over the age of 18 and have the capacity to enter into this agreement.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5,),
                Text(
                  '3. Accessing the App',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5,),
                Text(
                  "The App is available for download on Google Play Store and Apple App Store. Not all mobile devices can access or support the App. It is your responsibility to ensure your device is compatible with the App's operating system requirements. Wow is not responsible for any damage or loss to your device resulting from your access or attempted access to the App.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  '4. Security',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5,),
                Text(
                  "You are responsible for maintaining the confidentiality of your login credentials (username and password) and for restricting access to your device. You agree not to disclose your login credentials to any third party. You are solely responsible for all activity that occurs under your account. If you suspect that your login credentials have been compromised, you must notify Wow immediately.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
