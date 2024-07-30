import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/bloc/user/user_event.dart';
import 'package:imba/bloc/user/user_state.dart';

import '../../data/models/user_response.dart';
import '../../data/repositories/create_user_repo.dart';
import '../../secure_storage/secure_storage_manager.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepositoryImpl userRepositoryImpl;

  final SecureStorageManager storage;

  static const String LOG_NAME = 'bloc.user';
  late String userPhoneNumber;
  late String firstName;
  late String lastName;
  late  String email;
  late String nationalId;

  UserBloc( {required this.storage, required this.userRepositoryImpl, required this.userPhoneNumber,
    required this.firstName, required this.lastName, required this.email, required this.nationalId})
      : super(CreateUserInitialState()) {
    on<CreateUserEvent>((event, emit) async {
      emit(CreateUserLoadingState());
      try {
        String token =
            await userRepositoryImpl.getToken(macAddress: event.macAddress);
        dev.log('Getting token successful, token :$token', name: LOG_NAME);
        storage.setToken(token: token);
        emit(CreateUserSuccessState(token: token));
      } on SocketException catch (err) {
        dev.log('Failed to get token, error: $err');
        emit(CreateUserFailedState("Check your connection"));
      } catch (err) {
        dev.log('Failed to get token, error: $err');
        emit(CreateUserFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<UpdateUserEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(CreateUserLoadingState());
      try {
        var userResponse = await userRepositoryImpl.updateUser(
          token: token,
          email: event.email,
          firstName: event.firstName,
          lastName: event.lastName,
          nationalId: event.nationalId,
          phoneNumber: event.phoneNumber,
        );
        dev.log('Update user successful,  :$userResponse', name: LOG_NAME);

        emit(UpdateUserSuccessState(userResponse: userResponse));
      } on SocketException catch (err) {
        dev.log('Failed to update user, error: $err');
        emit(CreateUserFailedState("Check your connection"));
      } catch (err) {
        dev.log('Failed to update user, error: $err');
        emit(CreateUserFailedState(err.toString().replaceAll("Exception:","")));
      }
    });



    on<GetUserEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(GetUserLoadingState());
      try {
        UserResponse user =
        await userRepositoryImpl.getUser(token: token);
        dev.log('Getting user successful, user :$user', name: LOG_NAME);


        emit(GetUserSuccessState(user: user));
        userPhoneNumber=user.phone!;
        firstName=user.firstname!;
        lastName=user.lastname!;
        email=user.email!;
        nationalId=user.nationalId!;
      } on SocketException catch (err) {
        dev.log('Failed to get user, error: $err');
        emit(GetUserFailedState("Check your connection"));
      } catch (err) {

        dev.log('Failed to get user, error: $err');
        emit(GetUserFailedState(err.toString().replaceAll("Exception:","")));
        userPhoneNumber="";
      }
    });

    on<ResetUserEvent>((event, emit) async {
      emit((CreateUserInitialState()));
    });

  }

}
