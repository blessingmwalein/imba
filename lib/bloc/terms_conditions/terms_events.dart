import 'package:equatable/equatable.dart';

abstract class TermsEvent extends Equatable {}

class GetTermsEvent extends TermsEvent {
  GetTermsEvent();

  @override
  List<Object> get props => [];
}

class AcceptTermsEvent extends TermsEvent {
  AcceptTermsEvent();

  @override
  List<Object> get props => [];
}
