import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/data/models/approve_response.dart';
import 'package:imba/data/models/meeting_request_response.dart';

import '../../data/models/appointment_response.dart';
import '../../data/repositories/appointment_repo.dart';
import '../../secure_storage/secure_storage_manager.dart';
import 'approve_event.dart';
import 'approve_state.dart';

class ApproveBloc extends Bloc<ApproveEvent, ApproveState> {
  final AppointmentRepositoryImpl appointmentRepositoryImpl;

  final SecureStorageManager storage;

  static const String LOG_NAME = 'bloc.appointments';

  ApproveBloc({required this.storage, required this.appointmentRepositoryImpl})
      : super(ApproveInitialState()) {
    on<ApproveRequestEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(ApproveLoadingState());
      try {
        ApproveResponse approveResponse = await appointmentRepositoryImpl
            .approveRequest(token, event.requestId, event.approved);

        dev.log('approving success, search :$approveResponse',
            name: LOG_NAME);
        emit(ApproveSuccessState(approveResponse: approveResponse));
      } on SocketException catch (err) {
        dev.log('Failed to approve, error: $err');
        emit(ApproveFailedState(err.message));
      } catch (err) {
        dev.log('Failed to approve, error: $err');
        emit(ApproveFailedState(err.toString().replaceAll("Exception:","")));
      }
    });


    on<RejectRequestEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(RejectLoadingState());
      try {
        ApproveResponse rejectResponse = await appointmentRepositoryImpl
            .approveRequest(token, event.requestId, event.approved);

        dev.log('rejecting success, search :$rejectResponse',
            name: LOG_NAME);
        emit(RejectSuccessState(rejectResponse: rejectResponse));
      } on SocketException catch (err) {
        dev.log('Failed reject, error: $err');
        emit(RejectFailedState(err.message));
      } catch (err) {
        dev.log('Failed to reject, error: $err');
        emit(RejectFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<ApproveRefreshEvent>((event, emit) async {
      emit(ApproveInitialState());
    });
  }
}