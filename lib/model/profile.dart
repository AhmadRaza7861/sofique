// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());


class Profile {
  Profile({
    this.id,
    this.groupId,
    this.defaultBilling,
    this.defaultShipping,
    this.createdAt,
    this.updatedAt,
    this.createdIn,
    this.dob,
    this.email,
    this.firstname,
    this.lastname,
    this.gender,
    this.storeId,
    this.websiteId,
    this.addresses,
    this.disableAutoGroupChange,
    this.extensionAttributes,
    this.customAttributes,
  });

  int? id ;
  int? groupId;
  String? defaultBilling;
  String? defaultShipping;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdIn;
  DateTime? dob;
  String? email;
  String? firstname;
  String? lastname;
  int? gender;
  int? storeId;
  int? websiteId;
  List<Address>? addresses;
  int? disableAutoGroupChange;
  ExtensionAttributes? extensionAttributes;
  List<CustomAttribute>? customAttributes;

  String getPhoneNumber() {
    int trendIndex = customAttributes!
        .indexWhere((f) => f.attributeCode == 'phone_number');
    return customAttributes![trendIndex].value; //Hair Color
  }

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        groupId: json["group_id"],
        defaultBilling: json["default_billing"],
        defaultShipping: json["default_shipping"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdIn: json["created_in"],
        dob: json["dob"] == null ? DateTime.now() : DateTime.parse(json["dob"]),
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        gender: json["gender"],
        storeId: json["store_id"],
        websiteId: json["website_id"],
        addresses: json["addresses"] == []
            ? []
            : List<Address>.from(
                json["addresses"].map((x) => Address.fromJson(x))),
        disableAutoGroupChange: json["disable_auto_group_change"],
        extensionAttributes:
            ExtensionAttributes.fromJson(json["extension_attributes"]),
        customAttributes: List<CustomAttribute>.from(
            json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "default_billing": defaultBilling,
        "default_shipping": defaultShipping,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_in": createdIn,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
        "store_id": storeId,
        "website_id": websiteId,
        "addresses": List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "disable_auto_group_change": disableAutoGroupChange,
        "extension_attributes": extensionAttributes?.toJson(),
        "custom_attributes":
            List<dynamic>.from(customAttributes!.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.id,
    this.customerId,
    this.region,
    this.regionId,
    this.countryId,
    this.street,
    this.telephone,
    this.postcode,
    this.city,
    this.firstname,
    this.lastname,
    this.defaultShipping,
    this.defaultBilling,
  });

  int? id;
  int? customerId;
  Region? region;
  int? regionId;
  String? countryId;
  List<String>? street;
  String? telephone;
  String? postcode;
  String? city;
  String? firstname;
  String? lastname;
  bool? defaultShipping;
  bool? defaultBilling;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] ?? "",
        customerId: json["customer_id"] ?? "",
        region: Region.fromJson(json["region"]),
        regionId: json["region_id"],
        countryId: json["country_id"],
        street: List<String>.from(json["street"].map((x) => x)),
        telephone: json["telephone"],
        postcode: json["postcode"],
        city: json["city"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        defaultShipping: json["default_shipping"],
        defaultBilling: json["default_billing"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "region": region!.toJson(),
        "region_id": regionId,
        "country_id": countryId,
        "street": List<dynamic>.from(street!.map((x) => x)),
        "telephone": telephone,
        "postcode": postcode,
        "city": city,
        "firstname": firstname,
        "lastname": lastname,
        "default_shipping": defaultShipping,
        "default_billing": defaultBilling,
      };
}

class Region {
  Region({
    this.regionCode,
    this.region,
    this.regionId,
  });

  String? regionCode;
  String? region;
  int? regionId;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        regionCode: json["region_code"] ?? "",
        region: json["region"] ?? "",
        regionId: json["region_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "region_code": regionCode,
        "region": region,
        "region_id": regionId,
      };
}

class CustomAttribute {
  CustomAttribute({
    this.attributeCode,
    this.value,
  });

  String? attributeCode;
  dynamic value;

  factory CustomAttribute.fromJson(Map<String, dynamic> json) =>
      CustomAttribute(
        attributeCode: json["attribute_code"],
        value: json["value"].toString(),
      );

  List<Map<String, List<String>>> questionnaireFromJson(String str) => List<Map<String, List<String>>>.from(json.decode(str).map((x) => Map.from(x).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x))))));

  String questionnaireToJson(List<Map<String, List<String>>> data) => json.encode(List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))))));


  Map<String, dynamic> toJson() => {
        "attribute_code": attributeCode,
        "value": value,
      };
}

class ExtensionAttributes {
  ExtensionAttributes({
    this.isSubscribed,
  });

  bool? isSubscribed;

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) =>
      ExtensionAttributes(
        isSubscribed: json["is_subscribed"],
      );

  Map<String, dynamic> toJson() => {
        "is_subscribed": isSubscribed,
      };
}

class AtmCard {
  AtmCard(
      {this.entityId,
      this.number,
      this.name,
      this.expiryDate,
      this.type,
      this.cvc});

  int? entityId;
  String? number;
  String? name;
  String? expiryDate;
  String? type;
  String? cvc;

  factory AtmCard.fromJson(Map<String, dynamic> json) => AtmCard(
      entityId: json["entity_id"],
      number: json["number"],
      name: json["name"],
      expiryDate: json["expiry_date"],
      type: json["type"],
      cvc: "232");

  Map<String, dynamic> toJson() => {
        "entity_id": entityId,
        "number": number,
        "name": name,
        "expiry_date": expiryDate,
        "type": type,
        "cvc": cvc,
      };
}
