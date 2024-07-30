import 'package:equatable/equatable.dart';

import '../../data/models/payment_response.dart';

abstract class PaymentState extends Equatable {}

class PaymentInitialState extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentLoadingState extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentSuccessState extends PaymentState {
  final PaymentResponse paymentResponse;

  PaymentSuccessState({required this.paymentResponse});

  @override
  List<Object> get props => [PaymentResponse];
}

class PaymentFailedState extends PaymentState {
  final String message;

  PaymentFailedState(this.message);

  @override
  List<Object> get props => [message];
}
