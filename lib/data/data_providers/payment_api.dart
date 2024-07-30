import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;

import '../../utilities/constants.dart';
import '../models/error_response.dart';
import '../models/payment_response.dart';

class PaymentApi {
  static const String logName = 'api.app';

  late final http.Client httpClient;

  PaymentApi({required this.httpClient});

  Future<PaymentResponse> makePayment(String token, int houseId) async {
    try {
      final response = await http.get(
          Uri.parse('$BASE_URL/house/view?token=$token&houseId=$houseId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }).timeout(const Duration(seconds: 100));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return PaymentResponse.fromJson(json);
      } else {
        var res= ErrorResponse.fromJson(jsonDecode(response.body));
        throw Exception(res.details);
        //throw Exception(response.body);
      }
    } catch (e) {
      dev.log('Failed to make payment: $e', name: logName);
      throw Exception(e.toString());
    }
  }
}
