

import '../../data/models/user/user_detail_response_model.dart';

abstract class UserDetailsState {}

class UserDetailsIdle extends UserDetailsState{}

class UserDetailsProgress extends UserDetailsState{}

class UserDetailsSuccess extends UserDetailsState {
  final UserResponseModel data;
  UserDetailsSuccess(this.data);
}

class UserDetailsFailure extends UserDetailsState {
  final String message;
  UserDetailsFailure(this.message);
}