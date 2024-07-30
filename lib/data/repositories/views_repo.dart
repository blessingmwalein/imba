
import 'package:imba/data/data_providers/viewed_api.dart';

import '../models/house_response.dart';
import '../models/viewed_response.dart';

abstract class ViewedRepository {

  Future<List<HouseResponse>>getViewedHouses(String token);

}

class ViewedRepositoryImpl implements ViewedRepository {
  final ViewedApi api;

  ViewedRepositoryImpl({required this.api});


  @override
  Future<List<HouseResponse>> getViewedHouses(String token) async {
    return await api.getViewedHouses(token);
  }

}
