
import 'package:equatable/equatable.dart';

abstract class ViewedEvent extends Equatable {}

class GetViewedEvent extends ViewedEvent {
  GetViewedEvent();

  @override
  List<Object> get props => [];
}

class ViewedResetEvent extends ViewedEvent {
  ViewedResetEvent();

  @override
  List<Object> get props => [];
}