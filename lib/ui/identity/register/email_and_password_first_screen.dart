import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../bloc/identity/signup_cubit.dart';
import '../../../bloc/identity/signup_state.dart';
import '../../../common/constants/freshpress_color.dart';
import '../../../common/constants/freshpress_image_path.dart';
import '../../../common/util/notification_box/toast_alert.dart';
import '../../legal/privacy_policy.dart';
import '../../legal/terms_of_usage.dart';
import '../../walkthrough/get_started_screen.dart';
import '../login/signin_screen.dart';
import 'otp_verification_second_screen.dart';


class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  late SignUpCubit _signUpCubit;
  bool _isPasswordVisible = false;
  bool _isRepeatPasswordVisible = false;

  bool _isSubscribedToUpdates = false; // Flag for checkbox state

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();


  @override
  void initState(){
    super.initState();
    _signUpCubit = BlocProvider.of<SignUpCubit>(context);
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
    return
      PopScope(
        canPop: true,
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
                  } else if(state is RegisterEmailPasswordSuccess){
                    return buildUI(w, h, _signUpCubit);
                  } else if(state is RegisterEmailPasswordFailure){
                    debugPrint(state.message);
                    return buildUI(w, h, _signUpCubit);
                  } else {
                    return buildUI(w, h, _signUpCubit);
                  }
                },
              ),

                // child:
            ),
          ),
        )
    );
  }

  Widget buildUI(double w, double h, SignUpCubit signUpCubit){

    bool isFormValid = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _repeatPasswordController.text.isNotEmpty &&
        _passwordController.text == _repeatPasswordController.text;

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
                          Navigator.of(context).pushNamed(GetStartedScreen.routeName);
                        },
                          child: const Icon(FontAwesomeIcons.arrowLeft, size: 20,),
                      )
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
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Create new account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Get started by creating your personalized account.\nEnjoy personalized features and seamless\naccess to our services. Sign up now.")
                  ],
                )
              ],
            ),
            SizedBox(height: 70),
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
            const SizedBox(height: 15,),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: "Enter your password",
                labelText: "Password",
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
                suffixIcon:  IconButton(
                  icon: _isPasswordVisible ?
                  const Icon(Icons.visibility, size: 20,) :
                  const Icon(Icons.visibility_off, size: 20),
                  onPressed: (){
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              ),
              keyboardType: TextInputType.text,


            ),
            const SizedBox(height: 15,),
            TextField(
              controller: _repeatPasswordController,
              obscureText: !_isRepeatPasswordVisible,
              decoration: InputDecoration(
                hintText: "Repeat password",
                labelText: "Repeat password",
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
                  suffixIcon:  IconButton(
                    icon: _isRepeatPasswordVisible ?
                    const Icon(Icons.visibility, size: 20,) :
                    const Icon(Icons.visibility_off, size: 20),
                    onPressed: (){
                      setState(() {
                        _isRepeatPasswordVisible = !_isRepeatPasswordVisible;
                      });
                    },
                  )
              ),
              keyboardType: TextInputType.text,

            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  checkColor: FreshPressColors.darkBlue,
                  activeColor: FreshPressColors.lightBlue,
                  value: _isSubscribedToUpdates,
                  onChanged: (value) => {
                    setState(() => _isSubscribedToUpdates = value!),
                    debugPrint("$_isSubscribedToUpdates")
                  },
                ),
                const Text('Subscribe to receive product updates'),
              ],
            ),
            const SizedBox(height: 80,),

            SizedBox(
              width: w * .5,
              height: 50,
              child: ElevatedButton(
                onPressed: isFormValid ? () async {

                  bool hasInternetConnection = await InternetConnection().hasInternetAccess;

                  if(!hasInternetConnection){
                    showToastMessage(message: 'No internet connection - please try again');
                    return;
                  }

                  if(_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                      _repeatPasswordController.text.isNotEmpty &&
                      _passwordController.text == _repeatPasswordController.text
                  ){
                    signUpCubit.registerWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                        _repeatPasswordController.text,
                        _isSubscribedToUpdates,
                      context

                    );
                  }
                } : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(isFormValid ? FreshPressColors.lightBlue : FreshPressColors.transparentBlue),
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
                    Text("Proceed", style: TextStyle(color: FreshPressColors.darkBlue, fontSize: 18),)
                  ],
                ),

              ),
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Have an account already? ',
                            style: TextStyle(
                              color: Colors.black,
                                fontSize: 12
                            )
                        ),
                        TextSpan(
                            text: "Log in",
                            style: TextStyle(
                                color: FreshPressColors.darkBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
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
            SizedBox(height: 70,),
            Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'By Signing up, you agree to our ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12

                            )
                        ),
                        TextSpan(
                            text: "Terms",
                            style: TextStyle(
                                color: FreshPressColors.darkBlue,
                                fontWeight: FontWeight.bold
                            ),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.of(context).pushNamed(TermsOfUsageScreen.routeName);
                            }
                        ),
                        TextSpan(
                            text: " and ",
                            style: TextStyle(
                              color: Colors.black,
                                fontSize: 12
                            ),

                        ),

                        TextSpan(
                            text: "Privacy\nPolicy",
                            style: TextStyle(
                                color: FreshPressColors.darkBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                            ),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.of(context).pushNamed(PrivacyPolicyScreen.routeName);
                            }
                        )
                      ]
                  ),
                )
                // Text("Have an account already? Log in")
              ],
            ),
          ],
        ),
      ),

    );
  }
}






