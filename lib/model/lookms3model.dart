// To parse this JSON data, do
//
//     final looksMs3Model = looksMs3ModelFromJson(jsonString);

import 'dart:convert';

List<LooksMs3Model> looksMs3ModelFromJson(String str) => List<LooksMs3Model>.from(json.decode(str).map((x) => LooksMs3Model.fromJson(x)));

String looksMs3ModelToJson(List<LooksMs3Model> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LooksMs3Model {
  LooksMs3Model({
    this.totalRecords,
    this.items,
    this.status,
    this.message,
  });

  int? totalRecords;
  List<Item>? items;
  int? status;
  String? message;

  factory LooksMs3Model.fromJson(Map<String, dynamic> json) => LooksMs3Model(
    totalRecords: json["totalRecords"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "totalRecords": totalRecords,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class Item {
  Item({
    this.entityId,
    this.name,
    this.identifier,
    this.header,
    this.description,
    this.image,
    this.discount,
    this.fromDate,
    this.toDate,
    this.country,
    this.sku,
    this.incrementId,
    this.avgrating,
    this.reviewCount,
    this.faceColor,
    this.productUrl,
    this.imageUrl,
    this.rewardPoints,
    this.oldPrice,
    this.price,
  });

  String? entityId;
  String? name;
  String? identifier;
  String? header;
  String? description;
  String? image;
  String? discount;
  DateTime? fromDate;
  DateTime? toDate;
  dynamic country;
  String? sku;
  String? incrementId;
  String? avgrating;
  String? reviewCount;
  String? faceColor;
  String? productUrl;
  String? imageUrl;
  double? rewardPoints;
  double? oldPrice;
  double? price;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    entityId: json["entity_id"],
    name: json["name"],
    identifier: json["identifier"],
    header: json["header"],
    description: json["description"],
    image: json["image"],
    discount: json["discount"],
    fromDate: DateTime.parse(json["from_date"]),
    toDate: DateTime.parse(json["to_date"]),
    country: json["country"],
    sku: json["sku"],
    incrementId: json["increment_id"],
    avgrating: json["avgrating"].toString(),
    reviewCount: json["review_count"].toString(),
    productUrl: json["product_url"],
    imageUrl: json["image_url"],
    faceColor: json['face_color'].toString(),
    rewardPoints: double.parse(json["reward_points"].toString()),
    oldPrice: double.parse(json["old_price"].toString()),
    price: double.parse(json["price"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "entity_id": entityId,
    "name": name,
    "identifier": identifier,
    "header": header,
    "description": description,
    "image": image,
    "discount": discount,
    "from_date": "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
    "to_date": "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
    "country": country,
    "sku": sku,
    "increment_id": incrementId,
    "avgrating": avgrating,
    "review_count":reviewCount,
    "product_url": productUrl,
    "image_url": imageUrl,
    "reward_points": rewardPoints,
    "old_price": oldPrice,
    "price": price,
  };
}
