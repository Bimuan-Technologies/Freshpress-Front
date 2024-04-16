import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freshpress_customer/bloc/identity/signin_state.dart';
import 'package:freshpress_customer/ui/walkthrough/get_started_screen.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../bloc/identity/signin_cubit.dart';
import '../../../common/constants/freshpress_color.dart';
import '../../../common/constants/freshpress_image_path.dart';
import '../../../common/util/checks/helper.dart';
import '../../../common/util/notification_box/toast_alert.dart';
import '../forgotpassword/first_step.dart';
import '../register/email_and_password_first_screen.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  late SignInCubit _signInCubit;

  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isDeviceTrusted = false;

  @override
  void initState(){
    super.initState();
    _signInCubit = BlocProvider.of<SignInCubit>(context);
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
              child: BlocBuilder<SignInCubit, LoginState>(
                builder: (context, state) {
                  if(state is LoginProgress){
                    return  SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: CircularProgressIndicator(color: FreshPressColors.greyText,))
                    );
                  } else if (state is LoginSuccess){
                    return buildUI(w, h, _signInCubit);
                  } else if(state is LoginFailure){
                    debugPrint(state.message);
                    return buildUI(w, h, _signInCubit);
                  } else {
                    return buildUI(w, h, _signInCubit);
                  }
                },

              )
              //
            ),
          ),
        )
    );
  }

  Widget buildUI(double w, double h, SignInCubit signInCubit){
    bool isFormValid = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
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
            const Column(
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Welcome back! Login to your account to access all the\namazing features freshpress has to offer.")
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
            const SizedBox(height: 5,),
            SizedBox(
              width: w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        checkColor: FreshPressColors.darkBlue,
                        activeColor: FreshPressColors.lightBlue,
                        value: _isDeviceTrusted,
                        onChanged: (value) => {
                          setState(() => _isDeviceTrusted = value!),
                          debugPrint("$_isDeviceTrusted")
                        },
                      ),
                      const Text('Keep me login?'),
                    ],
                  ),

                  InkWell(
                    onTap: (){
                      // showToastMessage(message: 'Yet to be implemented');
                      Navigator.of(context).pushNamed(ForgotPasswordFirstStepScreen.routeName);
                    },
                    child: const Text("Forgot password?",
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
                onPressed: isFormValid ? ()
                async {

                  if(!isEmailAddressValid(_emailController.text)){
                    showToastMessage(message: "Invalid email address format");
                    return;
                  }
                  bool hasInternetConnection = await InternetConnection().hasInternetAccess;

                  if(!hasInternetConnection){
                    showToastMessage(message: 'No internet connection - please try again');
                    return;
                  }

                  if(_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty ){

                    await signInCubit.loginWithEmailPassword(
                        _emailController.text,
                      _passwordController.text,
                      context
                    );
                  } else {
                    showToastMessage(message: "Empty login credentials");
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
                    Text("Login", style: TextStyle(color: FreshPressColors.darkBlue, fontSize: 18),)
                  ],
                ),

              ),
            ),
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Don\'t you have an account? ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12
                            )
                        ),
                        TextSpan(
                            text: "Sign up",
                            style: TextStyle(
                                color: FreshPressColors.darkBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                            ),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.of(context).pushNamed(SignUpScreen.routeName);
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
