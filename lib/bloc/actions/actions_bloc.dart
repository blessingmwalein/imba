import 'dart:developer' as dev;
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/data/models/Interest_response.dart';
import '../../data/models/rating_response.dart';
import '../../data/repositories/actions_repo.dart';
import '../../secure_storage/secure_storage_manager.dart';
import 'actions_event.dart';
import 'actions_state.dart';

class ActionsBloc extends Bloc<ActionsEvent, ActionsState> {
  final ActionsRepositoryImpl actionsRepositoryImpl;

  final SecureStorageManager storage;

  static const String LOG_NAME = 'bloc.actions';

  ActionsBloc({required this.storage, required this.actionsRepositoryImpl})
      : super(ActionsInitialState()) {
    on<RateEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(RateLoadingState());
      try {
        RatingResponse results =
            await actionsRepositoryImpl.rate(token, event.houseId, event.rate);

        dev.log('rated successful, search :$results', name: LOG_NAME);
        emit(RateSuccessState(rateResponse: results));
      } on SocketException catch (err) {
        dev.log('Failed to rate, error: $err');
        emit(RateFailedState(err.message));
      } catch (err) {
        dev.log('Failed to rate, error: ${err.toString()}');
        emit(RateFailedState(err.toString().replaceAll("Exception:", "")));
      }
    });
    on<ResetEvent>((event, emit) async {
      // var token = await storage.getToken();
      emit(RateInitialState());
    });

    on<InitiateInterestEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(InterestLoadingState());
      try {
        InterestResponse results =
            await actionsRepositoryImpl.initiateInterest(token, event.houseId);

        dev.log('interest initiated successful, search :$results',
            name: LOG_NAME);
        emit(InterestSuccessState(interestResponse: results));
      } on SocketException catch (err) {
        dev.log('Failed to initiate interest, error: $err');
        emit(InterestFailedState(err.message));
      } on Exception catch (err) {
        dev.log('Failed to initiate interest, error: $err');
        emit(RateFailedState(err.toString().replaceAll("Exception:", "")));
      }
    });
  }
}
