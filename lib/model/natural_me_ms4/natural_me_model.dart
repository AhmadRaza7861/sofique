import 'dart:convert';

class NaturalMeModel {
  Items? items;
  bool? success;

  NaturalMeModel({this.items, this.success});

  NaturalMeModel.fromJson(Map<String, dynamic> json) {
    items = json['items'] != null ? new Items.fromJson(json['items']) : null;
    success = json['success'];
  }
}

class Items {
  String? entityId;
  String? customerId;
  String? customerPic;
  String? firstName;
  String? lastName;
  String? skinColour;
  String? eyeColour;
  String? eyeColourWord;
  String? hairColour;
  String? hairColourWord;
  String? lipColour;
  String? lipColourWord;
  String? skinUndertone;
  String? allergicTo;

  Items(
      {this.entityId,
      this.customerId,
      this.customerPic,
      this.firstName,
      this.lastName,
      this.skinColour,
      this.eyeColour,
      this.eyeColourWord,
      this.hairColour,
      this.hairColourWord,
      this.lipColour,
      this.lipColourWord,
      this.skinUndertone,
      this.allergicTo});

  Items.fromJson(Map<String, dynamic> json) {
    entityId = json['entity_id'];
    customerId = json['customer_id'];
    customerPic = json['customer_pic'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    skinColour = json['skin_colour'];
    eyeColour = json['eye_colour'];
    eyeColourWord = json['eye_colour_word'];
    hairColour = json['hair_colour'];
    hairColourWord = json['hair_colour_word'];
    lipColour = json['lip_colour'];
    lipColourWord = json['lip_colour_word'];
    skinUndertone = json['skin_undertone'];
    allergicTo = json['allergic_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entity_id'] = this.entityId;
    data['customer_id'] = this.customerId;
    data['customer_pic'] = this.customerPic;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['skin_colour'] = this.skinColour;
    data['eye_colour'] = this.eyeColour;
    data['eye_colour_word'] = this.eyeColourWord;
    data['hair_colour'] = this.hairColour;
    data['hair_colour_word'] = this.hairColourWord;
    data['lip_colour'] = this.lipColour;
    data['lip_colour_word'] = this.lipColourWord;
    data['skin_undertone'] = this.skinUndertone;
    data['allergic_to'] = this.allergicTo;
    return data;
  }
}

NaturalMeModelNew naturalMeModelFromJson(String str) =>
    NaturalMeModelNew.fromJson(json.decode(str));

String naturalMeModelToJson(NaturalMeModelNew data) =>
    json.encode(data.toJson());

class NaturalMeModelNew {
  String getUserImagePath() {
    int trendIndex = customAttributes!
        .indexWhere((f) => f.attributeCode == 'sk_profile_pic');
    return customAttributes![trendIndex].value.toString();
  }

  String getHairColorTextFromQuestionnaire() {
    int trendIndex = customAttributes!
        .indexWhere((f) => f.attributeCode == 'customer_questionaire');
    return customAttributes![trendIndex].value[11]['12'][0]; //Hair Color
  }

  String getEyeColorTextFromQuestionnaire() {
    int trendIndex = customAttributes!
        .indexWhere((f) => f.attributeCode == 'customer_questionaire');
    return customAttributes![trendIndex].value[10]['11'][0]; //EyeColor
  }

  String getAllergicToFromQuestionnaire() {
    try {
      int trendIndex = customAttributes!
          .indexWhere((f) => f.attributeCode == 'customer_questionaire');
      return customAttributes![trendIndex].value[4]['5'].join(', '); //EyeColor

    } catch (err) {
      return "";
    }
  }

  String getSkin() {
    int trendIndex = customAttributes!
        .indexWhere((f) => f.attributeCode == 'customer_skincolour');
    return trendIndex != -1
        ? customAttributes![trendIndex].value.toString()
        : '';
  }

  String getSkinUndertone() {
    int trendIndex = customAttributes!
        .indexWhere((f) => f.attributeCode == 'customer_skinundertone');
    return customAttributes![trendIndex].value.toString();
  }

  String getEyeColor() {
    int trendIndex = customAttributes!
        .indexWhere((f) => f.attributeCode == 'customer_eyecolour');
    return customAttributes![trendIndex].value.toString();
  }

  String getHairColor() {
    int trendIndex = customAttributes!
        .indexWhere((f) => f.attributeCode == 'customer_haircolour');
    return customAttributes![trendIndex].value.toString();
  }

  String getLipColor() {
    int trendIndex = customAttributes!
        .indexWhere((f) => f.attributeCode == 'customer_lipcolour');
    return customAttributes![trendIndex].value.toString();
  }

  String getAllergicTo() {
    int trendIndex =
        customAttributes!.indexWhere((f) => f.attributeCode == 'allergic_to');
    return customAttributes![trendIndex].value.toString();
  }

  NaturalMeModelNew({
    this.id,
    this.groupId,
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

  int? id;
  int? groupId;
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

  factory NaturalMeModelNew.fromJson(Map<String, dynamic> json) =>
      NaturalMeModelNew(
        id: json["id"] == null ? null : json["id"],
        groupId: json["group_id"] == null ? null : json["group_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdIn: json["created_in"] == null ? null : json["created_in"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        email: json["email"] == null ? null : json["email"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        gender: json["gender"] == null ? null : json["gender"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        websiteId: json["website_id"] == null ? null : json["website_id"],
        addresses: json["addresses"] == null
            ? null
            : List<Address>.from(
                json["addresses"].map((x) => Address.fromJson(x))),
        disableAutoGroupChange: json["disable_auto_group_change"] == null
            ? null
            : json["disable_auto_group_change"],
        extensionAttributes: json["extension_attributes"] == null
            ? null
            : ExtensionAttributes.fromJson(json["extension_attributes"]),
        customAttributes: json["custom_attributes"] == null
            ? null
            : List<CustomAttribute>.from(json["custom_attributes"]
                .map((x) => CustomAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "group_id": groupId == null ? null : groupId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "created_in": createdIn == null ? null : createdIn,
        "dob": dob == null
            ? null
            : "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
        "email": email == null ? null : email,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "gender": gender == null ? null : gender,
        "store_id": storeId == null ? null : storeId,
        "website_id": websiteId == null ? null : websiteId,
        "addresses": addresses == null
            ? null
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "disable_auto_group_change":
            disableAutoGroupChange == null ? null : disableAutoGroupChange,
        "extension_attributes":
            extensionAttributes == null ? null : extensionAttributes!.toJson(),
        "custom_attributes": customAttributes == null
            ? null
            : List<dynamic>.from(customAttributes!.map((x) => x.toJson())),
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

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        region: json["region"] == null ? null : Region.fromJson(json["region"]),
        regionId: json["region_id"] == null ? null : json["region_id"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        street: json["street"] == null
            ? null
            : List<String>.from(json["street"].map((x) => x)),
        telephone: json["telephone"] == null ? null : json["telephone"],
        postcode: json["postcode"] == null ? null : json["postcode"],
        city: json["city"] == null ? null : json["city"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "customer_id": customerId == null ? null : customerId,
        "region": region == null ? null : region?.toJson(),
        "region_id": regionId == null ? null : regionId,
        "country_id": countryId == null ? null : countryId,
        "street":
            street == null ? null : List<dynamic>.from(street!.map((x) => x)),
        "telephone": telephone == null ? null : telephone,
        "postcode": postcode == null ? null : postcode,
        "city": city == null ? null : city,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
      };
}

class Region {
  Region({
    this.regionCode,
    this.region,
    this.regionId,
  });

  dynamic regionCode;
  String? region;
  int? regionId;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        regionCode: json["region_code"],
        region: json["region"] == null ? null : json["region"],
        regionId: json["region_id"] == null ? null : json["region_id"],
      );

  Map<String, dynamic> toJson() => {
        "region_code": regionCode,
        "region": region == null ? null : region,
        "region_id": regionId == null ? null : regionId,
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
        attributeCode:
            json["attribute_code"] == null ? null : json["attribute_code"],
        value: json["value"] == null ? '' : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "attribute_code": attributeCode == null ? null : attributeCode,
        "value": value == null ? null : value,
      };
}

class ExtensionAttributes {
  ExtensionAttributes({
    this.isSubscribed,
  });

  bool? isSubscribed;

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) =>
      ExtensionAttributes(
        isSubscribed:
            json["is_subscribed"] == null ? null : json["is_subscribed"],
      );

  Map<String, dynamic> toJson() => {
        "is_subscribed": isSubscribed == null ? null : isSubscribed,
      };
}
