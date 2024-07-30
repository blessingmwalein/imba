import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:imba/data/models/approve_response.dart';
import 'package:imba/data/models/meeting_request_response.dart';

import '../../utilities/constants.dart';
import '../models/appointment_response.dart';
import '../models/error_response.dart';

class AppointmentApi {
  static const String logName = 'api.app';

  late final http.Client httpClient;

  AppointmentApi({required this.httpClient});

  Future<AppointmentResponse> reserve(
      String token, int houseId, String startDate, String endDate) async {
    try {
      final response = await http.post(
        Uri.parse(
            '$BASE_URL/house/appointment/request?token=$token&houseId=$houseId&startDate=$startDate&endDate=$endDate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 100));

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        print(response.body.toString());
        return AppointmentResponse.fromJson(json);
      } else if (response.statusCode == 400 &&
          response.body ==
              '{"error":"Request could not be completed with incomplete PROFILE kindly navigate to Options tab on Home Page and complete your profile to proceed.","errorCode":400,"details":"Request data invalid"}') {
        throw Exception('not registered');
      } else {
        var res= ErrorResponse.fromJson(jsonDecode(response.body));
        throw Exception(res.details);
      }
    } catch (e) {
      dev.log('Failed to get data: $e', name: logName);
      throw Exception(e);
    }
  }


  Future<MeetingRequestsResponse> getMeetingAndRequest(
      String token) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$BASE_URL/house/view/meetings?token=$token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 100));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(response.body.toString());
        return MeetingRequestsResponse.fromJson(json);
      } else if (response.statusCode == 400 &&
          response.body ==
              '{"error":"Request could not be completed with incomplete PROFILE kindly navigate to Options tab on Home Page and complete your profile to proceed.","errorCode":400,"details":"Request data invalid"}') {
        throw Exception('not registered');
      } else {
        var res= ErrorResponse.fromJson(jsonDecode(response.body));
        throw Exception(res.details);
      }
    } catch (e) {
      dev.log('Failed to get data: $e', name: logName);
      throw Exception(e);
    }
  }

  Future<ApproveResponse> approveRequest(
      String token, int requestId, bool approve) async {
    try {
      final response = await http.post(
        Uri.parse(
            '$BASE_URL/house/appointment/response?response=$approve&token=$token&requestId=$requestId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 100));

      if (response.statusCode == 202) {
        final json = jsonDecode(response.body);
        print(response.body.toString());
        return ApproveResponse.fromJson(json);
      } else if (response.statusCode == 400 &&
          response.body ==
              '{"error":"Request could not be completed with incomplete PROFILE kindly navigate to Options tab on Home Page and complete your profile to proceed.","errorCode":400,"details":"Request data invalid"}') {
        throw Exception('not registered');
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
