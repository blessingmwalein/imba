import 'package:equatable/equatable.dart';

abstract class TermsState extends Equatable {}

class TermsInitialState extends TermsState {
  @override
  List<Object> get props => [];
}

class GetTermsLoadingState extends TermsState {
  @override
  List<Object> get props => [];
}

class AcceptTermsLoadingState extends TermsState {
  @override
  List<Object> get props => [];
}

class AcceptTermsSuccessState extends TermsState {
  final String isAccepted;

  AcceptTermsSuccessState({required this.isAccepted});

  @override
  List<Object> get props => [isAccepted];
}

class GetTermsSuccessState extends TermsState {
  final String terms;

  GetTermsSuccessState({required this.terms});

  @override
  List<Object> get props => [terms];
}

class GetTermsFailedState extends TermsState {
  final String message;

  GetTermsFailedState(this.message);

  @override
  List<Object> get props => [message];
}

class AcceptTermsFailedState extends TermsState {
  final String message;

  AcceptTermsFailedState(this.message);

  @override
  List<Object> get props => [message];
}
