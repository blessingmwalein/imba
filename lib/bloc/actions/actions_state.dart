import 'package:equatable/equatable.dart';

import '../../data/models/Interest_response.dart';
import '../../data/models/rating_response.dart';

abstract class ActionsState extends Equatable {}

class ActionsInitialState extends ActionsState {
  @override
  List<Object> get props => [];
}

class RateInitialState extends ActionsState {
  @override
  List<Object> get props => [];
}

class RateLoadingState extends ActionsState {
  @override
  List<Object> get props => [];
}

class RateSuccessState extends ActionsState {
  final RatingResponse rateResponse;

  RateSuccessState({required this.rateResponse});

  @override
  List<Object> get props => [RatingResponse];
}

class RateFailedState extends ActionsState {
  final String message;

  RateFailedState(this.message);

  @override
  List<Object> get props => [message];
}

// ----------------House interest-------
class InterestInitialState extends ActionsState {
  @override
  List<Object> get props => [];
}

class InterestLoadingState extends ActionsState {
  @override
  List<Object> get props => [];
}

class InterestSuccessState extends ActionsState {
  final InterestResponse interestResponse;

  InterestSuccessState({required this.interestResponse});

  @override
  List<Object> get props => [RatingResponse];
}

class InterestFailedState extends ActionsState {
  final String message;

  InterestFailedState(this.message);

  @override
  List<Object> get props => [message];
}
