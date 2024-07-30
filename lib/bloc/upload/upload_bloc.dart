import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/bloc/upload/upload_event.dart';
import 'package:imba/bloc/upload/upload_state.dart';
import 'package:imba/data/models/classifications_response.dart';
import 'package:imba/data/models/house_response.dart';
import 'package:imba/data/models/types_response.dart';

import '../../data/models/payment_response.dart';
import '../../data/models/request_models/house_model.dart';
import '../../data/repositories/upload_repo.dart';
import '../../secure_storage/secure_storage_manager.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadRepositoryImpl uploadRepositoryImpl;

  final SecureStorageManager storage;
  TypesResponse types;
  ClassificationsResponse classifications;

  static const String LOG_NAME = 'bloc.uploads';

  UploadBloc(
      {required this.storage,
      required this.uploadRepositoryImpl,
      required this.types,
      required this.classifications})
      : super(UploadInitialState()) {
    on<FetchTypesEvent>((event, emit) async {
      emit(UploadLoadingState());
      try {
        TypesResponse typesResponse = await uploadRepositoryImpl.getTypes();
        dev.log('Getting types successful, types :$typesResponse',
            name: LOG_NAME);
        types = typesResponse;
        emit(TypesSuccessState(types: typesResponse));
      } on SocketException catch (err) {
        dev.log('Failed to get types, error: $err');
        emit(UploadFailedState("Check your connection"));
      } catch (err) {
        dev.log('Failed to get types, error: $err');
        emit(UploadFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<FetchClassificationsEvent>((event, emit) async {
      emit(UploadLoadingState());
      try {
        ClassificationsResponse classificationsResponse =
            await uploadRepositoryImpl.getClassifications();
        classifications = classificationsResponse;
        dev.log(
            'Getting classifications successful, classifications :$classificationsResponse',
            name: LOG_NAME);
        emit(ClassificationsSuccessState(
            classifications: classificationsResponse));
      } on SocketException catch (err) {
        dev.log('Failed to get classifications, error: $err');
        emit(UploadFailedState("Check your connection"));
      } catch (err) {
        dev.log('Failed to get classifications, error: $err');
        emit(UploadFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<UploadHouseEvent>((event, emit) async {
      var token = await storage.getToken();
      print("date" + event.occupationDate);
      final house = HouseRequest(
          houseAddress: event.houseAddress,
          area: event.area,
          city: event.city,
          occupationDate: event.occupationDate,
          numberRooms: event.numberRooms,
          extraDetails: event.extraDetails,
          rent: event.rent,
          deposit: event.deposit,
          boreHole: event.boreHole,
          solar: event.solar,
          rentWaterInclusive: event.rentWaterInclusive,
          rentElectricityInclusive: event.rentElectricityInclusive,
          walled: event.walled,
          tiled: event.tiled,
          gated: event.gated,
          occupied: event.occupied,
          token: token,
          type: event.type,
          classification: event.classification,
          contact: event.contact,
          email: event.email);

      emit(UploadLoadingState());
      try {
        var houseResponse =
            await uploadRepositoryImpl.uploadHouse(house, token);

        dev.log('Adding House successful, houseResponse :$houseResponse',
            name: LOG_NAME);
        emit(UploadHouseSuccessState(houseResponse: houseResponse));
      } on SocketException catch (err) {
        dev.log('Failed to upload house, error: $err');
        emit(UploadFailedState("Check your connection"));
      } catch (err) {
        dev.log('Failed to upload house, error: $err');
        emit(UploadFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<GetUploadsEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(UploadLoadingState());
      try {
        //  List<HouseResponse>  uploadsResponse = await uploadRepositoryImpl.getUploads(token);
        List<HouseResponse> uploadsResponse =
            await uploadRepositoryImpl.getUploads(token);
        print("............." + token);

        dev.log('Getting uploads successful, uploads :$uploadsResponse',
            name: LOG_NAME);
        emit(GetUploadsSuccessState(uploadsResponse: uploadsResponse));
      } on SocketException catch (err) {
        dev.log('Failed to get uploads, error: $err');
        emit(UploadFailedState("Check your connection"));
      } catch (err) {
        dev.log('Failed to get uploads, error: $err');
        emit(UploadFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<EditUploadEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(UploadLoadingState());
      try {
        HouseResponse editResponse = await uploadRepositoryImpl.editUpload(
            token,
            event.houseId,
            event.occupationDate,
            event.occupied,
            event.deposit,
            event.rent);

        dev.log('Getting edit successful, uploads :$editResponse',
            name: LOG_NAME);
        emit(EditUploadSuccessState(editResponse: editResponse));
      } on SocketException catch (err) {
        dev.log('Failed to edit, error: $err');
        emit(UploadFailedState(err.message));
      } catch (err) {
        dev.log('Failed to edit, error: $err');
        emit(UploadFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<GetHouseByIdEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(UploadLoadingState());
      try {
        PaymentResponse houseResponse = await uploadRepositoryImpl.getHouseById(
          token: token,
          houseId: event.houseId,
        );

        dev.log('Getting house by id successful, houseResponse :$houseResponse',
            name: LOG_NAME);
        emit(GetHouseByIdSuccess(houseResponse: houseResponse));
      } on SocketException catch (err) {
        dev.log('Failed to get house by id, error: $err');
        emit(UploadFailedState(err.message));
      } catch (err) {
        dev.log('Failed to get house by id, error: $err');
        emit(UploadFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<UploadHousePicsEvent>((event, emit) async {
      var token = await storage.getToken();
      emit(UploadLoadingState());
      try {
        bool imagesResponse = await uploadRepositoryImpl.uploadHousePics(
            houseId: event.houseId,
            tittle: event.title,
            imagesPaths: event.imagesPath,
            description: event.description);

        dev.log('uploaded images successful, uploads :$imagesResponse',
            name: LOG_NAME);
        emit(UploadImagesSuccessState(imagesResponse: imagesResponse));
      } on SocketException catch (err) {
        dev.log('Failed to upload pics, error: $err');
        emit(UploadFailedState(err.message));
      } catch (err) {
        dev.log('Failed to upload pics, error: $err');
        emit(UploadFailedState(err.toString().replaceAll("Exception:","")));
      }
    });

    on<ResetUploadsEvent>((event, emit) async {
      emit(UploadInitialState());
    });
  }
}
