import '../data_providers/actions_api.dart';
import '../models/Interest_response.dart';
import '../models/rating_response.dart';

abstract class ActionsRepository {
  Future<RatingResponse> rate(String token, int houseId, int rate);

  Future<InterestResponse> initiateInterest(String token, int houseId);
}

class ActionsRepositoryImpl implements ActionsRepository {
  final ActionsApi api;

  ActionsRepositoryImpl({required this.api});

  @override
  Future<RatingResponse> rate(String token, int houseId, int rate) async {
    return await api.rate(token, houseId, rate);
  }

  @override
  Future<InterestResponse> initiateInterest(String token, int houseId) async {
    return await api.initiateInterest(token, houseId);
  }
}
