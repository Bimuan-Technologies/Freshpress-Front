import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freshpress_customer/bloc/identity/signup_state.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../bloc/identity/signup_cubit.dart';
import '../../../common/caching/local_caching.dart';
import '../../../common/constants/freshpress_color.dart';
import '../../../common/constants/freshpress_image_path.dart';
import '../../../common/util/notification_box/toast_alert.dart';
import '../login/signin_screen.dart';


class OtpVerificationSignUpScreen extends StatefulWidget {
  static const routeName = '/otp-verification-signup';

  const OtpVerificationSignUpScreen({super.key});

  @override
  State<OtpVerificationSignUpScreen> createState() => _OtpVerificationSignUpScreenState();
}

class _OtpVerificationSignUpScreenState extends State<OtpVerificationSignUpScreen> {

  final LocalCache _localCache = LocalCache();

  late SignUpCubit _signUpCubit;

  OtpFieldController otpController = OtpFieldController();
  final FocusNode _otpFocusNode = FocusNode();
  String code6 = "";
  String? cachedEmail;
  bool isCodeComplete = false; // Track code completion status

  @override
  void initState(){
    super.initState();
    _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    cachedEmail = _localCache.getValue<String>("cached_email_register");
  }

  Future<String> getClipboardContent() async {
    try {
      final data = await Clipboard.getData('text/plain');
      if (data != null) {
        return data.text!;
      }
    } on PlatformException catch (e) {
      // Handle exceptions (e.g., permission denied)
      showToastMessage(message: "Error getting clipboard data: $e");
    }
    return "";
  }

  Future<void> _initializeClipboardContent() async {
    final clipboardContent = await getClipboardContent();
    if (clipboardContent.isNotEmpty) {
      debugPrint(clipboardContent);
      setState(() {
        otpController.set(clipboardContent.split(''));
        isCodeComplete = true;
      });
    }
  }


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
              child: BlocBuilder<SignUpCubit, RegisterState>(
                builder: (context, state) {
                  if(state is RegisterEmailPasswordProgress){
                    return  SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: CircularProgressIndicator(color: FreshPressColors.greyText,))
                    );
                  } else if(state is RegisterEmailVerificationSuccess){
                    return buildUI(w, h, _signUpCubit);
                  } else if(state is RegisterEmailVerificationFailure){
                    debugPrint(state.message);
                    return buildUI(w, h, _signUpCubit);
                  } else {
                    return buildUI(w, h, _signUpCubit);
                  }
                },

              )
                // SignUpCubit
            ),
          ),
        )
    );
  }

  Widget buildUI(double w, double h, SignUpCubit signUpCubit){
    return SizedBox(
      width: w,
      height: h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10,),
            SizedBox(
              width: w,
              height: h * .08,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                      left: 0,
                      child: InkWell(
                        onTap: (){
                          if(Navigator.canPop(context)){
                            Navigator.pop(context);
                          }
                        },
                          child: const Icon(FontAwesomeIcons.arrowLeft, size: 20,))
                  ),
                  Positioned(
                    child: SizedBox(
                      width: 100, // Adjust width and height as needed
                      height: 100,
                      child: Image.asset(FreshPressImages.logoPath),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Email Verification", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Please check your email inbox for a 6-digit code. \nEnter the code below to complete your sign-up process ")
                  ],
                )
              ],
            ),
            const SizedBox(height: 70),
            OTPTextField(
              controller: otpController,
                length: 6,
                width: w,
                fieldWidth: 45,
                style: const TextStyle( fontSize: 16 ),
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                fieldStyle: FieldStyle.box,
                onChanged: (value){
                  setState(() {
                    // code6 = value;
                    isCodeComplete = value.length == 6; // Check if code length is 6
                  });
                  // _onFocusChange();
                },
                onCompleted: (pin){
                  setState(() {
                    code6 = pin;
                    isCodeComplete = true;
                  });
                  debugPrint("Completed: $pin");
                }
            ),
            // TextField(
            //   focusNode: _otpFocusNode,
            //   controller: _otpController,
            //   decoration: InputDecoration(
            //     hintText: "Enter otp sent to email",
            //     labelText: "otp",
            //     labelStyle: TextStyle(
            //         fontSize: 16,
            //         color: FreshPressColors.greyerText
            //     ),
            //     border: OutlineInputBorder(
            //
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: FreshPressColors.darkBlue), // Set border color for active state
            //     ),
            //     fillColor: FreshPressColors.lightGrey,
            //     filled: true,
            //     contentPadding: const EdgeInsets.all(14.0),
            //   ),
            //   keyboardType: TextInputType.number,
            //
            // ),

            const SizedBox(height: 20,),
            SizedBox(
              width: w * .8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: _initializeClipboardContent,
                          child: Icon(FontAwesomeIcons.copy, size: 20,)),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: _initializeClipboardContent,
                        child: Text("Paste OTP Code",
                          style: TextStyle(
                              color: FreshPressColors.darkBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),
                        ),
                      )
                    ],
                  ),

                  InkWell(
                    onTap: (){
                      if(cachedEmail.isNotEmptyAndNotNull){
                        signUpCubit.resendOtpCodeEmailVerification(cachedEmail);
                      } else {
                        showToastMessage(message: "Failed to request for resend of code");
                      }
                      // showToastMessage(message: 'Yet to be implemented');
                      // Navigator.of(context).pushNamed(ForgotPasswordFirstStepScreen.routeName);
                    },
                    child: const Text("Resend code",
                      style: TextStyle(
                          color: FreshPressColors.darkBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 100,),

            SizedBox(
              width: w * .5,
              height: 50,
              child: ElevatedButton(
                onPressed: isCodeComplete ? () async {
                  bool hasInternetConnection = await InternetConnection().hasInternetAccess;

                  if(!hasInternetConnection){
                    showToastMessage(message: 'No internet connection - please try again');
                    return;
                  }
                  if(code6.isNotEmpty){
                    bool status = await signUpCubit.verifyOtpCodeEmailVerification(code6);
                    if(status){
                      Navigator.of(context).pushNamed(SignInScreen.routeName);
                    } else {
                      return;
                    }
                  }

                  // EmailScreenSignUp
                } : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return FreshPressColors.transparentBlue; // Color when button is disabled
                    }
                    return FreshPressColors.lightBlue;
                  }),
                  // MaterialStateProperty.all<Color>(FreshPressColors.darkBlue),
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
                    Text("Verify Email", style: TextStyle(color: FreshPressColors.darkBlue, fontSize: 18),)
                  ],
                ),

              ),
            ),

          ],
        ),
      ),

    );
  }
}
