import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {}

class CreateUserEvent extends UserEvent {
  final String macAddress;

  CreateUserEvent({required this.macAddress});

  @override
  List<Object> get props => [macAddress];
}


class GetUserEvent extends UserEvent {


  GetUserEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends UserEvent {
  final String firstName;
  final String lastName;
  final String nationalId;
  final String phoneNumber;
  final String email;

  UpdateUserEvent(
      {required this.firstName,
      required this.lastName,
      required this.nationalId,
      required this.phoneNumber,
      required this.email});

  @override
  List<Object> get props =>
      [firstName, lastName, nationalId, phoneNumber, email];
}
class ResetUserEvent extends UserEvent {


  ResetUserEvent();

  @override
  List<Object> get props => [];
}