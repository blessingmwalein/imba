import 'package:equatable/equatable.dart';

abstract class ActivateEvent extends Equatable {}

class ActivateHouseEvent extends ActivateEvent {
  final int houseId;

  ActivateHouseEvent({required this.houseId});

  @override
  List<Object> get props => [houseId];
}

class ActivationResetEvent extends ActivateEvent {
  ActivationResetEvent();

  @override
  List<Object> get props => [];
}
