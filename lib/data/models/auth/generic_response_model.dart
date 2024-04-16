
class GenericResponseModel {
  final int statusCode;
  final String message;

  GenericResponseModel({
    required this.statusCode,
    required this.message,
  });

  factory GenericResponseModel.fromJson(Map<String, dynamic> json) {
    return GenericResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
    );
  }
}
