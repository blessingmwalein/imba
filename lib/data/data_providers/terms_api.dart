import 'dart:developer' as dev;

import 'package:http/http.dart' as http;

import '../../exceptions/app_exceptions.dart';
import '../../exceptions/login_exception.dart';
import '../../utilities/constants.dart';

class TermsApi {
  static const String logName = 'api.app';

  late final http.Client httpClient;

  TermsApi({required this.httpClient});

  Future<String> getTerms() async {
    try {
      final response = await http.post(Uri.parse('$BASE_URL/user/tcs'),
          headers: <String, String>{}).timeout(const Duration(seconds: 100));

      return _processResponse(response);
    } catch (e) {
      dev.log('Failed to get data: $e', name: logName);
      throw ExceptionHandler().getExceptionString(e);
    }
  }

  Future<String> acceptTerms(String token) async {
    try {
      final response = await http.post(
          Uri.parse('$BASE_URL/user/tcs/accept?token=$token'),
          headers: <String, String>{}).timeout(const Duration(seconds: 100));

      return _processResponse(response);
    } catch (e) {
      dev.log('Failed to get terms: $e', name: logName);
      throw ExceptionHandler().getExceptionString(e);
    }
  }

  _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var resp = response.body;

          return resp;
        }
      default:
        {
          throw FetchDataException(_getResponseMessage(response));
        }
    }
  }

  _getResponseMessage(var response) {
    return response.body['message'];
  }
}
