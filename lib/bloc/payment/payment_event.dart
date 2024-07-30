import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {}

class MakePaymentEvent extends PaymentEvent {
  final int houseId;

  MakePaymentEvent({required this.houseId});

  @override
  List<Object> get props => [houseId];
}
