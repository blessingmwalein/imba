import 'dart:convert';
import 'dart:developer' as dev;

import 'package:exception_templates/exception_templates.dart';
import 'package:http/http.dart' as http;
import 'package:imba/data/models/Interest_response.dart';
import 'package:imba/data/models/error_response.dart';

import '../../exceptions/app_exceptions.dart';
import '../../utilities/constants.dart';
import '../models/rating_response.dart';

class ActionsApi {
  static const String logName = 'api.app';

  late final http.Client httpClient;

  ActionsApi({required this.httpClient});

  Future<RatingResponse> rate(String token, int houseId, int rate) async {
    try{
      final response = await http.post(
        Uri.parse(
            '$BASE_URL/house/rating?token=$token&houseId=$houseId&rate=$rate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 100));

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        print(response.body.toString());
        return RatingResponse.fromJson(json);
      } else if (response.statusCode == 400 &&
          response.body ==
              '{"error":"Request could not be completed with incomplete PROFILE kindly navigate to Options tab on Home Page and complete your profile to proceed.","errorCode":400,"details":"Request data invalid"}') {
        throw Exception('not registered');
      } else if (response.statusCode == 400 &&
          response.body ==
              '{"error":"User cannot rate their own house","errorCode":400,"details":"Request data invalid"}') {
        throw Exception('can not review your own house');
      } else {

        var res= ErrorResponse.fromJson(jsonDecode(response.body));
        throw Exception(res.details);

      }}
    catch (e) {
      dev.log('Failed to get data: $e', name: logName);
      throw Exception(e);
    }

  }

  Future<InterestResponse> initiateInterest(String token, int houseId) async {
    try {
      final response = await http.post(
        Uri.parse(
            '$BASE_URL/house/occupation/request?token=$token&houseId=$houseId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 100));

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        print(response.body.toString());
        return InterestResponse.fromJson(json);
      } else if (response.statusCode == 400 &&
          response.body ==
              '{"error":"Request could not be completed with incomplete PROFILE kindly navigate to Options tab on Home Page and complete your profile to proceed.","errorCode":400,"details":"Request data invalid"}') {
        throw Exception('not registered');
      } else if (response.statusCode == 400 &&
          response.body ==
              '{"error":"User cannot rate their own house","errorCode":400,"details":"Request data invalid"}') {
        throw Exception('can not review your own house');
      } else {
       var res= ErrorResponse.fromJson(jsonDecode(response.body));
        throw Exception(res.details);
      }
    } catch (e) {
      dev.log('Failed to get data: $e', name: logName);
      throw Exception(e);
    }
  }
}
