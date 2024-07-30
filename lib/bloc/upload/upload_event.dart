import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class UploadEvent extends Equatable {}

class FetchTypesEvent extends UploadEvent {
  FetchTypesEvent();

  @override
  List<Object> get props => [];
}

class FetchClassificationsEvent extends UploadEvent {
  FetchClassificationsEvent();

  @override
  List<Object> get props => [];
}

class UploadHouseEvent extends UploadEvent {
  final String houseAddress;
  final String area;
  final String city;
  final String occupationDate;
  final int numberRooms;
  final String extraDetails;
  final int rent;
  final int deposit;
  final bool boreHole;
  final bool solar;
  final bool rentWaterInclusive;
  final bool rentElectricityInclusive;
  final bool walled;
  final bool tiled;
  final bool gated;
  final bool occupied;
  final String token;
  final String type;
  final String classification;
  final String contact;
  final String email;

  UploadHouseEvent(
      {required this.houseAddress,
      required this.area,
      required this.city,
      required this.occupationDate,
      required this.numberRooms,
      required this.extraDetails,
      required this.rent,
      required this.deposit,
      required this.boreHole,
      required this.solar,
      required this.rentWaterInclusive,
      required this.rentElectricityInclusive,
      required this.walled,
      required this.tiled,
      required this.gated,
      required this.occupied,
      required this.token,
      required this.type,
      required this.classification,
      required this.contact,
      required this.email});

  @override
  List<Object> get props => [
        houseAddress,
        area,
        city,
        occupationDate,
        numberRooms,
        extraDetails,
        rent,
        deposit,
        boreHole,
        solar,
        rentWaterInclusive,
        rentElectricityInclusive,
        walled,
        tiled,
        gated,
        occupied,
        token,
        type,
        classification,
        contact,
        email
      ];
}

class GetUploadsEvent extends UploadEvent {
  GetUploadsEvent();

  @override
  List<Object> get props => [];
}

class EditUploadEvent extends UploadEvent {
  final String token;
  final int houseId;
  final String occupationDate;
  final bool occupied;
  final String deposit;
  final String rent;

  EditUploadEvent(
      {required this.token,
      required this.houseId,
      required this.occupationDate,
      required this.occupied,
      required this.deposit,
      required this.rent});

  @override
  List<Object> get props =>
      [token, houseId, occupationDate, occupied, deposit, rent];
}

class UploadHousePicsEvent extends UploadEvent {
  final int houseId;
  final String title;
  final String description;
  final List<XFile> imagesPath;

  UploadHousePicsEvent(
      {required this.houseId,
      required this.title,
      required this.description,
      required this.imagesPath});

  @override
  List<Object> get props => [houseId, title, description, imagesPath];
}

class GetHouseByIdEvent extends UploadEvent {
  final int houseId;

  GetHouseByIdEvent({required this.houseId});

  @override
  List<Object> get props => [houseId];
}

class ResetUploadsEvent extends UploadEvent {
  ResetUploadsEvent();

  @override
  List<Object> get props => [];
}
