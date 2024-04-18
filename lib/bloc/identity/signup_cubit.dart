

import 'package:flutter/material.dart';
import 'package:freshpress_customer/bloc/identity/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshpress_customer/data/models/auth/signup_model.dart';
import 'package:freshpress_customer/data/repositories/identity_repository.dart';
import '../../common/cache/local_caching.dart';
import '../../common/exception/account_registered_already_exception.dart';
import '../../common/exception/invalid_otp_exception.dart';
import '../../common/util/checks/helper.dart';
import '../../common/util/notification_box/toast_alert.dart';
import '../../ui/identity/register/otp_verification_second_screen.dart';
import '../../ui/walkthrough/get_started_screen.dart';

class SignUpCubit extends Cubit<RegisterState>{

  final LocalCache _localCache = LocalCache();

  final IdentityRepository _identityRepository;

  SignUpCubit(this._identityRepository) : super(RegisterEmailPasswordIdle());

  Future<void> registerWithEmailAndPassword(String? email, String? password, String? cPassword, bool getProductUpdate, BuildContext ctx) async {
    emit(RegisterEmailPasswordProgress());

    if(!areAllNonNull([email, password, cPassword])){
      showToastMessage(message: 'Invalid null value');
      return;
    }

    debugPrint("$email $password $cPassword $getProductUpdate");

    _localCache.getValue<String>("cached_email_register") ?? _localCache.saveValue<String>("cached_email_register", email!);

    SignUpRequestModel payload = SignUpRequestModel(
        email: email!,
        password: password!,
        cpassword: cPassword!,
        getProductUpdate: getProductUpdate
    );

    try {
      final result = await _identityRepository.registerWithEmailAndPassword(payload);
      emit(RegisterEmailPasswordSuccess(result));
      showToastMessage(message:  result.message);
      if (!ctx.mounted) return;
      Navigator.of(ctx).pushNamedAndRemoveUntil(OtpVerificationSignUpScreen.routeName, (Route previousRoute) => previousRoute == GetStartedScreen.routeName);

    } on AccountRegisteredAlreadyException catch(e){
      emit(RegisterEmailPasswordFailure(e.message!));
      showToastMessage(message: e.message!);
    } catch(e){
      emit(RegisterEmailPasswordFailure(e.toString()));
      showToastMessage(message: e.toString());
    }
  }

  Future<void> resendOtpCodeEmailVerification(String? email) async {

    if(!areAllNonNull([email])){
      showToastMessage(message: 'Invalid null value');
      return;
    }
    debugPrint("$email");
    try{
      final result = await _identityRepository.resendOtpVerifyEmail(email!);
      showToastMessage(message:  result.message);
      return;
    } catch (e){
      showToastMessage(message: e.toString());
    }
  }
  Future<bool> verifyOtpCodeEmailVerification(String? otpCode) async {
    emit(RegisterEmailPasswordProgress());

    if(!areAllNonNull([otpCode])){
      showToastMessage(message: 'Invalid null value');
      return false;
    }

    try {
      final result = await _identityRepository.verifyEmailWithCode(otpCode!);
      emit(RegisterEmailVerificationSuccess(result));
      showToastMessage(message:  result.message);
      return true;

    } on InvalidOtpCodeException catch(e){
      emit(RegisterEmailVerificationFailure(e.message!));
      showToastMessage(message: e.message!);
      return false;
    } catch(e){
      emit(RegisterEmailVerificationFailure(e.toString()));
      showToastMessage(message: e.toString());
      return false;
    }

  }
  }
