

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshpress_customer/bloc/user/user_state.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/caching/local_caching.dart';
import '../../data/repositories/user_repository.dart';

class UserCubit extends Cubit<UserDetailsState>{
  final LocalCache _localCache = LocalCache();
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(UserDetailsIdle());


  Future<void> fetchUserDetails() async {

    emit(UserDetailsProgress());
    try{
      final responseData = await _userRepository.fetchUser();
      if(responseData.statusCode == 200 && responseData.userData.id.isNotEmptyAndNotNull){
        debugPrint(responseData.userData.email);
        emit(UserDetailsSuccess(responseData));
      } else {
        emit(UserDetailsFailure("Invalid response data occurred"));
      }

    } catch (e){
      emit(UserDetailsFailure(e.toString()));
    }
  }
}