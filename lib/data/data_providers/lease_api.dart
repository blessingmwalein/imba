import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:imba/data/models/lease_agreement.dart';

import '../../exceptions/login_exception.dart';
import '../../utilities/constants.dart';
import '../models/error_response.dart';

class LeaseApi {
  static const String logName = 'lease.app';
  late final http.Client httpClient;

  LeaseApi({required this.httpClient});

  Future<List<LeaseAgreement>> viewHouseInterests(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/house/view/interests?token=$token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 100));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(response.body.toString());
        List<LeaseAgreement> newData = List<LeaseAgreement>.from(
            json.map((element) => LeaseAgreement.fromJson(element)));
        return newData;
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
      dev.log('Failed in  view house interests: $e', name: logName);
      throw Exception(e);
    }
  }

  Future<String> updateLease(
      String token,
      String maintenance,
      String notice,
      String period,
      String fees,
      String landLordPhone,
      String tenantPhone,
      int leaseId,
      int houseId) async {
    try {
      final response = await http
          .post(
            Uri.parse('$BASE_URL/house/create/document?token=$token'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'leaseId': leaseId,
              'maintenanceTerms': maintenance,
              'noticeTerms': notice,
              'leasePeriod': period,
              'rentPaymentTerms': fees,
              'landLord': landLordPhone,
              'tenant': tenantPhone,
              'house': houseId
            }),
          )
          .timeout(const Duration(seconds: 100));

      return _processResponse(response);
    } catch (e) {
      dev.log('Failed to get terms: $e', name: logName);
      throw ExceptionHandler().getExceptionString(e);
    }
  }

  _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 201:
        {
          var resp = response.body;

          return resp;
        }
      default:
        {
          throw Exception(response.body);
        }
    }
  }
}
