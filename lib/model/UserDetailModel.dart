// To parse this JSON data, do
//
//     final userDetailModel = userDetailModelFromJson(jsonString);

import 'dart:convert';

UserDetailModel userDetailModelFromJson(String str) => UserDetailModel.fromJson(json.decode(str));

String userDetailModelToJson(UserDetailModel data) => json.encode(data.toJson());

class UserDetailModel {
  UserDetailModel({
    this.id,
    this.email,
    this.firstname,
    this.lastname,
    this.customAttributes,
  });

  int? id;
  String? email;
  String? firstname;
  String? lastname;
  List<CustomAttribute>? customAttributes;



  factory UserDetailModel.fromJson(Map<String, dynamic> json) => UserDetailModel(
    id: json["id"],
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    customAttributes: List<CustomAttribute>.from(json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "custom_attributes": List<dynamic>.from(customAttributes!.map((x) => x.toJson())),
  };
}

class CustomAttribute {
  CustomAttribute({
    this.attributeCode,
    this.value,
  });

  String? attributeCode;
  String? value;


  factory CustomAttribute.fromJson(Map<String, dynamic> json) => CustomAttribute(
    attributeCode: json["attribute_code"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "attribute_code": attributeCode,
    "value": value,
  };
}
