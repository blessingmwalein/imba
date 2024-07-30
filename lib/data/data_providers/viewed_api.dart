import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:imba/data/models/viewed_response.dart';

import '../../utilities/constants.dart';
import '../models/error_response.dart';
import '../models/house_response.dart';

class ViewedApi {
  static const String logName = 'api.app';

  late final http.Client httpClient;

  ViewedApi({required this.httpClient});


  Future<List<HouseResponse>> getViewedHouses(String token) async {
    try {
      final response = await http.get(
          Uri.parse('$BASE_URL/house/view/list?token=$token'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }).timeout(const Duration(seconds: 100));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List<HouseResponse> newData = List<HouseResponse>.from(
            json.map((element) => HouseResponse.fromJson(element)));
        return newData;
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
