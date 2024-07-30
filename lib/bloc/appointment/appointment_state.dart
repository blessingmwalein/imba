import 'package:equatable/equatable.dart';
import 'package:imba/data/models/meeting_request_response.dart';

import '../../data/models/appointment_response.dart';
import '../../data/models/approve_response.dart';

abstract class AppointmentState extends Equatable {}

class AppointmentInitialState extends AppointmentState {
  @override
  List<Object> get props => [];
}

class AppointmentLoadingState extends AppointmentState {
  @override
  List<Object> get props => [];
}

class AppointmentSuccessState extends AppointmentState {
  final AppointmentResponse appointmentResponse;

  AppointmentSuccessState({required this.appointmentResponse});

  @override
  List<Object> get props => [AppointmentResponse];
}

class AppointmentFailedState extends AppointmentState {
  final String message;

  AppointmentFailedState(this.message);

  @override
  List<Object> get props => [message];
}

class MeetingsAndRequestsSuccessState extends AppointmentState {
  final MeetingRequestsResponse meetingRequestsResponse;

  MeetingsAndRequestsSuccessState({required this.meetingRequestsResponse});

  @override
  List<Object> get props => [meetingRequestsResponse];
}