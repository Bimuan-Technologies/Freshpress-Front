
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../common/caching/local_caching.dart';
import '../../common/constants/freshpress_api_endpoint.dart';
import '../models/user/user_detail_response_model.dart';

class UserRepository {
  final LocalCache _localCache = LocalCache();

  Future<UserResponseModel> fetchUser() async {

    final response = await http.get(
      Uri.parse(FreshPressAPIEndpoints.fetchUserUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${_localCache.getValue<String>('cached_access_token')}',
      },
    );

    if(response.statusCode == 200){
      return UserResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch user details: ${response.body}");
    }
  }
}