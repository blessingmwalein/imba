// To parse this JSON data, do
//
//     final houseResponse = houseResponseFromJson(jsonString);

import 'dart:convert';

List<HouseResponse> houseResponseFromJson(String str) =>
    List<HouseResponse>.from(
        json.decode(str).map((x) => HouseResponse.fromJson(x)));

String houseResponseToJson(List<HouseResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HouseResponse {
  HouseResponse({
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
    required this.currency,
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
    this.leaseId,
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
  String currency;
  bool rentWaterInclusive;
  bool rentElectricityInclusive;
  bool occupied;
  String contact;
  String email;
  String type;
  String classification;
  bool activated;
  String? leaseId;
  int rate;

  factory HouseResponse.fromJson(Map<String, dynamic> json) => HouseResponse(
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
        currency: json["currency"],
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
        "currency":currency,
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
