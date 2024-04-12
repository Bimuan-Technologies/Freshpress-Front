import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../common/constants/freshpress_color.dart';
import '../../../common/util/checks/helper.dart';
import '../../../common/util/notification_box/toast_alert.dart';
import '../../../common/widgets/freshpress_widgets.dart';



class ForgotPasswordFirstStepScreen extends StatefulWidget {
  static const routeName = '/forgot-password-first';
  const ForgotPasswordFirstStepScreen({super.key});

  @override
  State<ForgotPasswordFirstStepScreen> createState() => _ForgotPasswordFirstStepScreenState();
}

class _ForgotPasswordFirstStepScreenState extends State<ForgotPasswordFirstStepScreen> {

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: FreshPressColors.lightGrey,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    final h = MediaQuery.of(context).size.height, w = MediaQuery.of(context).size.width;

    return PopScope(
        canPop: false,
        onPopInvoked: (didPop)  {
          if(didPop){
            // showToastMessage(message: "Back key pressed");
          }
        },
        child: Scaffold(
          backgroundColor: FreshPressColors.lightGrey,
          body: SafeArea(
            child: SingleChildScrollView(
              child: buildUI(w, h),
            ),
          ),
        )
    );
  }

  Widget buildUI(double w, double h){
    return SizedBox(
      width: w,
      height: h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
        const SizedBox(height: 10,),
            buildHeader(w, h, context),
            const SizedBox(height: 20,),
            const Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Forgot Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Please type in the email address associate with your \naccount to enable the reset of your password")
                  ],
                )
              ],
            ),
            const SizedBox(height: 70),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: "Enter email address here",
                  labelText: "Email",
                  labelStyle: TextStyle(
                      fontSize: 16,
                      color: FreshPressColors.greyerText
                  ),
                  border: OutlineInputBorder(

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: FreshPressColors.darkBlue), // Set border color for active state
                  ),
                  fillColor: FreshPressColors.lightGrey,
                  filled: true,
                  contentPadding: const EdgeInsets.all(14.0),
                  suffixIcon: const Icon(Icons.email_outlined, size: 20)
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 100,),
            SizedBox(
              width: w * .5,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {

                  if(!isEmailAddressValid(_emailController.text)){
                    showToastMessage(message: "Invalid email address format");
                    return;
                  }
                  bool hasInternetConnection = await InternetConnection().hasInternetAccess;

                  if(!hasInternetConnection){
                    showToastMessage(message: 'No internet connection - please try again');
                    return;
                  }
                  if(_emailController.text.isNotEmpty ){
                  } else {
                    showToastMessage(message: "Empty login credentials");
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(true ? FreshPressColors.lightBlue : FreshPressColors.transparentBlue),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        // side: BorderSide(color: Colors.white, width: 1.0),
                      )
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Proceed", style: TextStyle(color: FreshPressColors.darkBlue, fontSize: 18),)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40,),
        ]
        ),
      )
    );
  }


}
