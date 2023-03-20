// To parse this JSON data, do
//
//     final ms8Model = ms8ModelFromJson(jsonString);

import 'dart:convert';

List<Ms8Model> ms8ModelFromJson(String str) => List<Ms8Model>.from(json.decode(str).map((x) => Ms8Model.fromJson(x)));

String ms8ModelToJson(List<Ms8Model> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ms8Model {
  Ms8Model({
    this.lookImage,
    this.lookDescription,
    this.customerCurrency,
    this.itemData,
    this.lookAvgrating,
    this.lookPrice,
    this.lookDiscountedPrice,
    this.lookRewardPoints,
    this.status,
    this.message,
  });

  String? lookImage;
  String? lookDescription;
  String? customerCurrency;
  List<ItemData>? itemData;
  String? lookAvgrating;
  double? lookPrice;
  double? lookDiscountedPrice;
  double? lookRewardPoints;
  int? status;
  String? message;



  factory Ms8Model.fromJson(Map<String, dynamic> json)
  {
    List<ItemData> temp=[];
  json['face_subareas'].forEach((key, value) {
   temp.add(ItemData.fromJson(value['item_data'],key,value['recommended_color']));
    });

    
    return  Ms8Model(
    lookImage: json["look_image"],
    lookDescription: json["look_description"],
    customerCurrency: json["customer_currency"],
    itemData: temp,
    lookAvgrating: json["look_avgrating"].toString(),
    lookPrice: double.parse(json["look_price"].toString()),
    lookDiscountedPrice: double.parse(json["look_discounted_price"].toString()),
    lookRewardPoints: double.parse(json["look_reward_points"].toString()),
    status: json["status"],
    message: json["message"],
  );
  }

  Map<String, dynamic> toJson() => {
    "look_image": lookImage,
    "look_description": lookDescription,
    "customer_currency": customerCurrency,
      "item_data": itemData == null
            ? null
            : List<dynamic>.from(itemData!.map((x) => x.toJson())),
    "look_avgrating": lookAvgrating,
    "look_price": lookPrice,
    "look_discounted_price": lookDiscountedPrice,
    "look_reward_points" : lookRewardPoints,
    "status": status,
    "message": message,
  };
}



class ItemData {
  String? recommendedColor;
  String? faceArea;
  String? keyName;
  String? entityId;
  String? attributeSetId;
  String? typeId;
  String? sku;
  String? hasOptions;
  String? requiredOptions;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? image;
  String? smallImage;
  String? thumbnail;
  String? optionsContainer;
  String? msrpDisplayActualPriceType;
  String? urlKey;
  String? urlPath;
  String? faceColor;
  String? shadeName;
  String? directions;
  String? brand;
  String? volume;
  String? status;
  String? visibility;
  String? taxClassId;
  String? size;
  String? storeYear;
  String? faceSubArea;
  String? drySkin;
  String? oilBased;
  String? sensitiveSkin;
  String? matte;
  String? radiant;
  String? shadeColor;
  String? veganCrueltyFree;
  String? tryOn;
  String? price;
  String? description;
  String? shortDescription;
  String? ingredients;
  String? dealFromDate;
  String? dealToDate;
  ExtensionAttributes? extensionAttributes;
  QuantityAndStockStatus? quantityAndStockStatus;
  String? isSalable;
  String? requestPath;
  String? finalPrice;
  String? customerWarningFlag;

  ItemData(
      {
        this.recommendedColor,
        this.keyName,
      this.entityId,
      this.attributeSetId,
      this.typeId,
      this.sku,
      this.hasOptions,
      this.requiredOptions,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.image,
      this.smallImage,
      this.thumbnail,
      this.faceArea,
      this.optionsContainer,
      this.msrpDisplayActualPriceType,
      this.urlKey,
      this.urlPath,
      this.faceColor,
      this.shadeName,
      this.directions,
      this.brand,
      this.volume,
      this.status,
      this.visibility,
      this.taxClassId,
      this.size,
      this.storeYear,
      this.faceSubArea,
      this.drySkin,
      this.oilBased,
      this.sensitiveSkin,
      this.matte,
      this.radiant,
      this.shadeColor,
      this.veganCrueltyFree,
      this.tryOn,
      this.price,
      this.description,
      this.shortDescription,
      this.ingredients,
      this.dealFromDate,
      this.dealToDate,
      this.extensionAttributes,
      this.quantityAndStockStatus,
      this.isSalable,
      this.requestPath,
      this.finalPrice,
      this.customerWarningFlag});

ItemData.fromJson(Map<String, dynamic> json,String key,String recommendedcolor) {
  recommendedColor=recommendedcolor;
    keyName=key;
    entityId = json['entity_id'];
    attributeSetId = json['attribute_set_id'];
    typeId = json['type_id'];
    sku = json['sku'];
    hasOptions = json['has_options'];
    requiredOptions = json['required_options'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    image = json['image'];
    smallImage = json['small_image'];
    thumbnail = json['thumbnail'];
    optionsContainer = json['options_container'];
    msrpDisplayActualPriceType = json['msrp_display_actual_price_type'];
    urlKey = json['url_key'];
    urlPath = json['url_path'];
    faceColor = json['face_color'];
    shadeName = json['shade_name'];
    directions = json['directions'];
    brand = json['brand'];
    volume = json['volume'];
    status = json['status'];
    faceArea=json['faceArea'];
    visibility = json['visibility'];
    taxClassId = json['tax_class_id'];
    size = json['size'];
    storeYear = json['store_year'];
    faceArea = json['faceArea'];
    faceSubArea = json['face_sub_area'];
    drySkin = json['dry_skin'];
    oilBased = json['oil_based'];
    sensitiveSkin = json['sensitive_skin'];
    matte = json['matte'];
    radiant = json['radiant'];
    shadeColor = json['shade_color'];
    veganCrueltyFree = json['vegan_cruelty_free'];
    tryOn = json['try_on'];
    price = json['price'];
    description = json['description'];
    shortDescription = json['short_description'];
    ingredients = json['ingredients'];
    dealFromDate = json['deal_from_date'];
    dealToDate = json['deal_to_date'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    quantityAndStockStatus = json['quantity_and_stock_status'] != null
        ? new QuantityAndStockStatus.fromJson(json['quantity_and_stock_status'])
        : null;
    isSalable = json['is_salable'].toString();
    requestPath = json['request_path'].toString();
    finalPrice = json['final_price'].toString();
    customerWarningFlag = json['customer_warning_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entity_id'] = this.entityId;
    data['attribute_set_id'] = this.attributeSetId;
    data['type_id'] = this.typeId;
    data['sku'] = this.sku;
    data['has_options'] = this.hasOptions;
    data['required_options'] = this.requiredOptions;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['image'] = this.image;
    data['small_image'] = this.smallImage;
    data['thumbnail'] = this.thumbnail;
    data['options_container'] = this.optionsContainer;
    data['msrp_display_actual_price_type'] = this.msrpDisplayActualPriceType;
    data['url_key'] = this.urlKey;
    data['url_path'] = this.urlPath;
    data['face_color'] = this.faceColor;
    data['shade_name'] = this.shadeName;
    data['directions'] = this.directions;
    data['brand'] = this.brand;
    data['volume'] = this.volume;
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['tax_class_id'] = this.taxClassId;
    data['size'] = this.size;
    data['store_year'] = this.storeYear;
    data['faceArea'] = this.faceArea;
    data['face_sub_area'] = this.faceSubArea;
    data['dry_skin'] = this.drySkin;
    data['oil_based'] = this.oilBased;
    data['sensitive_skin'] = this.sensitiveSkin;
    data['matte'] = this.matte;
    data['radiant'] = this.radiant;
    data['shade_color'] = this.shadeColor;
    data['vegan_cruelty_free'] = this.veganCrueltyFree;
    data['try_on'] = this.tryOn;
    data['price'] = this.price;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['ingredients'] = this.ingredients;
    data['deal_from_date'] = this.dealFromDate;
    data['deal_to_date'] = this.dealToDate;
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes!.toJson();
    }
    if (this.quantityAndStockStatus != null) {
      data['quantity_and_stock_status'] = this.quantityAndStockStatus!.toJson();
    }
    data['is_salable'] = this.isSalable;
    data['request_path'] = this.requestPath;
    data['final_price'] = this.finalPrice;
    data['customer_warning_flag'] = this.customerWarningFlag;
    return data;
  }
}

class ExtensionAttributes {
  String? avgratings;
  String? reviewCount;
  String? productUrl;
  String? rewardPoints;
  String? stockStatus;
  String? stockLeft;

  ExtensionAttributes(
      {this.avgratings,
      this.reviewCount,
      this.productUrl,
      this.rewardPoints,
      this.stockStatus,
      this.stockLeft});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    avgratings = json['avgratings'].toString();
    reviewCount = json['review_count'].toString();
    productUrl = json['product_url'];
    rewardPoints = json['reward_points'].toString();
    stockStatus = json['stock_status'].toString();
    stockLeft = json['stock_left'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avgratings'] = this.avgratings;
    data['review_count'] = this.reviewCount;
    data['product_url'] = this.productUrl;
    data['reward_points'] = this.rewardPoints;
    data['stock_status'] = this.stockStatus;
    data['stock_left'] = this.stockLeft;
    return data;
  }
}

class QuantityAndStockStatus {
  String? isInStock;
  String? qty;

  QuantityAndStockStatus({this.isInStock, this.qty});

  QuantityAndStockStatus.fromJson(Map<String, dynamic> json) {
    isInStock = json['is_in_stock'].toString();
    qty = json['qty'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_in_stock'] = this.isInStock;
    data['qty'] = this.qty;
    return data;
  }
}
// class ItemData {
//   String? name;
//   String? entityId;
//   String? attributeSetId;
//   String? typeId;
//   String? sku;
//   String? price;
//   QuantityAndStockStatus? quantityAndStockStatus;

//   ItemData(
//       {this.name,
//       this.entityId,
//       this.attributeSetId,
//       this.typeId,
//       this.sku,
//       this.price,
//       this.quantityAndStockStatus});

//   ItemData.fromJson(Map<String, dynamic> json,String key) {
//     name=key;
//     entityId = json['entity_id'];
//     attributeSetId = json['attribute_set_id'];
//     typeId = json['type_id'];
//     sku = json['sku'];
//     price = json['price'];
//     quantityAndStockStatus = json['quantity_and_stock_status'] != null
//         ? new QuantityAndStockStatus.fromJson(json['quantity_and_stock_status'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['entity_id'] = this.entityId;
//     data['attribute_set_id'] = this.attributeSetId;
//     data['type_id'] = this.typeId;
//     data['sku'] = this.sku;
//     data['price'] = this.price;
//     if (this.quantityAndStockStatus != null) {
//       data['quantity_and_stock_status'] = this.quantityAndStockStatus!.toJson();
//     }
//     return data;
//   }
// }

// class QuantityAndStockStatus {
//   bool? isInStock;
//   int? qty;

//   QuantityAndStockStatus({this.isInStock, this.qty});

//   QuantityAndStockStatus.fromJson(Map<String, dynamic> json) {
//     isInStock = json['is_in_stock'];
//     qty = json['qty'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['is_in_stock'] = this.isInStock;
//     data['qty'] = this.qty;
//     return data;
//   }
// }