

import '../../data/models/auth/signin_model.dart';

abstract class LoginState {}

class LoginIdle extends LoginState{}

class LoginProgress extends LoginState{}

class LoginSuccess extends LoginState {
  final LoginResponseModel data;
  LoginSuccess(this.data);
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}
