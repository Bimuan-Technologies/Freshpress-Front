

class SignUpRequestModel {
  String email;
  String password;
  String cpassword;
  bool getProductUpdate;

  SignUpRequestModel({
    required this.email,
    required this.password,
    required this.cpassword,
    required this.getProductUpdate,
  });

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) {
    return SignUpRequestModel(
      email: json['email'] as String,
      password: json['password'] as String,
      cpassword: json['cpassword'] as String,
      getProductUpdate: json['get_product_update'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'cpassword': cpassword,
      'get_product_update': getProductUpdate,
    };
  }
}


class SignUpResponseModel {
  int statusCode;
  String message;

  SignUpResponseModel({
    required this.statusCode,
    required this.message,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
    };
  }
}

