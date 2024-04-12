

import '../../data/models/auth/signup_model.dart';
import '../../data/models/auth/verify_email_model.dart';

abstract class RegisterState {}

class RegisterEmailPasswordIdle extends RegisterState{}

class RegisterEmailPasswordProgress extends RegisterState{}

class RegisterEmailPasswordSuccess extends RegisterState {
  final SignUpResponseModel data;
  RegisterEmailPasswordSuccess(this.data);
}

class RegisterEmailPasswordFailure extends RegisterState {
  final String message;
  RegisterEmailPasswordFailure(this.message);
}


// Email Verification

class RegisterEmailVerificationSuccess extends RegisterState {
  final VerifyEmailResponseModel data;
  RegisterEmailVerificationSuccess(this.data);
}

class RegisterEmailVerificationFailure extends RegisterState {
  final String message;
  RegisterEmailVerificationFailure(this.message);
}
