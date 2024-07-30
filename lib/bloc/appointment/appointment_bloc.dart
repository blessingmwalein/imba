import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/data/models/approve_response.dart';
import 'package:imba/data/models/meeting_request_response.dart';

import '../../data/models/appointment_response.dart';
import '../../data/repositories/appointment_repo.dart';
import '../../secure_storage/secure_storage_manager.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepositoryImpl appointmentRepositoryImpl;

  final SecureStorageManager storage;

  static const String LOG_NAME = 'bloc.appointments';

  AppointmentBloc(
      {required this.storage, required this.appointmentRepositoryImpl})
      : super(AppointmentInitialState()) {
    on<ReserveAppointmentEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(AppointmentLoadingState());
      try {
        AppointmentResponse appointmentResults = await appointmentRepositoryImpl
            .reserve(token, event.houseId, event.startDate, event.endDate);

        dev.log('appointment reserved successful, search :$appointmentResults',
            name: LOG_NAME);
        emit(AppointmentSuccessState(appointmentResponse: appointmentResults));
      } on SocketException catch (err) {
        dev.log('Failed to resrve appointment, error: $err');
        emit(AppointmentFailedState(err.message));
      } catch (err) {
        dev.log('Failed to reserve appointment, error: $err');
        emit(AppointmentFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<GetMeetingsAndRequestEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(AppointmentLoadingState());
      try {
        MeetingRequestsResponse meetingRequestsResponse = await appointmentRepositoryImpl
            .getMeetingAndRequest(token);

        dev.log('getting meetings and requests successful, search :$meetingRequestsResponse',
            name: LOG_NAME);
        emit(MeetingsAndRequestsSuccessState(meetingRequestsResponse: meetingRequestsResponse));
      } on SocketException catch (err) {
        dev.log('Failed to get meetings and request, error: $err');
        emit(AppointmentFailedState(err.message));
      } catch (err) {
        dev.log('Failed to get meeting and request, error: $err');
        emit(AppointmentFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<AppointmentRefreshEvent>((event, emit) async {

      emit(AppointmentInitialState());

    });



  }


}
