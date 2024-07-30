import 'dart:convert';

MeetingRequestsResponse meetingRequestsResponseFromJson(String str) =>
    MeetingRequestsResponse.fromJson(json.decode(str));

String meetingRequestsResponseToJson(MeetingRequestsResponse data) => json.encode(data.toJson());


class MeetingRequestsResponse {
  List<Meetings>? meetings;
  List<Requests>? requests;

  MeetingRequestsResponse({this.meetings, this.requests});

  MeetingRequestsResponse.fromJson(Map<String, dynamic> json) {
    if (json['meetings'] != null) {
      meetings = <Meetings>[];
      json['meetings'].forEach((v) {
        meetings!.add(new Meetings.fromJson(v));
      });
    }
    if (json['requests'] != null) {
      requests = <Requests>[];
      json['requests'].forEach((v) {
        requests!.add(new Requests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meetings != null) {
      data['meetings'] = this.meetings!.map((v) => v.toJson()).toList();
    }
    if (this.requests != null) {
      data['requests'] = this.requests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meetings {
  int? reservationId;
  String? tenantNumber;
  String? recordDate;
  String? startDate;
  String? endDate;
  bool? approved;
  bool? rejected;
  String? type;
  Null? requestId;
  House? house;

  Meetings(
      {this.reservationId,
        this.tenantNumber,
        this.recordDate,
        this.startDate,
        this.endDate,
        this.approved,
        this.rejected,
        this.type,
        this.requestId,
        this.house});

  Meetings.fromJson(Map<String, dynamic> json) {
    reservationId = json['reservationId'];
    tenantNumber = json['tenantNumber'];
    recordDate = json['recordDate'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    approved = json['approved'];
    rejected = json['rejected'];
    type = json['type'];
    requestId = json['requestId'];
    house = json['house'] != null ? new House.fromJson(json['house']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reservationId'] = this.reservationId;
    data['tenantNumber'] = this.tenantNumber;
    data['recordDate'] = this.recordDate;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['approved'] = this.approved;
    data['rejected'] = this.rejected;
    data['type'] = this.type;
    data['requestId'] = this.requestId;
    if (this.house != null) {
      data['house'] = this.house!.toJson();
    }
    return data;
  }
}

class House {
  int? id;
  String? houseAddress;
  String? area;
  String? city;
  String? recordDate;
  String? occupationDate;
  int? numberRooms;
  String? extraDetails;
  int? rent;
  int? deposit;
  bool? boreHole;
  bool? solar;
  bool? gated;
  bool? tiled;
  bool? walled;
  String? gpsLocation;
  bool? rentWaterInclusive;
  bool? rentElectricityInclusive;
  bool? occupied;
  String? contact;
  String? email;
  String? type;
  String? classification;
  bool? activated;
  String? leaseId;
  int? rate;

  House(
      {this.id,
        this.houseAddress,
        this.area,
        this.city,
        this.recordDate,
        this.occupationDate,
        this.numberRooms,
        this.extraDetails,
        this.rent,
        this.deposit,
        this.boreHole,
        this.solar,
        this.gated,
        this.tiled,
        this.walled,
        this.gpsLocation,
        this.rentWaterInclusive,
        this.rentElectricityInclusive,
        this.occupied,
        this.contact,
        this.email,
        this.type,
        this.classification,
        this.activated,
        this.leaseId,
        this.rate});

  House.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    houseAddress = json['houseAddress'];
    area = json['area'];
    city = json['city'];
    recordDate = json['recordDate'];
    occupationDate = json['occupationDate'];
    numberRooms = json['numberRooms'];
    extraDetails = json['extraDetails'];
    rent = json['rent'];
    deposit = json['deposit'];
    boreHole = json['boreHole'];
    solar = json['solar'];
    gated = json['gated'];
    tiled = json['tiled'];
    walled = json['walled'];
    gpsLocation = json['gpsLocation'];
    rentWaterInclusive = json['rentWaterInclusive'];
    rentElectricityInclusive = json['rentElectricityInclusive'];
    occupied = json['occupied'];
    contact = json['contact'];
    email = json['email'];
    type = json['type'];
    classification = json['classification'];
    activated = json['activated'];
    leaseId = json['leaseId'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['houseAddress'] = this.houseAddress;
    data['area'] = this.area;
    data['city'] = this.city;
    data['recordDate'] = this.recordDate;
    data['occupationDate'] = this.occupationDate;
    data['numberRooms'] = this.numberRooms;
    data['extraDetails'] = this.extraDetails;
    data['rent'] = this.rent;
    data['deposit'] = this.deposit;
    data['boreHole'] = this.boreHole;
    data['solar'] = this.solar;
    data['gated'] = this.gated;
    data['tiled'] = this.tiled;
    data['walled'] = this.walled;
    data['gpsLocation'] = this.gpsLocation;
    data['rentWaterInclusive'] = this.rentWaterInclusive;
    data['rentElectricityInclusive'] = this.rentElectricityInclusive;
    data['occupied'] = this.occupied;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['type'] = this.type;
    data['classification'] = this.classification;
    data['activated'] = this.activated;
    data['leaseId'] = this.leaseId;
    data['rate'] = this.rate;
    return data;
  }
}

class Requests {
  int? reservationId;
  String? tenantNumber;
  String? recordDate;
  String? startDate;
  String? endDate;
  bool? approved;
  bool? rejected;
  String? type;
  int? requestId;
  House? house;

  Requests(
      {this.reservationId,
        this.tenantNumber,
        this.recordDate,
        this.startDate,
        this.endDate,
        this.approved,
        this.rejected,
        this.type,
        this.requestId,
        this.house});

  Requests.fromJson(Map<String, dynamic> json) {
    reservationId = json['reservationId'];
    tenantNumber = json['tenantNumber'];
    recordDate = json['recordDate'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    approved = json['approved'];
    rejected = json['rejected'];
    type = json['type'];
    requestId = json['requestId'];
    house = json['house'] != null ? new House.fromJson(json['house']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reservationId'] = this.reservationId;
    data['tenantNumber'] = this.tenantNumber;
    data['recordDate'] = this.recordDate;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['approved'] = this.approved;
    data['rejected'] = this.rejected;
    data['type'] = this.type;
    data['requestId'] = this.requestId;
    if (this.house != null) {
      data['house'] = this.house!.toJson();
    }
    return data;
  }
}
