// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  ReviewModel({
    this.items,
    this.searchCriteria,
    this.totalCount,
  });

  List<Item>? items;
  SearchCriteria? searchCriteria;
  int? totalCount;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    searchCriteria: SearchCriteria.fromJson(json["search_criteria"]),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "search_criteria": searchCriteria!.toJson(),
    "total_count": totalCount,
  };
}

class Item {
  Item({
    this.id,
    this.title,
    this.detail,
    this.nickname,
    this.customerId,
    this.ratings,
    this.reviewEntity,
    this.reviewType,
    this.reviewStatus,
    this.createdAt,
    this.entityPkValue,
    this.storeId,
    this.stores,
    this.image,
    this.sku,
    this.productUrl,
    this.rewardPoints,
  });

  int? id;
  String? title;
  String? detail;
  String? nickname;
  int? customerId;
  List<Rating>? ratings;
  String? reviewEntity;
  int? reviewType;
  int? reviewStatus;
  DateTime? createdAt;
  int? entityPkValue;
  int? storeId;
  List<int>? stores;
  String? image;
  String? sku;
  String? productUrl;
  String? rewardPoints;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    title: json["title"],
    detail: json["detail"],
    nickname: json["nickname"],
    customerId: json["customer_id"],
    ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
    reviewEntity: json["review_entity"],
    reviewType: json["review_type"],
    reviewStatus: json["review_status"],
    createdAt: DateTime.parse(json["created_at"]),
    entityPkValue: json["entity_pk_value"],
    storeId: json["store_id"],
    stores: List<int>.from(json["stores"].map((x) => x)),
    image: json["image"],
    sku: json["sku"],
    productUrl: json["product_url"],
    rewardPoints: json["reward_points"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "detail": detail,
    "nickname": nickname,
    "customer_id": customerId,
    "ratings": List<dynamic>.from(ratings!.map((x) => x.toJson())),
    "review_entity": reviewEntity,
    "review_type": reviewType,
    "review_status": reviewStatus,
    "created_at": createdAt!.toIso8601String(),
    "entity_pk_value": entityPkValue,
    "store_id": storeId,
    "stores": List<dynamic>.from(stores!.map((x) => x)),
    "image": image,
    "sku": sku,
    "product_url": productUrl,
    "reward_points": rewardPoints,
  };
}

class Rating {
  Rating({
    this.voteId,
    this.ratingId,
    this.ratingName,
    this.percent,
    this.value,
  });

  int? voteId;
  int? ratingId;
  RatingName? ratingName;
  int? percent;
  int? value;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    voteId: json["vote_id"],
    ratingId: json["rating_id"],
    ratingName: ratingNameValues.map![json["rating_name"]],
    percent: json["percent"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "vote_id": voteId,
    "rating_id": ratingId,
    "rating_name": ratingNameValues.reverse[ratingName],
    "percent": percent,
    "value": value,
  };
}

enum RatingName { VALUE, QUALITY, PRICE }

final ratingNameValues = EnumValues({
  "Price": RatingName.PRICE,
  "Quality": RatingName.QUALITY,
  "Value": RatingName.VALUE
});

class SearchCriteria {
  SearchCriteria({
    this.filterGroups,
  });

  List<dynamic>? filterGroups;

  factory SearchCriteria.fromJson(Map<String, dynamic> json) => SearchCriteria(
    filterGroups: List<dynamic>.from(json["filter_groups"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "filter_groups": List<dynamic>.from(filterGroups!.map((x) => x)),
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
