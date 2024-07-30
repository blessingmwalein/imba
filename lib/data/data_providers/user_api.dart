import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:imba/utilities/encrypt_utils.dart';

import '../../exceptions/app_exceptions.dart';
import '../../exceptions/login_exception.dart';
import '../../utilities/constants.dart';
import '../models/error_response.dart';
import '../models/user_response.dart';

class UserApi {
  static const String devUrl = 'http://127.0.0.1:8002/api';
  static const String prodUrl = 'http://127.0.0.1:8002/api';
  static const String logName = 'user_api.app';

  late final http.Client httpClient;

  UserApi({required this.httpClient});

  Future<String> getToken(String macAddress) async {
    try {
      final response = await http.post(
          Uri.parse('$BASE_URL/user/create?macAdd=$macAddress'),
          headers: <String, String>{}).timeout(const Duration(seconds: 100));

      return _processResponse(response);
    } catch (e) {
      dev.log('Failed to get data: $e', name: logName);
      throw ExceptionHandler().getExceptionString(e);
    }
  }

  Future<UserResponse> updateUser(String firstName, String lastName,
      String nationalId, String phoneNumber, String email, String token) async {
    try {
      final response = await http
          .post(
            Uri.parse('$BASE_URL/user/update'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'phoneNumber': phoneNumber,
              'firstname': encrypt(key, firstName).base64,
              'lastname': encrypt(key, lastName).base64,
              'nationalId': encrypt(key, nationalId).base64,
              'email': encrypt(key, email).base64,
              'token': token
            }),
          )
          .timeout(const Duration(seconds: 100));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return UserResponse.fromJson(json);
      } else {
        var res = ErrorResponse.fromJson(jsonDecode(response.body));
        throw Exception(res.details);
      }
    } catch (e) {
      dev.log('Failed to get data: $e', name: logName);
      throw ExceptionHandler().getExceptionString(e);
    }
  }

  Future<UserResponse> getUser(String token) async {
    try {
      final response = await http.post(
          Uri.parse('$BASE_URL/user/get-user?token=$token'),
          headers: <String, String>{}).timeout(const Duration(seconds: 100));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return UserResponse.fromJson(json);
      } else {
        var res = ErrorResponse.fromJson(jsonDecode(response.body));
        throw Exception(res.details);
      }
    } catch (e) {
      dev.log('Failed to get data: $e', name: logName);
      throw ExceptionHandler().getExceptionString(e);
    }
  }

  _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var token = response.body;

          return token;
        }
      default:
        {
          throw FetchDataException(_getResponseMessage(response));
        }
    }
  }

  _getResponseMessage(var response) {
    var res = ErrorResponse.fromJson(jsonDecode(response.body));
    return res.details;
  }
}
