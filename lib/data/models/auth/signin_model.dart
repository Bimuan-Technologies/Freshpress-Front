class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}



class LoginResponseDataModel {
  String accessToken;
  String refreshToken;
  String role;

  LoginResponseDataModel({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  factory LoginResponseDataModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseDataModel(
      accessToken: json['accesstoken'] as String,
      refreshToken: json['refreshtoken'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accesstoken': accessToken,
      'refreshtoken': refreshToken,
      'role': role,
    };
  }
}


class LoginResponseModel {
  int statusCode;
  String message;
  LoginResponseDataModel data;

  LoginResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: LoginResponseDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

