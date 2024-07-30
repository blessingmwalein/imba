import 'package:imba/data/data_providers/payment_api.dart';

import '../models/payment_response.dart';

abstract class PaymentRepository {
  Future<PaymentResponse> makePayment(
      {required String token, required int houseId});
}

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentApi api;

  PaymentRepositoryImpl({required this.api});

  @override
  Future<PaymentResponse> makePayment(
      {required String token, required int houseId}) async {
    return await api.makePayment(token, houseId);
  }
}
