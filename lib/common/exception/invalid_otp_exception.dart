


class InvalidOtpCodeException implements Exception {
  final String? message;

  InvalidOtpCodeException({required this.message});
}


class InvalidLoginCredentials implements Exception{
  final ErrorResponseModel? data;
  InvalidLoginCredentials({required this.data});
}

class ErrorResponseModel {
  int statusCode;
  String message;

  ErrorResponseModel({
    required this.statusCode,
    required this.message,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
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
