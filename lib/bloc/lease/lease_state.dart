import 'package:equatable/equatable.dart';
import 'package:imba/data/models/lease_agreement.dart';

abstract class LeaseState extends Equatable {}

class LeaseInitialState extends LeaseState {
  @override
  List<Object> get props => [];
}

class LeaseLoadingState extends LeaseState {
  @override
  List<Object> get props => [];
}

class LeaseSuccessState extends LeaseState {
  final List<LeaseAgreement> leaseAgreement;

  LeaseSuccessState({required this.leaseAgreement});

  @override
  List<Object> get props => [leaseAgreement];
}

class LeaseFailedState extends LeaseState {
  final String message;

  LeaseFailedState(this.message);

  @override
  List<Object> get props => [message];
}
//
class LeaseUpdateSuccessState extends LeaseState {
  final String  response;

  LeaseUpdateSuccessState({required this.response});

  @override
  List<Object> get props => [response];
}

class UpdateLoadingState extends LeaseState {
  @override
  List<Object> get props => [];
}

class UpdateFailedState extends LeaseState {
  final String message;

  UpdateFailedState(this.message);

  @override
  List<Object> get props => [message];
}


