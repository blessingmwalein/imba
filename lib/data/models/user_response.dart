class UserResponse {
  String? token;
  String? phone;
  String? email;
  String? firstname;
  String? lastname;
  String? nationalId;
  String? macAdd;
  String? agreeTcs;

  UserResponse(
      {this.token,
        this.phone,
        this.email,
        this.firstname,
        this.lastname,
        this.nationalId,
        this.macAdd,
        this.agreeTcs});

  UserResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    phone = json['phone'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    nationalId = json['nationalId'];
    macAdd = json['macAdd'];
    agreeTcs = json['agreeTcs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['nationalId'] = this.nationalId;
    data['macAdd'] = this.macAdd;
    data['agreeTcs'] = this.agreeTcs;
    return data;
  }
}
