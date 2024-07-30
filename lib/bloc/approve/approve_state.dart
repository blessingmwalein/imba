import 'package:equatable/equatable.dart';
import 'package:imba/data/models/meeting_request_response.dart';

import '../../data/models/appointment_response.dart';
import '../../data/models/approve_response.dart';

abstract class ApproveState extends Equatable {}

class ApproveInitialState extends ApproveState {
  @override
  List<Object> get props => [];
}


//--approve

class ApproveLoadingState extends ApproveState {
  @override
  List<Object> get props => [];
}
class ApproveFailedState extends ApproveState {
  final String message;

  ApproveFailedState(this.message);

  @override
  List<Object> get props => [message];
}

class ApproveSuccessState extends ApproveState {
  final ApproveResponse approveResponse;

  ApproveSuccessState({required this.approveResponse});

  @override
  List<Object> get props => [approveResponse];
}
//--reject

class RejectLoadingState extends ApproveState {
  @override
  List<Object> get props => [];
}


class RejectFailedState extends ApproveState {
  final String message;

  RejectFailedState(this.message);

  @override
  List<Object> get props => [message];
}

class RejectSuccessState extends ApproveState {
  final ApproveResponse rejectResponse;

  RejectSuccessState({required this.rejectResponse});

  @override
  List<Object> get props => [rejectResponse];
}