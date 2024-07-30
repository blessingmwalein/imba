class ErrorResponse {
  String? error;
  int? errorCode;
  String? details;

  ErrorResponse({this.error, this.errorCode, this.details});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorCode = json['errorCode'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['errorCode'] = this.errorCode;
    data['details'] = this.details;
    return data;
  }
}