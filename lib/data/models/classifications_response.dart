// To parse this JSON data, do
//
//     final classificationsResponse = classificationsResponseFromJson(jsonString);

import 'dart:convert';

ClassificationsResponse classificationsResponseFromJson(String str) =>
    ClassificationsResponse.fromJson(json.decode(str));

String classificationsResponseToJson(ClassificationsResponse data) =>
    json.encode(data.toJson());

class ClassificationsResponse {
  ClassificationsResponse({
    required this.classifications,
  });

  List<String> classifications;

  factory ClassificationsResponse.fromJson(Map<String, dynamic> json) =>
      ClassificationsResponse(
        classifications:
            List<String>.from(json["classifications"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "classifications": List<String>.from(classifications.map((x) => x)),
      };
}
