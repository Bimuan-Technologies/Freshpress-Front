

class VerifyEmailResponseModel {
  int statusCode;
  String message;
  Data data;

  VerifyEmailResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory VerifyEmailResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyEmailResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: Data.fromJson(json['data']),
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

class Data {
  String accessToken;
  String refreshToken;
  String role;

  Data({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accessToken: json['accesstoken'],
      refreshToken: json['refreshtoken'],
      role: json['role'],
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
