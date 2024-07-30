// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  SearchResponse({
    required this.total,
    required this.viewedList,
    required this.totalpages,
    required this.searchedList,
    required this.currentpage,
  });

  int total;
  List<ViewedList> viewedList;
  int totalpages;
  List<SearchedList> searchedList;
  int currentpage;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        total: json["TOTAL"],
        viewedList: List<ViewedList>.from(
            json["VIEWED LIST"].map((x) => ViewedList.fromJson(x))),
        totalpages: json["TOTALPAGES"],
        searchedList: List<SearchedList>.from(
            json["SEARCHED LIST"].map((x) => SearchedList.fromJson(x))),
        currentpage: json["CURRENTPAGE"],
      );

  Map<String, dynamic> toJson() => {
        "TOTAL": total,
        "VIEWED LIST": List<dynamic>.from(viewedList.map((x) => x.toJson())),
        "TOTALPAGES": totalpages,
        "SEARCHED LIST":
            List<dynamic>.from(searchedList.map((x) => x.toJson())),
        "CURRENTPAGE": currentpage,
      };
}

class SearchedList {
  SearchedList({
    required this.id,
    required this.area,
    required this.city,
    required this.occupationDate,
    required this.numberRooms,
    required this.extraDetails,
    required this.rent,
    required this.deposit,
    required this.boreHole,
    required this.solar,
    required this.currency,
    required this.gated,
    required this.walled,
    required this.tiled,
    required this.classification,
    required this.rentWaterInclusive,
    required this.rentElectricityInclusive,
    required this.type,
  });

  int id;
  String area;
  String city;
  DateTime occupationDate;
  int numberRooms;
  String extraDetails;
  int rent;
  int deposit;
  bool boreHole;
  bool solar;
  bool gated;
  bool walled;
  bool tiled;
  String classification;
  String currency;
  bool rentWaterInclusive;
  bool rentElectricityInclusive;
  String type;

  factory SearchedList.fromJson(Map<String, dynamic> json) => SearchedList(
        id: json["id"],
        area: json["area"],
        city: json["city"],
        occupationDate: DateTime.parse(json["occupationDate"]),
        numberRooms: json["numberRooms"],
        extraDetails: json["extraDetails"],
        rent: json["rent"],
        deposit: json["deposit"],
        currency: json["currency"],
        boreHole: json["boreHole"],
        solar: json["solar"],
        gated: json["gated"],
        walled: json["walled"],
        tiled: json["tiled"],
        classification: json["classification"],
        rentWaterInclusive: json["rentWaterInclusive"],
        rentElectricityInclusive: json["rentElectricityInclusive"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "city": city,
        "occupationDate": occupationDate.toIso8601String(),
        "numberRooms": numberRooms,
        "extraDetails": extraDetails,
        "rent": rent,
        "deposit": deposit,
        "boreHole": boreHole,
        "solar": solar,
        "gated": gated,
        "currency":currency,
        "walled": walled,
        "tiled": tiled,
        "classification": classification,
        "rentWaterInclusive": rentWaterInclusive,
        "rentElectricityInclusive": rentElectricityInclusive,
        "type": type,
      };
}

class ViewedList {
  ViewedList({
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
    required this.currency,
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
  String currency;
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

  factory ViewedList.fromJson(Map<String, dynamic> json) => ViewedList(
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
        currency: json["currency"],
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
        "currency":currency,
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
