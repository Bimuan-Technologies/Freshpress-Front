


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshpress_customer/bloc/identity/signin_state.dart';
import 'package:freshpress_customer/common/util/checks/helper.dart';
import 'package:velocity_x/velocity_x.dart';


import '../../common/cache/local_caching.dart';
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
      if(result.statusCode == 200 && result.data.accessToken.isNotEmptyAndNotNull){

        await _localCache.clearAll();
        debugPrint(result.data.accessToken);
        _localCache.getValue<String>("cached_access_token") ?? _localCache.saveValue<String>("cached_access_token", result.data.accessToken);
        _localCache.getValue<String>("cached_refresh_token") ?? _localCache.saveValue<String>("cached_refresh_token", result.data.refreshToken);
        _localCache.getValue<String>("cached_person_role") ?? _localCache.saveValue<String>("cached_person_role", result.data.role);


        // if(trustDevice){
        //   await storage.saveData('email_biometric', payload.usernameEmail);
        //   await storage.saveData('password_biometric', payload.password);
        //   await storage.saveBool('trust_device_biometric', trustDevice);
        // } else {
        //   await storage.clearSecureStorage();
        // }
      }
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