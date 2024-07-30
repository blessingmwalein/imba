// To parse this JSON data, do
//
//     final typesResponse = typesResponseFromJson(jsonString);

import 'dart:convert';

TypesResponse typesResponseFromJson(String str) =>
    TypesResponse.fromJson(json.decode(str));

String typesResponseToJson(TypesResponse data) => json.encode(data.toJson());

class TypesResponse {
  TypesResponse({
    required this.types,
  });

  List<String> types;

  factory TypesResponse.fromJson(Map<String, dynamic> json) => TypesResponse(
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}
