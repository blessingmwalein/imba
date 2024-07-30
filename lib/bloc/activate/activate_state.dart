import 'package:equatable/equatable.dart';

abstract class ActivateState extends Equatable {}

class ActivateInitialState extends ActivateState {
  @override
  List<Object> get props => [];
}

class ActivateLoadingState extends ActivateState {
  @override
  List<Object> get props => [];
}

class ActivateFailedState extends ActivateState {
  final String message;

  ActivateFailedState(this.message);

  @override
  List<Object> get props => [message];
}

class ActivateHouseSuccess extends ActivateState {
  final bool isActivated;

  ActivateHouseSuccess({required this.isActivated});

  @override
  List<Object> get props => [isActivated];
}
