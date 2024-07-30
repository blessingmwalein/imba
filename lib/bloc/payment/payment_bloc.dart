import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/bloc/payment/payment_event.dart';
import 'package:imba/bloc/payment/payment_state.dart';
import 'package:imba/data/repositories/payment_repo.dart';

import '../../data/models/payment_response.dart';
import '../../secure_storage/secure_storage_manager.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepositoryImpl paymentRepositoryImpl;

  final SecureStorageManager storage;

  static const String LOG_NAME = 'bloc.uploads';

  PaymentBloc({required this.storage, required this.paymentRepositoryImpl})
      : super(PaymentInitialState()) {
    on<MakePaymentEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(PaymentLoadingState());
      try {
        PaymentResponse paymentResponse = await paymentRepositoryImpl
            .makePayment(token: token, houseId: event.houseId);

        dev.log('payment successful, paymentResponse :$paymentResponse',
            name: LOG_NAME);
        emit(PaymentSuccessState(paymentResponse: paymentResponse));
      } on SocketException catch (err) {
        dev.log('Failed to get house by id, error: $err');
        emit(PaymentFailedState(err.message));
      } catch (err) {
        dev.log('Failed to get house by id, error: $err');
        emit(PaymentFailedState(err.toString().replaceAll("Exception:","")));
      }
    });
  }
}
