// To parse this JSON data, do
//
//     final shoppingHistoryModel = shoppingHistoryModelFromJson(jsonString);

import 'dart:convert';

List<ShoppingHistoryModel> shoppingHistoryModelFromJson(String str) => List<ShoppingHistoryModel>.from(json.decode(str).map((x) => ShoppingHistoryModel.fromJson(x)));

String shoppingHistoryModelToJson(List<ShoppingHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShoppingHistoryModel {
  ShoppingHistoryModel({
    this.result,
    this.data,
  });

  String? result;
  List<Datum>? data;

  factory ShoppingHistoryModel.fromJson(Map<String, dynamic> json) => ShoppingHistoryModel(
    result: json["result"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.orderId,
    this.orderIncrementId,
    this.date,
    this.status,
    this.state,
    this.subTotal,
    this.shippingCharge,
    this.discount,
    this.rewardsEarn,
    this.rewardsSpend,
    this.totals,
    this.items,
  });

  String? orderId;
  String? orderIncrementId;
  DateTime? date;
  String? status;
  String? state;
  String? subTotal;
  String? shippingCharge;
  String? discount;
  String? rewardsEarn;
  String? rewardsSpend;
  String? totals;
  List<Item>? items;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    orderId: json["order_id"],
    orderIncrementId: json["order_increment_id"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
    state: json["state"],
    subTotal: json["sub_total"],
    shippingCharge: json["shipping_charge"],
    discount: json["discount"],
    rewardsEarn: json["rewards_earn"],
    rewardsSpend: json["rewards_spend"],
    totals: json["totals"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "order_increment_id": orderIncrementId,
    "date": date!.toIso8601String(),
    "status": status,
    "state": state,
    "sub_total": subTotal,
    "shipping_charge": shippingCharge,
    "discount": discount,
    "rewards_earn": rewardsEarn,
    "rewards_spend": rewardsSpend,
    "totals": totals,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.sku,
    this.name,
    this.image,
    this.orderQty,
    this.price,
    this.productOptions,
    this.additionalOptions,
  });

  String? sku;
  String? name;
  String? image;
  String? orderQty;
  String? price;
  List<Option>? productOptions;
  List<Option>? additionalOptions;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    sku: json["sku"],
    name: json["name"],
    image: json["image"],
    orderQty: json["order_qty"],
    price: json["price"],
    productOptions: List<Option>.from(json["productOptions"].map((x) => Option.fromJson(x))),
    additionalOptions: List<Option>.from(json["additionalOptions"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sku": sku,
    "name": name,
    "image": image,
    "order_qty": orderQty,
    "price": price,
    "productOptions": List<dynamic>.from(productOptions!.map((x) => x.toJson())),
    "additionalOptions": List<dynamic>.from(additionalOptions!.map((x) => x.toJson())),
  };
}

class Option {
  Option({
    this.label,
    this.value,
  });

  Label? label;
  String? value;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    label: labelValues.map![json["label"]],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": labelValues.reverse[label],
    "value": value,
  };
}

enum Label { SHADE, VOLUME, SHADE_COLOR }

final labelValues = EnumValues({
  "Shade": Label.SHADE,
  "Shade Color": Label.SHADE_COLOR,
  "Volume": Label.VOLUME
});

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
