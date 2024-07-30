import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';


import 'package:exception_templates/exception_templates.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/bloc/upload/upload_event.dart';
import 'package:imba/bloc/upload/upload_state.dart';
import 'package:imba/bloc/views/views_event.dart';
import 'package:imba/bloc/views/views_state.dart';
import 'package:imba/data/models/classifications_response.dart';
import 'package:imba/data/models/error_response.dart';
import 'package:imba/data/models/house_response.dart';
import 'package:imba/data/models/types_response.dart';
import 'package:imba/data/repositories/views_repo.dart';

import '../../data/models/request_models/house_model.dart';
import '../../secure_storage/secure_storage_manager.dart';

class ViewedBloc extends Bloc<ViewedEvent, ViewedState> {
  final ViewedRepositoryImpl viewedRepositoryImpl;

  final SecureStorageManager storage;
  static const String LOG_NAME = 'bloc.viewed';

  ViewedBloc({required this.storage,required this.viewedRepositoryImpl}): super(ViewedInitialState()) {
    on<GetViewedEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(ViewedLoadingState());
      try {
        List<HouseResponse> viewedResponse =
        await viewedRepositoryImpl.getViewedHouses(token);
        print("............." + token);

        dev.log('Getting uploads successful, uploads :$viewedResponse',
            name: LOG_NAME);
        emit(ViewedSuccessState(viewedResponse: viewedResponse));
      } on SocketException catch (err) {
        dev.log('Failed to get uploads, error: $err');
        emit(ViewedFailedState("Check your connection"));
      }
      catch (err) {
        dev.log('Failed to get uploads, error: $err');
        emit(ViewedFailedState(err.toString().replaceAll("Exception:","")));
      }
    });


    on<ViewedResetEvent>((event, emit) async {
      emit(ViewedInitialState());
    });
  }
}
