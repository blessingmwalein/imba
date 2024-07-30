import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {}

class ReserveAppointmentEvent extends AppointmentEvent {
  final String token;
  final int houseId;
  final String startDate;
  final String endDate;

  ReserveAppointmentEvent({
    required this.token,
    required this.houseId,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [
        token,
        houseId,
        startDate,
        endDate,
      ];
}

class GetMeetingsAndRequestEvent extends AppointmentEvent {
  GetMeetingsAndRequestEvent();

  @override
  List<Object> get props => [];
}

class AppointmentRefreshEvent extends AppointmentEvent {
  AppointmentRefreshEvent();

  @override
  List<Object> get props => [];
}


