import 'package:equatable/equatable.dart';
import 'package:imba/data/models/classifications_response.dart';
import 'package:imba/data/models/house_response.dart';
import 'package:imba/data/models/types_response.dart';

import '../../data/models/payment_response.dart';

abstract class UploadState extends Equatable {}

class UploadInitialState extends UploadState {
  @override
  List<Object> get props => [];
}

class UploadLoadingState extends UploadState {
  @override
  List<Object> get props => [];
}

class UploadSuccessState extends UploadState {
  final String token;

  UploadSuccessState({required this.token});

  @override
  List<Object> get props => [token];
}

class UploadFailedState extends UploadState {
  final String message;

  UploadFailedState(this.message);

  @override
  List<Object> get props => [message];
}

class TypesSuccessState extends UploadState {
  final TypesResponse types;

  TypesSuccessState({required this.types});

  @override
  List<Object> get props => [types];
}

class ClassificationsSuccessState extends UploadState {
  final ClassificationsResponse classifications;

  ClassificationsSuccessState({required this.classifications});

  @override
  List<Object> get props => [classifications];
}

class UploadHouseSuccessState extends UploadState {
  final HouseResponse houseResponse;

  UploadHouseSuccessState({required this.houseResponse});

  @override
  List<Object> get props => [houseResponse];
}

class GetUploadsSuccessState extends UploadState {
  final List<HouseResponse> uploadsResponse;

  GetUploadsSuccessState({required this.uploadsResponse});

  @override
  List<Object> get props => [uploadsResponse];
}

class EditUploadSuccessState extends UploadState {
  final HouseResponse editResponse;

  EditUploadSuccessState({required this.editResponse});

  @override
  List<Object> get props => [editResponse];
}

class UploadImagesSuccessState extends UploadState {
  final bool imagesResponse;

  UploadImagesSuccessState({required this.imagesResponse});

  @override
  List<Object> get props => [imagesResponse];
}

class GetHouseByIdSuccess extends UploadState {
  final PaymentResponse houseResponse;

  GetHouseByIdSuccess({required this.houseResponse});

  @override
  List<Object> get props => [houseResponse];
}
