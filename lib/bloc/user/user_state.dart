import 'package:equatable/equatable.dart';

import '../../data/models/user_response.dart';

abstract class UserState extends Equatable {}

class CreateUserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

class CreateUserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class CreateUserSuccessState extends UserState {
  final String token;

  CreateUserSuccessState({required this.token});

  @override
  List<Object> get props => [token];
}

class CreateUserFailedState extends UserState {
  final String message;

  CreateUserFailedState(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateUserSuccessState extends UserState {
  final UserResponse userResponse;

  UpdateUserSuccessState({required this.userResponse});

  @override
  List<Object> get props => [userResponse];
}

class GetUserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

class GetUserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class GetUserSuccessState extends UserState {
  final UserResponse user;

  GetUserSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class GetUserFailedState extends UserState {
  final String message;

  GetUserFailedState(this.message);

  @override
  List<Object> get props => [message];
}
