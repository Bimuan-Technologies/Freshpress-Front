import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshpress_customer/ui/identity/register/email_and_password_first_screen.dart';

import '../../common/constants/freshpress_color.dart';
import '../../common/constants/freshpress_image_path.dart';
import '../identity/login/signin_screen.dart';



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
    final h = MediaQuery.of(context).size.height, w = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: FreshPressColors.lightGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: buildUI(size)
        ),
      ),
    );
  }
  
  
  Widget buildUI(Size size){
    return SizedBox(
      width: size.width,
      height: size.height,
      
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      width: 100, // Adjust width and height as needed
                      height: 100,
                      child: Image.asset(FreshPressImages.logoPath),
                    ),

                    SizedBox(
                      width: 250, // Adjust width and height as needed
                      height: 250,
                      child: Image.asset(FreshPressImages.getStartedFlatCharacter),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("FROM DIRT TO SPARKLE, WE REDEFINE CLEANLINESS", textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 100),
                  SizedBox(
                    width: size.width * .5,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(SignUpScreen.routeName);
                        // EmailScreenSignUp
                      },
                      style: ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all<Color>(FreshPressColors.darkBlue),
                        backgroundColor: MaterialStateProperty.all<Color>(FreshPressColors.lightBlue),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              // side: BorderSide(color: Colors.white, width: 1.0),
                            )
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Create Account", style: TextStyle(color: FreshPressColors.darkBlue, fontSize: 18),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 150),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Have an account already? ',
                            style: TextStyle(
                                color: Colors.black,
              
                            )
                        ),
                        TextSpan(
                          text: "Log in",
                          style: TextStyle(
                            color: FreshPressColors.darkBlue,
                            fontWeight: FontWeight.bold
                          ),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.of(context).pushNamed(SignInScreen.routeName);
                            }
                        )
                      ]
                    ),
                  )
                  // Text("Have an account already? Log in")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// "From dirty to sweet-sweet, we dey redefine cleanliness.
