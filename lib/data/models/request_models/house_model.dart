class HouseRequest {
  String? houseAddress;
  String? area;
  String? city;
  String? occupationDate;
  int? numberRooms;
  String? extraDetails;
  int? rent;
  int? deposit;
  bool? boreHole;
  bool? solar;
  bool? rentWaterInclusive;
  bool? rentElectricityInclusive;
  bool? walled;
  bool? tiled;
  bool? gated;
  bool? occupied;
  String? token;
  String? type;
  String? classification;
  String? contact;
  String? email;

  HouseRequest(
      {this.houseAddress,
      this.area,
      this.city,
      this.occupationDate,
      this.numberRooms,
      this.extraDetails,
      this.rent,
      this.deposit,
      this.boreHole,
      this.solar,
      this.rentWaterInclusive,
      this.rentElectricityInclusive,
      this.walled,
      this.tiled,
      this.gated,
      this.occupied,
      this.token,
      this.type,
      this.classification,
      this.contact,
      this.email});

  HouseRequest.fromJson(Map<String, dynamic> json) {
    houseAddress = json['houseAddress'];
    area = json['area'];
    city = json['city'];
    occupationDate = json['occupationDate'];
    numberRooms = json['numberRooms'];
    extraDetails = json['extraDetails'];
    rent = json['rent'];
    deposit = json['deposit'];
    boreHole = json['boreHole'];
    solar = json['solar'];
    rentWaterInclusive = json['rentWaterInclusive'];
    rentElectricityInclusive = json['rentElectricityInclusive'];
    walled = json['walled'];
    tiled = json['tiled'];
    gated = json['gated'];
    occupied = json['occupied'];
    token = json['token'];
    type = json['type'];
    classification = json['classification'];
    contact = json['contact'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['houseAddress'] = this.houseAddress;
    data['area'] = this.area;
    data['city'] = this.city;
    data['occupationDate'] = this.occupationDate;
    data['numberRooms'] = this.numberRooms;
    data['extraDetails'] = this.extraDetails;
    data['rent'] = this.rent;
    data['deposit'] = this.deposit;
    data['boreHole'] = this.boreHole;
    data['solar'] = this.solar;
    data['rentWaterInclusive'] = this.rentWaterInclusive;
    data['rentElectricityInclusive'] = this.rentElectricityInclusive;
    data['walled'] = this.walled;
    data['tiled'] = this.tiled;
    data['gated'] = this.gated;
    data['occupied'] = this.occupied;
    data['token'] = this.token;
    data['type'] = this.type;
    data['classification'] = this.classification;
    data['contact'] = this.contact;
    data['email'] = this.email;
    return data;
  }
}
