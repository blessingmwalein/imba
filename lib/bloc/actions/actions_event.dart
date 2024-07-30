import 'package:equatable/equatable.dart';

abstract class ActionsEvent extends Equatable {}

class RateEvent extends ActionsEvent {
  final int houseId;
  final int rate;

  RateEvent({
    required this.houseId,
    required this.rate,
  });

  @override
  List<Object> get props => [houseId, rate];
}

class ResetEvent extends ActionsEvent {
  @override
  List<Object> get props => [];
}

class InitiateInterestEvent extends ActionsEvent {
  final int houseId;

  InitiateInterestEvent({required this.houseId});

  @override
  List<Object> get props => [houseId];
}
