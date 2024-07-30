import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/bloc/terms_conditions/terms_events.dart';
import 'package:imba/bloc/terms_conditions/terms_state.dart';

import '../../data/repositories/terms_repo.dart';
import '../../secure_storage/secure_storage_manager.dart';

class TermsBloc extends Bloc<TermsEvent, TermsState> {
  final TermsRepositoryImpl termsRepositoryImpl;

  final SecureStorageManager storage;

  static const String LOG_NAME = 'bloc.terms';

  TermsBloc({required this.storage, required this.termsRepositoryImpl})
      : super(TermsInitialState()) {
    on<GetTermsEvent>((event, emit) async {
      emit(GetTermsLoadingState());
      try {
        String terms = await termsRepositoryImpl.getTerms();
        dev.log('Getting terms successful, terms :$terms', name: LOG_NAME);
        emit(GetTermsSuccessState(terms: terms));
      } on SocketException catch (err) {
        dev.log('Failed to get terms, error: $err');
        emit(GetTermsFailedState("Check your connection"));
      } catch (err) {
        dev.log('Failed to get terms, error: $err');
        emit(GetTermsFailedState("Failed to get terms"));
      }
    });

    on<AcceptTermsEvent>((event, emit) async {
      var token = "";
      await storage.getToken().then((value) {
        token = value;
        print("tokkiii $token");
      });
      emit(AcceptTermsLoadingState());
      try {
        String isAccepted = await termsRepositoryImpl.acceptTerms(token: token);
        dev.log('Accepted terms, Accepted :$isAccepted', name: LOG_NAME);
        storage.setIsAcceptedTerms(isAccepted: "true");
        emit(AcceptTermsSuccessState(isAccepted: isAccepted));
      } on SocketException catch (err) {
        dev.log('Failed to accept terms, error: $err');
        emit(AcceptTermsFailedState("Check your connection"));
      } catch (err) {
        dev.log('Failed to accept terms, error: $err');
        emit(AcceptTermsFailedState(err.toString().replaceAll("Exception:","")));
      }
    });
  }
}
