

class FreshPressAPIEndpoints {

  FreshPressAPIEndpoints._();

  // Base URLs
  static const String domainUrl = "https://api-freshpress.onrender.com";
  static const String baseUrl = "$domainUrl/api/v1";

//   Identity API Endpoints
  static const String registerEmailPasswordUrl = "$baseUrl/user/signup";
  static const String registerVerifyEmailUrl = "$baseUrl/user/verify-email";
  static const String resendOtpVerifyEmailUrl = "$baseUrl/user/resend-otp";
  static const String loginUrl = "$baseUrl/user/signin";

//   User API Endpoints
  static const String fetchUserUrl = "$baseUrl/user/fetch-user";
}