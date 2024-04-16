import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshpress_customer/bloc/identity/signin_cubit.dart';
import 'package:freshpress_customer/data/repositories/identity_repository.dart';
import 'package:freshpress_customer/ui/dashboard/dashboard_navigation.dart';
import 'package:freshpress_customer/ui/identity/forgotpassword/first_step.dart';
import 'package:freshpress_customer/ui/legal/privacy_policy.dart';
import 'package:freshpress_customer/ui/legal/terms_of_usage.dart';
import 'package:freshpress_customer/ui/walkthrough/get_started_screen.dart';
import 'package:freshpress_customer/ui/identity/login/signin_screen.dart';
import 'package:freshpress_customer/ui/identity/register/email_and_password_first_screen.dart';
import 'package:freshpress_customer/ui/identity/register/otp_verification_second_screen.dart';
import 'package:freshpress_customer/ui/walkthrough/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/identity/signup_cubit.dart';
import 'common/caching/local_caching.dart';
import 'common/util/theme/custom_theme.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpCubit>(create: (context) => SignUpCubit(IdentityRepository())),
        BlocProvider<SignInCubit>(create: (context) => SignInCubit(IdentityRepository()))
      ],
      child: MaterialApp(
        title: 'FreshPress on Demand Cleaning Services App',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
          useMaterial3: true,
        ),
        // darkTheme: FreshPressCustomThemes.darkTheme,
        // theme: FreshPressCustomThemes.lightTheme,
        home: const SplashScreen(),
        routes: {
          GetStartedScreen.routeName: (context) => const GetStartedScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          OtpVerificationSignUpScreen.routeName: (context) => const OtpVerificationSignUpScreen(),
          SignInScreen.routeName: (context) => const SignInScreen(),
          ForgotPasswordFirstStepScreen.routeName: (context) => const ForgotPasswordFirstStepScreen(),
          DashboardNavigation.routeName: (context) => const DashboardNavigation(),

          PrivacyPolicyScreen.routeName: (context) => const PrivacyPolicyScreen(),
          TermsOfUsageScreen.routeName: (context) => const TermsOfUsageScreen()
        },
      ),
    );
  }
}


