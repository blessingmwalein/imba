import 'package:image_picker/image_picker.dart';
import 'package:imba/data/models/classifications_response.dart';
import 'package:imba/data/models/house_response.dart';
import 'package:imba/data/models/types_response.dart';

import '../data_providers/upload_api.dart';
import '../models/payment_response.dart';
import '../models/request_models/house_model.dart';

abstract class UploadRepository {
  Future<TypesResponse> getTypes();

  Future<ClassificationsResponse> getClassifications();

  Future<HouseResponse> uploadHouse(HouseRequest house, String token);

  Future<List<HouseResponse>> getUploads(String token);

  Future<HouseResponse> editUpload(String token, int houseId,
      String occupationDate, bool occupied, String deposit, String rent);

  Future<bool> uploadHousePics(
      {required int houseId,
      required String tittle,
      required String description,
      required List<XFile> imagesPaths});

  Future<bool> activateHouse({required int houseId, required String token});

  Future<PaymentResponse> getHouseById(
      {required int houseId, required String token});
}

class UploadRepositoryImpl implements UploadRepository {
  final UploadApi api;

  UploadRepositoryImpl({required this.api});

  @override
  Future<TypesResponse> getTypes() async {
    return await api.getTypes();
  }

  @override
  Future<ClassificationsResponse> getClassifications() async {
    return await api.getClassifications();
  }

  @override
  Future<HouseResponse> uploadHouse(HouseRequest house, String token) async {
    return await api.uploadHouse(house, token);
  }

  @override
  Future<List<HouseResponse>> getUploads(String token) async {
    return await api.getUploads(token);
  }

  @override
  Future<HouseResponse> editUpload(String token, int houseId,
      String occupationDate, bool occupied, String deposit, String rent) async {
    return await api.editUpload(
        token, houseId, occupationDate, occupied, deposit, rent);
  }

  @override
  Future<bool> uploadHousePics(
      {required int houseId,
      required String tittle,
      required String description,
      required List<XFile> imagesPaths}) async {
    return await api.uploadHousePics(houseId, tittle, description, imagesPaths);
  }

  @override
  Future<bool> activateHouse(
      {required int houseId, required String token}) async {
    return await api.activateHouse(houseId, token);
  }

  @override
  Future<PaymentResponse> getHouseById(
      {required int houseId, required String token}) async {
    return await api.getHouseById(token, houseId);
  }
}
