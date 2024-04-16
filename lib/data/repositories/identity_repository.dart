
import 'dart:convert';

import 'package:freshpress_customer/data/models/auth/generic_response_model.dart';
import 'package:http/http.dart' as http;
import '../../common/constants/freshpress_api_endpoint.dart';
import '../../common/exception/account_registered_already_exception.dart';
import '../../common/exception/invalid_otp_exception.dart';
import '../models/auth/signin_model.dart';
import '../models/auth/signup_model.dart';
import '../models/auth/verify_email_model.dart';

class IdentityRepository {

  Future<SignUpResponseModel> registerWithEmailAndPassword(SignUpRequestModel payload) async {
    final response = await http.post(Uri.parse(FreshPressAPIEndpoints.registerEmailPasswordUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload.toJson())
    );
    if(response.statusCode == 201){
      return SignUpResponseModel.fromJson(jsonDecode((response.body)));
    } else if(response.statusCode == 400){
      throw AccountRegisteredAlreadyException(message: "Account already registered. Please login");
    } else {
      throw Exception("Failed to register with email and password: ${response.body}");
    }
  }

  Future<VerifyEmailResponseModel> verifyEmailWithCode(String otpCode) async {
    final response = await http.get(
      Uri.parse('${FreshPressAPIEndpoints.registerVerifyEmailUrl}?otp=$otpCode'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );

    if(response.statusCode == 200){
      return VerifyEmailResponseModel.fromJson(jsonDecode(response.body));
    } else if(response.statusCode == 400){
      throw InvalidOtpCodeException(message: 'Invalid OTP!');
    } else {
      throw Exception("Failed to verify otp code: ${response.body}");
    }
  }

  Future<GenericResponseModel> resendOtpVerifyEmail(String resendEmail) async {

    final response = await http.get(
      Uri.parse('${FreshPressAPIEndpoints.resendOtpVerifyEmailUrl}?email=$resendEmail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode == 200){
      return GenericResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to resend otp code: ${response.body}");
    }
  }

  Future<LoginResponseModel> login(LoginRequestModel payload) async {

    final response = await http.post(Uri.parse(FreshPressAPIEndpoints.loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload.toJson())
    );

    if(response.statusCode == 201){
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else if(response.statusCode == 400){
      throw InvalidLoginCredentials(data: ErrorResponseModel.fromJson(jsonDecode(response.body)));
    } else if(response.statusCode == 500){
      throw Exception("Internal server error ${response.body}");
    }
    else {
      throw Exception("Failed to login person: ${response.body}");
    }
  }
 }