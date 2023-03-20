// To parse this JSON data, do
//
//     final myReviewSkuModel = myReviewSkuModelFromJson(jsonString);

import 'dart:convert';

import 'package:sofiqe/model/configurable_option.dart';

import 'configurable_item_option.dart';

MyReviewSkuModel myReviewSkuModelFromJson(String str) => MyReviewSkuModel.fromJson(json.decode(str));

String myReviewSkuModelToJson(MyReviewSkuModel data) => json.encode(data.toJson());

class MyReviewSkuModel {
  MyReviewSkuModel({
    this.id,
    this.sku,
    this.name,
    this.attributeSetId,
    this.price,
    this.status,
    this.visibility,
    this.typeId,
    this.createdAt,
    this.updatedAt,
    this.extensionAttributes,
    this.productLinks,
    this.options,
    this.mediaGalleryEntries,
    this.tierPrices,
    this.customAttributes,
  });

  int? id;
  String? sku;
  String? name;
  int? attributeSetId;
  double? price;
  int? status;
  int? visibility;
  String? typeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  ExtensionAttributes? extensionAttributes;
  List<dynamic>? productLinks;
  List<Option>? options;
  List<MediaGalleryEntry>? mediaGalleryEntries;
  List<dynamic>? tierPrices;
  List<CustomAttribute>? customAttributes;

  factory MyReviewSkuModel.fromJson(Map<String, dynamic> json) => MyReviewSkuModel(
    id: json["id"],
    sku: json["sku"],
     name: json["name"],
     attributeSetId: json["attribute_set_id"],
      price: double.parse(json["price"].toString()),
    status: json["status"],
    visibility: json["visibility"],
    typeId: json["type_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
     extensionAttributes: ExtensionAttributes.fromJson(json["extension_attributes"]),
     productLinks: List<dynamic>.from(json["product_links"].map((x) => x)),
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    mediaGalleryEntries: List<MediaGalleryEntry>.from(json["media_gallery_entries"].map((x) => MediaGalleryEntry.fromJson(x))),
    tierPrices: List<dynamic>.from(json["tier_prices"].map((x) => x)),
    customAttributes: List<CustomAttribute>.from(json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sku": sku,
    "name": name,
    "attribute_set_id": attributeSetId,
    "price": price,
    "status": status,
    "visibility": visibility,
    "type_id": typeId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "extension_attributes": extensionAttributes!.toJson(),
    "product_links": List<dynamic>.from(productLinks!.map((x) => x)),
    "options": List<dynamic>.from(options!.map((x) => x.toJson())),
    "media_gallery_entries": List<dynamic>.from(mediaGalleryEntries!.map((x) => x.toJson())),
    "tier_prices": List<dynamic>.from(tierPrices!.map((x) => x)),
    "custom_attributes": List<dynamic>.from(customAttributes!.map((x) => x.toJson())),
  };


  List<ConfigurableItemOption> getConfigurableOption(){
    List<ConfigurableItemOption>  data = [];
    for(int i = 0 ; i < extensionAttributes!.configurableProductOptions!.length ; i++ ){
      data.add(ConfigurableItemOption(optionId: extensionAttributes!.configurableProductOptions![i].attributeId,
          optionValue: extensionAttributes!.configurableProductOptions![i].values![0].valueIndex));
    }
    return data;
  }

  List<ConfigurableOption> getOptions(){
    List<ConfigurableOption>  data = [];
    for(int i = 0 ; i < options!.length ; i++ ){
      data.add(ConfigurableOption(optionId: options![i].optionId,
          optionValue: options![i].values![0].optionTypeId));
    }
    return data;
  }

}

class CustomAttribute {
  CustomAttribute({
    this.attributeCode,
    this.value,
  });

  String? attributeCode;
  dynamic value;

  factory CustomAttribute.fromJson(Map<String, dynamic> json) => CustomAttribute(
    attributeCode: json["attribute_code"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "attribute_code": attributeCode,
    "value": value,
  };
}

class ExtensionAttributes {
  ExtensionAttributes({
    this.websiteIds,
    this.categoryLinks,
    this.stockItem,
    this.configurableProductOptions,
    this.configurableProductLinks,
    this.avgrating,
    this.reviewCount,
    this.productUrl,
    this.rewardPoints,
  });

  List<int>? websiteIds;
  List<CategoryLink>? categoryLinks;
  StockItem? stockItem;
  List<ConfigurableProductOption>? configurableProductOptions;
  List<int>? configurableProductLinks;
  String? avgrating;
  String? reviewCount;
  String? productUrl;
  String? rewardPoints;

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) => ExtensionAttributes(
    websiteIds: List<int>.from(json["website_ids"].map((x) => x)),
    categoryLinks: List<CategoryLink>.from(json["category_links"].map((x) => CategoryLink.fromJson(x))),
    stockItem: StockItem.fromJson(json["stock_item"]),
    configurableProductOptions:json.containsKey('configurable_product_options')?List<ConfigurableProductOption>.from(json["configurable_product_options"].map((x) => ConfigurableProductOption.fromJson(x))):[],
     configurableProductLinks: json.containsKey('configurable_product_links')?List<int>.from(json["configurable_product_links"].map((x) => x)):[],
    avgrating: json["avgrating"],
    reviewCount: json["review_count"],
    productUrl: json["product_url"],
    rewardPoints: json["reward_points"],
  );

  Map<String, dynamic> toJson() => {
    "website_ids": List<dynamic>.from(websiteIds!.map((x) => x)),
    "category_links": List<dynamic>.from(categoryLinks!.map((x) => x.toJson())),
    "stock_item": stockItem!.toJson(),
    "configurable_product_options": List<dynamic>.from(configurableProductOptions!.map((x) => x.toJson())),
    "configurable_product_links": List<dynamic>.from(configurableProductLinks!.map((x) => x)),
    "avgrating": avgrating,
    "review_count": reviewCount,
    "product_url": productUrl,
    "reward_points": rewardPoints,
  };
}

class CategoryLink {
  CategoryLink({
    this.position,
    this.categoryId,
  });

  int? position;
  String? categoryId;

  factory CategoryLink.fromJson(Map<String, dynamic> json) => CategoryLink(
    position: json["position"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "category_id": categoryId,
  };
}

class ConfigurableProductOption {
  ConfigurableProductOption({
    this.id,
    this.attributeId,
    this.label,
    this.position,
    this.values,
    this.productId,
  });

  int? id;
  String? attributeId;
  String? label;
  int? position;
  List<ConfigurableProductOptionValue>? values;
  int? productId;

  factory ConfigurableProductOption.fromJson(Map<String, dynamic> json) => ConfigurableProductOption(
    id: json["id"],
    attributeId: json["attribute_id"],
    label: json["label"],
    position: json["position"],
    values: List<ConfigurableProductOptionValue>.from(json["values"].map((x) => ConfigurableProductOptionValue.fromJson(x))),
    productId: json["product_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attribute_id": attributeId,
    "label": label,
    "position": position,
    "values": List<dynamic>.from(values!.map((x) => x.toJson())),
    "product_id": productId,
  };
}

class ConfigurableProductOptionValue {
  ConfigurableProductOptionValue({
    this.valueIndex,
  });

  int? valueIndex;

  factory ConfigurableProductOptionValue.fromJson(Map<String, dynamic> json) => ConfigurableProductOptionValue(
    valueIndex: json["value_index"],
  );

  Map<String, dynamic> toJson() => {
    "value_index": valueIndex,
  };
}

class StockItem {
  StockItem({
    this.itemId,
    this.productId,
    this.stockId,
    this.qty,
    this.isInStock,
    this.isQtyDecimal,
    this.showDefaultNotificationMessage,
    this.useConfigMinQty,
    this.minQty,
    this.useConfigMinSaleQty,
    this.minSaleQty,
    this.useConfigMaxSaleQty,
    this.maxSaleQty,
    this.useConfigBackorders,
    this.backorders,
    this.useConfigNotifyStockQty,
    this.notifyStockQty,
    this.useConfigQtyIncrements,
    this.qtyIncrements,
    this.useConfigEnableQtyInc,
    this.enableQtyIncrements,
    this.useConfigManageStock,
    this.manageStock,
    this.lowStockDate,
    this.isDecimalDivided,
    this.stockStatusChangedAuto,
  });

  int? itemId;
  int? productId;
  int? stockId;
  int? qty;
  bool? isInStock;
  bool? isQtyDecimal;
  bool? showDefaultNotificationMessage;
  bool? useConfigMinQty;
  int? minQty;
  int? useConfigMinSaleQty;
  int? minSaleQty;
  bool? useConfigMaxSaleQty;
  int? maxSaleQty;
  bool? useConfigBackorders;
  int? backorders;
  bool? useConfigNotifyStockQty;
  int? notifyStockQty;
  bool? useConfigQtyIncrements;
  int? qtyIncrements;
  bool? useConfigEnableQtyInc;
  bool? enableQtyIncrements;
  bool? useConfigManageStock;
  bool? manageStock;
  dynamic lowStockDate;
  bool? isDecimalDivided;
  int? stockStatusChangedAuto;

  factory StockItem.fromJson(Map<String, dynamic> json) => StockItem(
    itemId: json["item_id"],
    productId: json["product_id"],
    stockId: json["stock_id"],
    qty: json["qty"],
    isInStock: json["is_in_stock"],
    isQtyDecimal: json["is_qty_decimal"],
    showDefaultNotificationMessage: json["show_default_notification_message"],
    useConfigMinQty: json["use_config_min_qty"],
    minQty: json["min_qty"],
    useConfigMinSaleQty: json["use_config_min_sale_qty"],
    minSaleQty: json["min_sale_qty"],
    useConfigMaxSaleQty: json["use_config_max_sale_qty"],
    maxSaleQty: json["max_sale_qty"],
    useConfigBackorders: json["use_config_backorders"],
    backorders: json["backorders"],
    useConfigNotifyStockQty: json["use_config_notify_stock_qty"],
    notifyStockQty: json["notify_stock_qty"],
    useConfigQtyIncrements: json["use_config_qty_increments"],
    qtyIncrements: json["qty_increments"],
    useConfigEnableQtyInc: json["use_config_enable_qty_inc"],
    enableQtyIncrements: json["enable_qty_increments"],
    useConfigManageStock: json["use_config_manage_stock"],
    manageStock: json["manage_stock"],
    lowStockDate: json["low_stock_date"],
    isDecimalDivided: json["is_decimal_divided"],
    stockStatusChangedAuto: json["stock_status_changed_auto"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "product_id": productId,
    "stock_id": stockId,
    "qty": qty,
    "is_in_stock": isInStock,
    "is_qty_decimal": isQtyDecimal,
    "show_default_notification_message": showDefaultNotificationMessage,
    "use_config_min_qty": useConfigMinQty,
    "min_qty": minQty,
    "use_config_min_sale_qty": useConfigMinSaleQty,
    "min_sale_qty": minSaleQty,
    "use_config_max_sale_qty": useConfigMaxSaleQty,
    "max_sale_qty": maxSaleQty,
    "use_config_backorders": useConfigBackorders,
    "backorders": backorders,
    "use_config_notify_stock_qty": useConfigNotifyStockQty,
    "notify_stock_qty": notifyStockQty,
    "use_config_qty_increments": useConfigQtyIncrements,
    "qty_increments": qtyIncrements,
    "use_config_enable_qty_inc": useConfigEnableQtyInc,
    "enable_qty_increments": enableQtyIncrements,
    "use_config_manage_stock": useConfigManageStock,
    "manage_stock": manageStock,
    "low_stock_date": lowStockDate,
    "is_decimal_divided": isDecimalDivided,
    "stock_status_changed_auto": stockStatusChangedAuto,
  };
}

class MediaGalleryEntry {
  MediaGalleryEntry({
    this.id,
    this.mediaType,
    this.label,
    this.position,
    this.disabled,
    this.types,
    this.file,
  });

  int? id;
  String? mediaType;
  dynamic label;
  int? position;
  bool? disabled;
  List<String>? types;
  String? file;

  factory MediaGalleryEntry.fromJson(Map<String, dynamic> json) => MediaGalleryEntry(
    id: json["id"],
    mediaType: json["media_type"],
    label: json["label"],
    position: json["position"],
    disabled: json["disabled"],
    types: List<String>.from(json["types"].map((x) => x)),
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "media_type": mediaType,
    "label": label,
    "position": position,
    "disabled": disabled,
    "types": List<dynamic>.from(types!.map((x) => x)),
    "file": file,
  };
}

class Option {
  Option({
    this.productSku,
    this.optionId,
    this.title,
    this.type,
    this.sortOrder,
    this.isRequire,
    this.sku,
    this.maxCharacters,
    this.values,
  });

  String? productSku;
  int? optionId;
  String? title;
  String? type;
  int? sortOrder;
  bool? isRequire;
  String? sku;
  int? maxCharacters;
  List<OptionValue>? values;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    productSku: json["product_sku"],
    optionId: json["option_id"],
    title: json["title"],
    type: json["type"],
    sortOrder: json["sort_order"],
    isRequire: json["is_require"],
    sku: json["sku"],
    maxCharacters: json["max_characters"],
    values: List<OptionValue>.from(json["values"].map((x) => OptionValue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_sku": productSku,
    "option_id": optionId,
    "title": title,
    "type": type,
    "sort_order": sortOrder,
    "is_require": isRequire,
    "sku": sku,
    "max_characters": maxCharacters,
    "values": List<dynamic>.from(values!.map((x) => x.toJson())),
  };
}

class OptionValue {
  OptionValue({
    this.title,
    this.sortOrder,
    this.price,
    this.priceType,
    this.sku,
    this.optionTypeId,
  });

  String? title;
  int? sortOrder;
  int? price;
  String? priceType;
  String? sku;
  int? optionTypeId;

  factory OptionValue.fromJson(Map<String, dynamic> json) => OptionValue(
    title: json["title"],
    sortOrder: json["sort_order"],
    price: json["price"],
    priceType: json["price_type"],
    sku: json["sku"],
    optionTypeId: json["option_type_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "sort_order": sortOrder,
    "price": price,
    "price_type": priceType,
    "sku": sku,
    "option_type_id": optionTypeId,
  };
}
