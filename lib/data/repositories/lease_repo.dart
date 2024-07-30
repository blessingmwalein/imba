
import 'package:imba/data/data_providers/lease_api.dart';
import 'package:imba/data/models/lease_agreement.dart';

abstract class LeaseRepository {

  Future<List<LeaseAgreement>>viewHouseInterests(String token);
  Future<String>updateLease(String token, String maintenance, String notice, String period, String fees,
      String landLordPhone, String tenantPhone, int leaseId, int houseId);

}

class LeaseRepositoryImpl implements LeaseRepository {
  final LeaseApi api;

  LeaseRepositoryImpl({required this.api});


  @override
  Future<List<LeaseAgreement>> viewHouseInterests(String token) async {
    return await api.viewHouseInterests(token);
  }

  @override
  Future<String> updateLease(String token, String maintenance, String notice, String period, String fees,
      String landLordPhone, String tenantPhone, int leaseId, int houseId) async {

    return await api.updateLease(token, maintenance, notice, period, fees, landLordPhone, tenantPhone, leaseId, houseId);
  }



}
