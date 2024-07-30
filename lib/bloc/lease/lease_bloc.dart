import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/bloc/payment/payment_event.dart';
import 'package:imba/bloc/payment/payment_state.dart';
import 'package:imba/data/models/lease_agreement.dart';
import 'package:imba/data/repositories/payment_repo.dart';

import '../../data/models/payment_response.dart';
import '../../data/repositories/lease_repo.dart';
import '../../secure_storage/secure_storage_manager.dart';
import 'lease_event.dart';
import 'lease_state.dart';

class LeaseBloc extends Bloc<LeaseEvent, LeaseState> {
  final LeaseRepositoryImpl leaseRepositoryImpl;

  final SecureStorageManager storage;

  static const String LOG_NAME = 'bloc.lease';

  LeaseBloc({required this.storage, required this.leaseRepositoryImpl})
      : super(LeaseInitialState()) {
    on<GetInterestsEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(LeaseLoadingState());
      try {
        List<LeaseAgreement> leaseAgreement = await leaseRepositoryImpl
            .viewHouseInterests(token);

        dev.log('viewing house interest successful, leaseResposne :$leaseAgreement',
            name: LOG_NAME);
        emit(LeaseSuccessState(leaseAgreement: leaseAgreement));
      } on SocketException catch (err) {
        dev.log('Failed to get list of house interests, error: $err');
        emit(LeaseFailedState(err.message));
      } catch (err) {
        dev.log('Failed to get list of house interests, error: $err');
        emit(LeaseFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<UpdateLeaseEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(UpdateLoadingState());
      try {
      String response = await leaseRepositoryImpl
            .updateLease(token, event.maintenance, event.notice, event.period, event.fees, event.landLordPhone, event.tenantPhone, event.leaseId, event.houseId);

        dev.log('update lease, update lease response :$response',
            name: LOG_NAME);
        emit(LeaseUpdateSuccessState(response: response));
      } on SocketException catch (err) {
        dev.log('Failed update lease, error: $err');
        emit(UpdateFailedState(err.message));
      } catch (err) {
        dev.log('Failed update lease, error: $err');
        emit(UpdateFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<InterestsResetEvent>((event, emit) async {

      emit(LeaseInitialState());

    });
  }
}
