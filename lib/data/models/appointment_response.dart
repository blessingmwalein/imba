// To parse this JSON data, do
//
//     final appointmentResponse = appointmentResponseFromJson(jsonString);

import 'dart:convert';

AppointmentResponse appointmentResponseFromJson(String str) =>
    AppointmentResponse.fromJson(json.decode(str));

String appointmentResponseToJson(AppointmentResponse data) =>
    json.encode(data.toJson());

class AppointmentResponse {
  AppointmentResponse({
    required this.reservationId,
    required this.tenantNumber,
    required this.recordDate,
    required this.startDate,
    required this.endDate,
    required this.approved,
    required this.type,
    this.requestId,
    required this.house,
  });

  int reservationId;
  String tenantNumber;
  DateTime recordDate;
  DateTime startDate;
  DateTime endDate;
  bool approved;
  String type;
  dynamic requestId;
  House house;

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) =>
      AppointmentResponse(
        reservationId: json["reservationId"],
        tenantNumber: json["tenantNumber"],
        recordDate: DateTime.parse(json["recordDate"]),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        approved: json["approved"],
        type: json["type"],
        requestId: json["requestId"],
        house: House.fromJson(json["house"]),
      );

  Map<String, dynamic> toJson() => {
        "reservationId": reservationId,
        "tenantNumber": tenantNumber,
        "recordDate": recordDate.toIso8601String(),
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "approved": approved,
        "type": type,
        "requestId": requestId,
        "house": house.toJson(),
      };
}

class House {
  House({
    required this.id,
    required this.houseAddress,
    required this.area,
    required this.city,
    required this.recordDate,
    required this.occupationDate,
    required this.numberRooms,
    required this.extraDetails,
    required this.rent,
    required this.deposit,
    required this.boreHole,
    required this.solar,
    required this.gated,
    required this.tiled,
    required this.walled,
    required this.gpsLocation,
    required this.rentWaterInclusive,
    required this.rentElectricityInclusive,
    required this.occupied,
    required this.contact,
    required this.email,
    required this.type,
    required this.classification,
    required this.activated,
    required this.leaseId,
    required this.rate,
  });

  int id;
  String houseAddress;
  String area;
  String city;
  DateTime recordDate;
  DateTime occupationDate;
  int numberRooms;
  String extraDetails;
  int rent;
  int deposit;
  bool boreHole;
  bool solar;
  bool gated;
  bool tiled;
  bool walled;
  String gpsLocation;
  bool rentWaterInclusive;
  bool rentElectricityInclusive;
  bool occupied;
  String contact;
  String email;
  String type;
  String classification;
  bool activated;
  String leaseId;
  int rate;

  factory House.fromJson(Map<String, dynamic> json) => House(
        id: json["id"],
        houseAddress: json["houseAddress"],
        area: json["area"],
        city: json["city"],
        recordDate: DateTime.parse(json["recordDate"]),
        occupationDate: DateTime.parse(json["occupationDate"]),
        numberRooms: json["numberRooms"],
        extraDetails: json["extraDetails"],
        rent: json["rent"],
        deposit: json["deposit"],
        boreHole: json["boreHole"],
        solar: json["solar"],
        gated: json["gated"],
        tiled: json["tiled"],
        walled: json["walled"],
        gpsLocation: json["gpsLocation"],
        rentWaterInclusive: json["rentWaterInclusive"],
        rentElectricityInclusive: json["rentElectricityInclusive"],
        occupied: json["occupied"],
        contact: json["contact"],
        email: json["email"],
        type: json["type"],
        classification: json["classification"],
        activated: json["activated"],
        leaseId: json["leaseId"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "houseAddress": houseAddress,
        "area": area,
        "city": city,
        "recordDate": recordDate.toIso8601String(),
        "occupationDate": occupationDate.toIso8601String(),
        "numberRooms": numberRooms,
        "extraDetails": extraDetails,
        "rent": rent,
        "deposit": deposit,
        "boreHole": boreHole,
        "solar": solar,
        "gated": gated,
        "tiled": tiled,
        "walled": walled,
        "gpsLocation": gpsLocation,
        "rentWaterInclusive": rentWaterInclusive,
        "rentElectricityInclusive": rentElectricityInclusive,
        "occupied": occupied,
        "contact": contact,
        "email": email,
        "type": type,
        "classification": classification,
        "activated": activated,
        "leaseId": leaseId,
        "rate": rate,
      };
}
