


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshpress_customer/bloc/identity/signin_state.dart';
import 'package:freshpress_customer/common/util/checks/helper.dart';

import '../../common/caching/local_caching.dart';
import '../../common/exception/invalid_otp_exception.dart';
import '../../common/util/notification_box/toast_alert.dart';
import '../../data/models/auth/signin_model.dart';
import '../../data/repositories/identity_repository.dart';
import '../../ui/dashboard/dashboard_navigation.dart';

class SignInCubit extends Cubit<LoginState>{

  final LocalCache _localCache = LocalCache();

  final IdentityRepository _identityRepository;

  SignInCubit(this._identityRepository) : super(LoginIdle());

  Future<void> loginWithEmailPassword(String? email, String? password, BuildContext ctx) async {

    emit(LoginProgress());

    if(!areAllNonNull([email, password])){
      showToastMessage(message: 'Invalid null value');
      return;
    }

    debugPrint("$email $password");

    LoginRequestModel payload = LoginRequestModel(
        email: email!,
        password: password!
    );
    try {
      final result = await _identityRepository.login(payload);
      emit(LoginSuccess(result));
      showToastMessage(message:  result.message);
      if (!ctx.mounted) return;
      Navigator.of(ctx).pushReplacementNamed(DashboardNavigation.routeName);

    } on InvalidLoginCredentials catch(e){
      emit(LoginFailure(e.data!.message));
      showToastMessage(message: e.data!.message);
    } catch(e){
      emit(LoginFailure(e.toString()));
      showToastMessage(message: e.toString());
    }
  }
}