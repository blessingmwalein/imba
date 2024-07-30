
import 'package:equatable/equatable.dart';
import 'package:imba/data/models/house_response.dart';

import '../../data/models/viewed_response.dart';

abstract class ViewedState extends Equatable {}

class ViewedInitialState extends ViewedState {
  @override
  List<Object> get props => [];
}

class ViewedLoadingState extends ViewedState {
  @override
  List<Object> get props => [];
}

class ViewedSuccessState extends ViewedState {
   final List<HouseResponse> viewedResponse;

  ViewedSuccessState({required this.viewedResponse});

  @override
  List<Object> get props => [viewedResponse];
}

class ViewedFailedState extends ViewedState {
  final String message;

  ViewedFailedState(this.message);

  @override
  List<Object> get props => [message];
}
