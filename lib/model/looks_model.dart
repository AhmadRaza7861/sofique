// // To parse this JSON data, do
// //
// //     final welcome = welcomeFromJson(jsonString);
//
// import 'dart:convert';
//
// // List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));
// //
// // String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class LooksModel {
//   LooksModel({
//     this.lookImage = "",
//     this.lookDescription = "",
//     this.customerCurrency = "",
//     this.faceSubareas,
//     this.lookAvgrating = 0,
//     this.lookPrice = 0,
//     this.lookRewardPoints = 0,
//     this.lookDiscountedPrice = 0,
//     this.status = 0,
//     this.message = "",
//   });
//
//   String lookImage;
//   String lookDescription;
//   String customerCurrency;
//   FaceSubareas? faceSubareas;
//   int lookAvgrating;
//   double lookPrice;
//   int lookRewardPoints;
//   double lookDiscountedPrice;
//   int status;
//   String message;
//
//   factory LooksModel.fromJson(Map<String, dynamic> json) => LooksModel(
//         lookImage: json["look_image"],
//         lookDescription: json["look_description"],
//         customerCurrency: json["customer_currency"],
//         faceSubareas: FaceSubareas.fromJson(json["face_subareas"]),
//         lookAvgrating: json["look_avgrating"],
//         lookPrice: json["look_price"].toDouble(),
//         lookRewardPoints: json["look_reward_points"],
//         lookDiscountedPrice: json["look_discounted_price"].toDouble(),
//         status: json["status"],
//         message: json["message"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "look_image": lookImage,
//         "look_description": lookDescription,
//         "customer_currency": customerCurrency,
//         "face_subareas": faceSubareas?.toJson(),
//         "look_avgrating": lookAvgrating,
//         "look_price": lookPrice,
//         "look_reward_points": lookRewardPoints,
//         "look_discounted_price": lookDiscountedPrice,
//         "status": status,
//         "message": message,
//       };
// }
//
// class FaceSubareas {
//   FaceSubareas({
//     this.blusher,
//     this.highlighter,
//     this.bronzer,
//     this.mascaras,
//     this.lipliner,
//     this.lipstick,
//     this.eyelid,
//     this.eyesocket,
//     this.orbitalbone,
//     this.eyeliner,
//   });
//
//   Blusher? blusher;
//   Highlighter? highlighter;
//   Bronzer? bronzer;
//   Mascaras? mascaras;
//   Lipliner? lipliner;
//   Lipstick? lipstick;
//   Eyelid? eyelid;
//   Eyelid? eyesocket;
//   Eyelid? orbitalbone;
//   Eyeliner? eyeliner;
//
//   factory FaceSubareas.fromJson(Map<String, dynamic> json) => FaceSubareas(
//         blusher: Blusher.fromJson(json["Blusher"]),
//         highlighter: Highlighter.fromJson(json["Highlighter"]),
//         bronzer: Bronzer.fromJson(json["Bronzer"]),
//         mascaras: Mascaras.fromJson(json["Mascaras"]),
//         lipliner: Lipliner.fromJson(json["Lipliner"]),
//         lipstick: Lipstick.fromJson(json["Lipstick"]),
//         eyelid: Eyelid.fromJson(json["Eyelid"]),
//         eyesocket: Eyelid.fromJson(json["Eyesocket"]),
//         orbitalbone: Eyelid.fromJson(json["Orbitalbone"]),
//         eyeliner: Eyeliner.fromJson(json["Eyeliner"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "Blusher": blusher?.toJson(),
//         "Highlighter": highlighter?.toJson(),
//         "Bronzer": bronzer?.toJson(),
//         "Mascaras": mascaras?.toJson(),
//         "Lipliner": lipliner?.toJson(),
//         "Lipstick": lipstick?.toJson(),
//         "Eyelid": eyelid?.toJson(),
//         "Eyesocket": eyesocket?.toJson(),
//         "Orbitalbone": orbitalbone?.toJson(),
//         "Eyeliner": eyeliner?.toJson(),
//       };
// }
//
// class Blusher {
//   Blusher({
//     this.itemData,
//     this.recommendedColor = "",
//   });
//
//   BlusherItemData? itemData;
//   String recommendedColor;
//
//   factory Blusher.fromJson(Map<String, dynamic> json) => Blusher(
//         itemData: BlusherItemData.fromJson(json["item_data"]),
//         recommendedColor: json["recommended_color"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "item_data": itemData?.toJson(),
//         "recommended_color": recommendedColor,
//       };
// }
//
// class BlusherItemData {
//   BlusherItemData({
//     this.entityId = "",
//     this.attributeSetId = "",
//     this.typeId = "",
//     this.sku = "",
//     this.faceArea = "",
//     this.hasOptions = "",
//     this.requiredOptions = "",
//     this.createdAt,
//     this.updatedAt,
//     this.name = "",
//     this.image = "",
//     this.smallImage = "",
//     this.thumbnail = "",
//     this.optionsContainer = "",
//     this.msrpDisplayActualPriceType = "",
//     this.urlKey = "",
//     this.urlPath = "",
//     this.faceColor = "",
//     this.shadeName = "",
//     this.directions = "",
//     this.brand = "",
//     this.volume = "",
//     this.status = "",
//     this.visibility = "",
//     this.taxClassId = "",
//     this.size = "",
//     this.storeYear = "",
//     this.faceSubArea = "",
//     this.drySkin = "",
//     this.oilBased = "",
//     this.sensitiveSkin = "",
//     this.matte = "",
//     this.radiant = "",
//     this.shadeColor = "",
//     this.veganCrueltyFree = "",
//     this.tryOn = "",
//     this.brandName = "",
//     this.price = "",
//     this.description = "",
//     this.shortDescription = "",
//     this.ingredients = "",
//     this.dealFromDate,
//     this.dealToDate,
//     this.options = const [],
//     this.mediaGallery,
//     this.extensionAttributes,
//     this.tierPrice = const [],
//     this.tierPriceChanged = 0,
//     this.quantityAndStockStatus,
//     this.categoryIds = const [],
//     this.isSalable = 0,
//     this.requestPath = "",
//     this.finalPrice = 0,
//     this.customer,
//     this.product,
//     this.customerWarningFlag = "",
//   });
//
//   String entityId;
//   String attributeSetId;
//   String typeId;
//   String sku;
//   String faceArea;
//   String hasOptions;
//   String requiredOptions;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String name;
//   String image;
//   String smallImage;
//   String thumbnail;
//   String optionsContainer;
//   String msrpDisplayActualPriceType;
//   String urlKey;
//   String urlPath;
//   String faceColor;
//   String shadeName;
//   String directions;
//   String brand;
//   String volume;
//   String status;
//   String visibility;
//   String taxClassId;
//   String size;
//   String storeYear;
//   String faceSubArea;
//   String drySkin;
//   String oilBased;
//   String sensitiveSkin;
//   String matte;
//   String radiant;
//   String shadeColor;
//   String veganCrueltyFree;
//   String tryOn;
//   String brandName;
//   String price;
//   String description;
//   String shortDescription;
//   String ingredients;
//   DateTime? dealFromDate;
//   DateTime? dealToDate;
//   List<dynamic> options;
//   PurpleMediaGallery? mediaGallery;
//   ExtensionAttributes? extensionAttributes;
//   List<dynamic> tierPrice;
//   int tierPriceChanged;
//   QuantityAndStockStatus? quantityAndStockStatus;
//   List<String> categoryIds;
//   int isSalable;
//   String requestPath;
//   double finalPrice;
//   Customer? customer;
//   Customer? product;
//   String customerWarningFlag;
//
//   factory BlusherItemData.fromJson(Map<String, dynamic> json) =>
//       BlusherItemData(
//         entityId: json["entity_id"],
//         attributeSetId: json["attribute_set_id"],
//         typeId: json["type_id"],
//         sku: json["sku"],
//         faceArea: json["face_area"],
//         hasOptions: json["has_options"],
//         requiredOptions: json["required_options"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         name: json["name"],
//         image: json["image"],
//         smallImage: json["small_image"],
//         thumbnail: json["thumbnail"],
//         optionsContainer: json["options_container"],
//         msrpDisplayActualPriceType: json["msrp_display_actual_price_type"],
//         urlKey: json["url_key"],
//         urlPath: json["url_path"],
//         faceColor: json["face_color"],
//         shadeName: json["shade_name"],
//         directions: json["directions"],
//         brand: json["brand"],
//         volume: json["volume"],
//         status: json["status"],
//         visibility: json["visibility"],
//         taxClassId: json["tax_class_id"],
//         size: json["size"],
//         storeYear: json["store_year"],
//         faceSubArea: json["face_sub_area"],
//         drySkin: json["dry_skin"],
//         oilBased: json["oil_based"],
//         sensitiveSkin: json["sensitive_skin"],
//         matte: json["matte"],
//         radiant: json["radiant"],
//         shadeColor: json["shade_color"],
//         veganCrueltyFree: json["vegan_cruelty_free"],
//         tryOn: json["try_on"],
//         brandName: json["brand_name"],
//         price: json["price"],
//         description: json["description"],
//         shortDescription: json["short_description"],
//         ingredients: json["ingredients"],
//         dealFromDate: DateTime.parse(json["deal_from_date"]),
//         dealToDate: DateTime.parse(json["deal_to_date"]),
//         options: List<dynamic>.from(json["options"].map((x) => x)),
//         mediaGallery: PurpleMediaGallery.fromJson(json["media_gallery"]),
//         extensionAttributes:
//             ExtensionAttributes.fromJson(json["extension_attributes"]),
//         tierPrice: List<dynamic>.from(json["tier_price"].map((x) => x)),
//         tierPriceChanged: json["tier_price_changed"],
//         quantityAndStockStatus:
//             QuantityAndStockStatus.fromJson(json["quantity_and_stock_status"]),
//         categoryIds: List<String>.from(json["category_ids"].map((x) => x)),
//         isSalable: json["is_salable"],
//         requestPath: json["request_path"],
//         finalPrice: json["final_price"].toDouble(),
//         customer: Customer.fromJson(json["customer"]),
//         product: Customer.fromJson(json["product"]),
//         customerWarningFlag: json["customer_warning_flag"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "entity_id": entityId,
//         "attribute_set_id": attributeSetId,
//         "type_id": typeId,
//         "sku": sku,
//         "face_area": faceArea,
//         "has_options": hasOptions,
//         "required_options": requiredOptions,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "name": name,
//         "image": image,
//         "small_image": smallImage,
//         "thumbnail": thumbnail,
//         "options_container": optionsContainer,
//         "msrp_display_actual_price_type": msrpDisplayActualPriceType,
//         "url_key": urlKey,
//         "url_path": urlPath,
//         "face_color": faceColor,
//         "shade_name": shadeName,
//         "directions": directions,
//         "brand": brand,
//         "volume": volume,
//         "status": status,
//         "visibility": visibility,
//         "tax_class_id": taxClassId,
//         "size": size,
//         "store_year": storeYear,
//         "face_sub_area": faceSubArea,
//         "dry_skin": drySkin,
//         "oil_based": oilBased,
//         "sensitive_skin": sensitiveSkin,
//         "matte": matte,
//         "radiant": radiant,
//         "shade_color": shadeColor,
//         "vegan_cruelty_free": veganCrueltyFree,
//         "try_on": tryOn,
//         "brand_name": brandName,
//         "price": price,
//         "description": description,
//         "short_description": shortDescription,
//         "ingredients": ingredients,
//         "deal_from_date": dealFromDate?.toIso8601String(),
//         "deal_to_date": dealToDate?.toIso8601String(),
//         "options": List<dynamic>.from(options.map((x) => x)),
//         "media_gallery": mediaGallery?.toJson(),
//         "extension_attributes": extensionAttributes?.toJson(),
//         "tier_price": List<dynamic>.from(tierPrice.map((x) => x)),
//         "tier_price_changed": tierPriceChanged,
//         "quantity_and_stock_status": quantityAndStockStatus?.toJson(),
//         "category_ids": List<dynamic>.from(categoryIds.map((x) => x)),
//         "is_salable": isSalable,
//         "request_path": requestPath,
//         "final_price": finalPrice,
//         "customer": customer?.toJson(),
//         "product": product?.toJson(),
//         "customer_warning_flag": customerWarningFlag,
//       };
// }
//
// class Customer {
//   Customer();
//
//   factory Customer.fromJson(Map<String, dynamic> json) => Customer();
//
//   Map<String, dynamic> toJson() => {};
// }
//
// class ExtensionAttributes {
//   ExtensionAttributes({
//     this.avgratings = "",
//     this.reviewCount = 0,
//     this.productUrl = "",
//     this.rewardPoints = 0,
//     this.stockStatus = "",
//     this.stockLeft,
//     this.skuShade = "",
//   });
//
//   String avgratings;
//   int reviewCount;
//   String productUrl;
//   int rewardPoints;
//   String stockStatus;
//   StockLeft? stockLeft;
//   String skuShade;
//
//   factory ExtensionAttributes.fromJson(Map<String, dynamic> json) =>
//       ExtensionAttributes(
//         avgratings: json["avgratings"],
//         reviewCount: json["review_count"],
//         productUrl: json["product_url"],
//         rewardPoints: json["reward_points"],
//         stockStatus: json["stock_status"],
//         stockLeft: stockLeftValues.map[json["stock_left"]],
//         skuShade: json["sku_shade"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "avgratings": avgratings,
//         "review_count": reviewCount,
//         "product_url": productUrl,
//         "reward_points": rewardPoints,
//         "stock_status": stockStatus,
//         "stock_left": stockLeftValues.reverse[stockLeft],
//         "sku_shade": skuShade,
//       };
// }
//
// enum StockLeft { ONLY_1_LEFT }
//
// final stockLeftValues = EnumValues({"Only 1 Left": StockLeft.ONLY_1_LEFT});
//
// class PurpleMediaGallery {
//   PurpleMediaGallery({
//     this.images,
//     this.values = const [],
//   });
//
//   PurpleImages? images;
//   List<dynamic> values;
//
//   factory PurpleMediaGallery.fromJson(Map<String, dynamic> json) =>
//       PurpleMediaGallery(
//         images: PurpleImages.fromJson(json["images"]),
//         values: List<dynamic>.from(json["values"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "images": images?.toJson(),
//         "values": List<dynamic>.from(values.map((x) => x)),
//       };
// }
//
// class PurpleImages {
//   PurpleImages({
//     this.the4429,
//   });
//
//   The4429? the4429;
//
//   factory PurpleImages.fromJson(Map<String, dynamic> json) => PurpleImages(
//         the4429: The4429.fromJson(json["4429"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "4429": the4429?.toJson(),
//       };
// }
//
// class The4429 {
//   The4429({
//     this.valueId = "",
//     this.file = "",
//     this.mediaType,
//     this.entityId = "",
//     this.label,
//     this.position = "",
//     this.disabled = "",
//     this.labelDefault,
//     this.positionDefault = "",
//     this.disabledDefault = "",
//     this.videoProvider,
//     this.videoUrl,
//     this.videoTitle,
//     this.videoDescription,
//     this.videoMetadata,
//     this.videoProviderDefault,
//     this.videoUrlDefault,
//     this.videoTitleDefault,
//     this.videoDescriptionDefault,
//     this.videoMetadataDefault,
//   });
//
//   String valueId;
//   String file;
//   MediaType? mediaType;
//   String entityId;
//   dynamic label;
//   String position;
//   String disabled;
//   dynamic labelDefault;
//   String positionDefault;
//   String disabledDefault;
//   dynamic videoProvider;
//   dynamic videoUrl;
//   dynamic videoTitle;
//   dynamic videoDescription;
//   dynamic videoMetadata;
//   dynamic videoProviderDefault;
//   dynamic videoUrlDefault;
//   dynamic videoTitleDefault;
//   dynamic videoDescriptionDefault;
//   dynamic videoMetadataDefault;
//
//   factory The4429.fromJson(Map<String, dynamic> json) => The4429(
//         valueId: json["value_id"],
//         file: json["file"],
//         mediaType: mediaTypeValues.map[json["media_type"]],
//         entityId: json["entity_id"],
//         label: json["label"],
//         position: json["position"],
//         disabled: json["disabled"],
//         labelDefault: json["label_default"],
//         positionDefault: json["position_default"],
//         disabledDefault: json["disabled_default"],
//         videoProvider: json["video_provider"],
//         videoUrl: json["video_url"],
//         videoTitle: json["video_title"],
//         videoDescription: json["video_description"],
//         videoMetadata: json["video_metadata"],
//         videoProviderDefault: json["video_provider_default"],
//         videoUrlDefault: json["video_url_default"],
//         videoTitleDefault: json["video_title_default"],
//         videoDescriptionDefault: json["video_description_default"],
//         videoMetadataDefault: json["video_metadata_default"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "value_id": valueId,
//         "file": file,
//         "media_type": mediaTypeValues.reverse[mediaType],
//         "entity_id": entityId,
//         "label": label,
//         "position": position,
//         "disabled": disabled,
//         "label_default": labelDefault,
//         "position_default": positionDefault,
//         "disabled_default": disabledDefault,
//         "video_provider": videoProvider,
//         "video_url": videoUrl,
//         "video_title": videoTitle,
//         "video_description": videoDescription,
//         "video_metadata": videoMetadata,
//         "video_provider_default": videoProviderDefault,
//         "video_url_default": videoUrlDefault,
//         "video_title_default": videoTitleDefault,
//         "video_description_default": videoDescriptionDefault,
//         "video_metadata_default": videoMetadataDefault,
//       };
// }
//
// enum MediaType { IMAGE }
//
// final mediaTypeValues = EnumValues({"image": MediaType.IMAGE});
//
// class QuantityAndStockStatus {
//   QuantityAndStockStatus({
//     this.isInStock = false,
//     this.qty = 0,
//   });
//
//   bool isInStock;
//   int qty;
//
//   factory QuantityAndStockStatus.fromJson(Map<String, dynamic> json) =>
//       QuantityAndStockStatus(
//         isInStock: json["is_in_stock"],
//         qty: json["qty"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "is_in_stock": isInStock,
//         "qty": qty,
//       };
// }
//
// class Bronzer {
//   Bronzer({
//     this.itemData,
//     this.recommendedColor = "",
//   });
//
//   BronzerItemData? itemData;
//   String recommendedColor;
//
//   factory Bronzer.fromJson(Map<String, dynamic> json) => Bronzer(
//         itemData: BronzerItemData.fromJson(json["item_data"]),
//         recommendedColor: json["recommended_color"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "item_data": itemData?.toJson(),
//         "recommended_color": recommendedColor,
//       };
// }
//
// class BronzerItemData {
//   BronzerItemData({
//     this.entityId = "",
//     this.attributeSetId = "",
//     this.typeId = "",
//     this.sku = "",
//     this.faceArea = "",
//     this.hasOptions = "",
//     this.requiredOptions = "",
//     this.createdAt,
//     this.updatedAt,
//     this.name = "",
//     this.image = "",
//     this.smallImage = "",
//     this.thumbnail = "",
//     this.optionsContainer = "",
//     this.msrpDisplayActualPriceType = "",
//     this.urlKey = "",
//     this.urlPath = "",
//     this.faceColor = "",
//     this.shadeName = "",
//     this.directions = "",
//     this.brand = "",
//     this.volume = "",
//     this.status = "",
//     this.visibility = "",
//     this.taxClassId = "",
//     this.size = "",
//     this.storeYear = "",
//     this.faceSubArea = "",
//     this.drySkin = "",
//     this.oilBased = "",
//     this.sensitiveSkin = "",
//     this.matte = "",
//     this.radiant = "",
//     this.shadeColor = "",
//     this.veganCrueltyFree = "",
//     this.tryOn = "",
//     this.brandName = "",
//     this.price = "",
//     this.description = "",
//     this.shortDescription = "",
//     this.ingredients = "",
//     this.dealFromDate,
//     this.dealToDate,
//     this.options = const [],
//     this.mediaGallery,
//     this.extensionAttributes,
//     this.tierPrice = const [],
//     this.tierPriceChanged = 0,
//     this.quantityAndStockStatus,
//     this.categoryIds = const [],
//     this.isSalable = 0,
//     this.requestPath = false,
//     this.finalPrice = 0,
//     this.customer,
//     this.product,
//     this.customerWarningFlag = "",
//   });
//
//   String entityId;
//   String attributeSetId;
//   String typeId;
//   String sku;
//   String faceArea;
//   String hasOptions;
//   String requiredOptions;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String name;
//   String image;
//   String smallImage;
//   String thumbnail;
//   String optionsContainer;
//   String msrpDisplayActualPriceType;
//   String urlKey;
//   String urlPath;
//   String faceColor;
//   String shadeName;
//   String directions;
//   String brand;
//   String volume;
//   String status;
//   String visibility;
//   String taxClassId;
//   String size;
//   String storeYear;
//   String faceSubArea;
//   String drySkin;
//   String oilBased;
//   String sensitiveSkin;
//   String matte;
//   String radiant;
//   String shadeColor;
//   String veganCrueltyFree;
//   String tryOn;
//   String brandName;
//   String price;
//   String description;
//   String shortDescription;
//   String ingredients;
//   DateTime? dealFromDate;
//   DateTime? dealToDate;
//   List<dynamic> options;
//   FluffyMediaGallery? mediaGallery;
//   ExtensionAttributes? extensionAttributes;
//   List<dynamic> tierPrice;
//   int tierPriceChanged;
//   QuantityAndStockStatus? quantityAndStockStatus;
//   List<String> categoryIds;
//   int isSalable;
//   bool requestPath;
//   double finalPrice;
//   Customer? customer;
//   Customer? product;
//   String customerWarningFlag;
//
//   factory BronzerItemData.fromJson(Map<String, dynamic> json) =>
//       BronzerItemData(
//         entityId: json["entity_id"],
//         attributeSetId: json["attribute_set_id"],
//         typeId: json["type_id"],
//         sku: json["sku"],
//         faceArea: json["face_area"],
//         hasOptions: json["has_options"],
//         requiredOptions: json["required_options"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         name: json["name"],
//         image: json["image"],
//         smallImage: json["small_image"],
//         thumbnail: json["thumbnail"],
//         optionsContainer: json["options_container"],
//         msrpDisplayActualPriceType: json["msrp_display_actual_price_type"],
//         urlKey: json["url_key"],
//         urlPath: json["url_path"],
//         faceColor: json["face_color"],
//         shadeName: json["shade_name"],
//         directions: json["directions"],
//         brand: json["brand"],
//         volume: json["volume"],
//         status: json["status"],
//         visibility: json["visibility"],
//         taxClassId: json["tax_class_id"],
//         size: json["size"],
//         storeYear: json["store_year"],
//         faceSubArea: json["face_sub_area"],
//         drySkin: json["dry_skin"],
//         oilBased: json["oil_based"],
//         sensitiveSkin: json["sensitive_skin"],
//         matte: json["matte"],
//         radiant: json["radiant"],
//         shadeColor: json["shade_color"],
//         veganCrueltyFree: json["vegan_cruelty_free"],
//         tryOn: json["try_on"],
//         brandName: json["brand_name"],
//         price: json["price"],
//         description: json["description"],
//         shortDescription: json["short_description"],
//         ingredients: json["ingredients"],
//         dealFromDate: DateTime.parse(json["deal_from_date"]),
//         dealToDate: DateTime.parse(json["deal_to_date"]),
//         options: List<dynamic>.from(json["options"].map((x) => x)),
//         mediaGallery: FluffyMediaGallery.fromJson(json["media_gallery"]),
//         extensionAttributes:
//             ExtensionAttributes.fromJson(json["extension_attributes"]),
//         tierPrice: List<dynamic>.from(json["tier_price"].map((x) => x)),
//         tierPriceChanged: json["tier_price_changed"],
//         quantityAndStockStatus:
//             QuantityAndStockStatus.fromJson(json["quantity_and_stock_status"]),
//         categoryIds: List<String>.from(json["category_ids"].map((x) => x)),
//         isSalable: json["is_salable"],
//         requestPath: json["request_path"],
//         finalPrice: json["final_price"].toDouble(),
//         customer: Customer.fromJson(json["customer"]),
//         product: Customer.fromJson(json["product"]),
//         customerWarningFlag: json["customer_warning_flag"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "entity_id": entityId,
//         "attribute_set_id": attributeSetId,
//         "type_id": typeId,
//         "sku": sku,
//         "face_area": faceArea,
//         "has_options": hasOptions,
//         "required_options": requiredOptions,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "name": name,
//         "image": image,
//         "small_image": smallImage,
//         "thumbnail": thumbnail,
//         "options_container": optionsContainer,
//         "msrp_display_actual_price_type": msrpDisplayActualPriceType,
//         "url_key": urlKey,
//         "url_path": urlPath,
//         "face_color": faceColor,
//         "shade_name": shadeName,
//         "directions": directions,
//         "brand": brand,
//         "volume": volume,
//         "status": status,
//         "visibility": visibility,
//         "tax_class_id": taxClassId,
//         "size": size,
//         "store_year": storeYear,
//         "face_sub_area": faceSubArea,
//         "dry_skin": drySkin,
//         "oil_based": oilBased,
//         "sensitive_skin": sensitiveSkin,
//         "matte": matte,
//         "radiant": radiant,
//         "shade_color": shadeColor,
//         "vegan_cruelty_free": veganCrueltyFree,
//         "try_on": tryOn,
//         "brand_name": brandName,
//         "price": price,
//         "description": description,
//         "short_description": shortDescription,
//         "ingredients": ingredients,
//         "deal_from_date": dealFromDate?.toIso8601String(),
//         "deal_to_date": dealToDate?.toIso8601String(),
//         "options": List<dynamic>.from(options.map((x) => x)),
//         "media_gallery": mediaGallery?.toJson(),
//         "extension_attributes": extensionAttributes?.toJson(),
//         "tier_price": List<dynamic>.from(tierPrice.map((x) => x)),
//         "tier_price_changed": tierPriceChanged,
//         "quantity_and_stock_status": quantityAndStockStatus?.toJson(),
//         "category_ids": List<dynamic>.from(categoryIds.map((x) => x)),
//         "is_salable": isSalable,
//         "request_path": requestPath,
//         "final_price": finalPrice,
//         "customer": customer?.toJson(),
//         "product": product?.toJson(),
//         "customer_warning_flag": customerWarningFlag,
//       };
// }
//
// class FluffyMediaGallery {
//   FluffyMediaGallery({
//     this.images,
//     this.values = const [],
//   });
//
//   FluffyImages? images;
//   List<dynamic> values;
//
//   factory FluffyMediaGallery.fromJson(Map<String, dynamic> json) =>
//       FluffyMediaGallery(
//         images: FluffyImages.fromJson(json["images"]),
//         values: List<dynamic>.from(json["values"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "images": images?.toJson(),
//         "values": List<dynamic>.from(values.map((x) => x)),
//       };
// }
//
// class FluffyImages {
//   FluffyImages({
//     this.the5487,
//   });
//
//   The4429? the5487;
//
//   factory FluffyImages.fromJson(Map<String, dynamic> json) => FluffyImages(
//         the5487: The4429.fromJson(json["5487"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "5487": the5487?.toJson(),
//       };
// }
//
// class Eyelid {
//   Eyelid({
//     this.itemData,
//     this.recommendedColor = "",
//   });
//
//   EyelidItemData? itemData;
//   String recommendedColor;
//
//   factory Eyelid.fromJson(Map<String, dynamic> json) => Eyelid(
//         itemData: EyelidItemData.fromJson(json["item_data"]),
//         recommendedColor: json["recommended_color"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "item_data": itemData?.toJson(),
//         "recommended_color": recommendedColor,
//       };
// }
//
// class EyelidItemData {
//   EyelidItemData({
//     this.entityId = "",
//     this.attributeSetId = "",
//     this.typeId = "",
//     this.sku = "",
//     this.faceArea = "",
//     this.hasOptions = "",
//     this.requiredOptions = "",
//     this.createdAt,
//     this.updatedAt,
//     this.name = "",
//     this.image = "",
//     this.smallImage = "",
//     this.thumbnail = "",
//     this.optionsContainer = "",
//     this.msrpDisplayActualPriceType = "",
//     this.urlKey = "",
//     this.urlPath = "",
//     this.faceColor = "",
//     this.shadeName = "",
//     this.directions = "",
//     this.brand = "",
//     this.volume = "",
//     this.status = "",
//     this.visibility = "",
//     this.taxClassId = "",
//     this.size = "",
//     this.storeYear = "",
//     this.faceSubArea = "",
//     this.drySkin = "",
//     this.oilBased = "",
//     this.sensitiveSkin = "",
//     this.matte = "",
//     this.radiant = "",
//     this.shadeColor = "",
//     this.veganCrueltyFree = "",
//     this.tryOn = "",
//     this.price = "",
//     this.description = "",
//     this.shortDescription = "",
//     this.ingredients,
//     this.dealFromDate,
//     this.dealToDate,
//     this.options = const [],
//     this.mediaGallery,
//     this.extensionAttributes,
//     this.tierPrice = const [],
//     this.tierPriceChanged = 0,
//     this.quantityAndStockStatus,
//     this.categoryIds = const [],
//     this.isSalable = 0,
//     this.requestPath = false,
//     this.finalPrice = 0,
//     this.customer,
//     this.product,
//     this.customerWarningFlag = "",
//   });
//
//   String entityId;
//   String attributeSetId;
//   String typeId;
//   String sku;
//   String faceArea;
//   String hasOptions;
//   String requiredOptions;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String name;
//   String image;
//   String smallImage;
//   String thumbnail;
//   String optionsContainer;
//   String msrpDisplayActualPriceType;
//   String urlKey;
//   String urlPath;
//   String faceColor;
//   String shadeName;
//   String directions;
//   String brand;
//   String volume;
//   String status;
//   String visibility;
//   String taxClassId;
//   String size;
//   String storeYear;
//   String faceSubArea;
//   String drySkin;
//   String oilBased;
//   String sensitiveSkin;
//   String matte;
//   String radiant;
//   String shadeColor;
//   String veganCrueltyFree;
//   String tryOn;
//   String price;
//   String description;
//   String shortDescription;
//   dynamic ingredients;
//   DateTime? dealFromDate;
//   DateTime? dealToDate;
//   List<dynamic> options;
//   TentacledMediaGallery? mediaGallery;
//   ExtensionAttributes? extensionAttributes;
//   List<dynamic> tierPrice;
//   int tierPriceChanged;
//   QuantityAndStockStatus? quantityAndStockStatus;
//   List<String> categoryIds;
//   int isSalable;
//   bool requestPath;
//   double finalPrice;
//   Customer? customer;
//   Customer? product;
//   String customerWarningFlag;
//
//   factory EyelidItemData.fromJson(Map<String, dynamic> json) => EyelidItemData(
//         entityId: json["entity_id"],
//         attributeSetId: json["attribute_set_id"],
//         typeId: json["type_id"],
//         sku: json["sku"],
//         faceArea: json["face_area"],
//         hasOptions: json["has_options"],
//         requiredOptions: json["required_options"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         name: json["name"],
//         image: json["image"],
//         smallImage: json["small_image"],
//         thumbnail: json["thumbnail"],
//         optionsContainer: json["options_container"],
//         msrpDisplayActualPriceType: json["msrp_display_actual_price_type"],
//         urlKey: json["url_key"],
//         urlPath: json["url_path"],
//         faceColor: json["face_color"],
//         shadeName: json["shade_name"],
//         directions: json["directions"],
//         brand: json["brand"],
//         volume: json["volume"],
//         status: json["status"],
//         visibility: json["visibility"],
//         taxClassId: json["tax_class_id"],
//         size: json["size"],
//         storeYear: json["store_year"],
//         faceSubArea: json["face_sub_area"],
//         drySkin: json["dry_skin"],
//         oilBased: json["oil_based"],
//         sensitiveSkin: json["sensitive_skin"],
//         matte: json["matte"],
//         radiant: json["radiant"],
//         shadeColor: json["shade_color"],
//         veganCrueltyFree: json["vegan_cruelty_free"],
//         tryOn: json["try_on"],
//         price: json["price"],
//         description: json["description"],
//         shortDescription: json["short_description"],
//         ingredients: json["ingredients"],
//         dealFromDate: DateTime.parse(json["deal_from_date"]),
//         dealToDate: DateTime.parse(json["deal_to_date"]),
//         options: List<dynamic>.from(json["options"].map((x) => x)),
//         mediaGallery: TentacledMediaGallery.fromJson(json["media_gallery"]),
//         extensionAttributes:
//             ExtensionAttributes.fromJson(json["extension_attributes"]),
//         tierPrice: List<dynamic>.from(json["tier_price"].map((x) => x)),
//         tierPriceChanged: json["tier_price_changed"],
//         quantityAndStockStatus:
//             QuantityAndStockStatus.fromJson(json["quantity_and_stock_status"]),
//         categoryIds: List<String>.from(json["category_ids"].map((x) => x)),
//         isSalable: json["is_salable"],
//         requestPath: json["request_path"],
//         finalPrice: json["final_price"].toDouble(),
//         customer: Customer.fromJson(json["customer"]),
//         product: Customer.fromJson(json["product"]),
//         customerWarningFlag: json["customer_warning_flag"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "entity_id": entityId,
//         "attribute_set_id": attributeSetId,
//         "type_id": typeId,
//         "sku": sku,
//         "face_area": faceArea,
//         "has_options": hasOptions,
//         "required_options": requiredOptions,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "name": name,
//         "image": image,
//         "small_image": smallImage,
//         "thumbnail": thumbnail,
//         "options_container": optionsContainer,
//         "msrp_display_actual_price_type": msrpDisplayActualPriceType,
//         "url_key": urlKey,
//         "url_path": urlPath,
//         "face_color": faceColor,
//         "shade_name": shadeName,
//         "directions": directions,
//         "brand": brand,
//         "volume": volume,
//         "status": status,
//         "visibility": visibility,
//         "tax_class_id": taxClassId,
//         "size": size,
//         "store_year": storeYear,
//         "face_sub_area": faceSubArea,
//         "dry_skin": drySkin,
//         "oil_based": oilBased,
//         "sensitive_skin": sensitiveSkin,
//         "matte": matte,
//         "radiant": radiant,
//         "shade_color": shadeColor,
//         "vegan_cruelty_free": veganCrueltyFree,
//         "try_on": tryOn,
//         "price": price,
//         "description": description,
//         "short_description": shortDescription,
//         "ingredients": ingredients,
//         "deal_from_date": dealFromDate?.toIso8601String(),
//         "deal_to_date": dealToDate?.toIso8601String(),
//         "options": List<dynamic>.from(options.map((x) => x)),
//         "media_gallery": mediaGallery?.toJson(),
//         "extension_attributes": extensionAttributes?.toJson(),
//         "tier_price": List<dynamic>.from(tierPrice.map((x) => x)),
//         "tier_price_changed": tierPriceChanged,
//         "quantity_and_stock_status": quantityAndStockStatus?.toJson(),
//         "category_ids": List<dynamic>.from(categoryIds.map((x) => x)),
//         "is_salable": isSalable,
//         "request_path": requestPath,
//         "final_price": finalPrice,
//         "customer": customer?.toJson(),
//         "product": product?.toJson(),
//         "customer_warning_flag": customerWarningFlag,
//       };
// }
//
// class TentacledMediaGallery {
//   TentacledMediaGallery({
//     this.images,
//     this.values = const [],
//   });
//
//   TentacledImages? images;
//   List<dynamic> values;
//
//   factory TentacledMediaGallery.fromJson(Map<String, dynamic> json) =>
//       TentacledMediaGallery(
//         images: TentacledImages.fromJson(json["images"]),
//         values: List<dynamic>.from(json["values"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "images": images?.toJson(),
//         "values": List<dynamic>.from(values.map((x) => x)),
//       };
// }
//
// class TentacledImages {
//   TentacledImages({
//     this.the34087,
//   });
//
//   The4429? the34087;
//
//   factory TentacledImages.fromJson(Map<String, dynamic> json) =>
//       TentacledImages(
//         the34087: The4429.fromJson(json["34087"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "34087": the34087?.toJson(),
//       };
// }
//
// class Eyeliner {
//   Eyeliner({
//     this.itemData,
//     this.recommendedColor = "",
//   });
//
//   EyelinerItemData? itemData;
//   String recommendedColor;
//
//   factory Eyeliner.fromJson(Map<String, dynamic> json) => Eyeliner(
//         itemData: EyelinerItemData.fromJson(json["item_data"]),
//         recommendedColor: json["recommended_color"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "item_data": itemData?.toJson(),
//         "recommended_color": recommendedColor,
//       };
// }
//
// class EyelinerItemData {
//   EyelinerItemData({
//     this.entityId = "",
//     this.attributeSetId = "",
//     this.typeId = "",
//     this.sku = "",
//     this.faceArea = "",
//     this.hasOptions = "",
//     this.requiredOptions = "",
//     this.createdAt,
//     this.updatedAt,
//     this.name = "",
//     this.image = "",
//     this.smallImage = "",
//     this.thumbnail = "",
//     this.optionsContainer = "",
//     this.msrpDisplayActualPriceType = "",
//     this.urlKey = "",
//     this.urlPath = "",
//     this.faceColor = "",
//     this.shadeName = "",
//     this.directions = "",
//     this.brand = "",
//     this.volume = "",
//     this.status = "",
//     this.visibility = "",
//     this.taxClassId = "",
//     this.size = "",
//     this.storeYear = "",
//     this.faceSubArea = "",
//     this.drySkin = "",
//     this.oilBased = "",
//     this.sensitiveSkin = "",
//     this.matte = "",
//     this.radiant = "",
//     this.shadeColor = "",
//     this.veganCrueltyFree = "",
//     this.tryOn = "",
//     this.price = "",
//     this.description = "",
//     this.shortDescription = "",
//     this.ingredients = "",
//     this.dealFromDate,
//     this.dealToDate,
//     this.options = const [],
//     this.mediaGallery,
//     this.extensionAttributes,
//     this.tierPrice = const [],
//     this.tierPriceChanged = 0,
//     this.quantityAndStockStatus,
//     this.categoryIds = const [],
//     this.isSalable = 0,
//     this.requestPath = false,
//     this.finalPrice = 0,
//     this.customer,
//     this.product,
//     this.customerWarningFlag = "",
//   });
//
//   String entityId;
//   String attributeSetId;
//   String typeId;
//   String sku;
//   String faceArea;
//   String hasOptions;
//   String requiredOptions;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String name;
//   String image;
//   String smallImage;
//   String thumbnail;
//   String optionsContainer;
//   String msrpDisplayActualPriceType;
//   String urlKey;
//   String urlPath;
//   String faceColor;
//   String shadeName;
//   String directions;
//   String brand;
//   String volume;
//   String status;
//   String visibility;
//   String taxClassId;
//   String size;
//   String storeYear;
//   String faceSubArea;
//   String drySkin;
//   String oilBased;
//   String sensitiveSkin;
//   String matte;
//   String radiant;
//   String shadeColor;
//   String veganCrueltyFree;
//   String tryOn;
//   String price;
//   String description;
//   String shortDescription;
//   String ingredients;
//   DateTime? dealFromDate;
//   DateTime? dealToDate;
//   List<dynamic> options;
//   StickyMediaGallery? mediaGallery;
//   ExtensionAttributes? extensionAttributes;
//   List<dynamic> tierPrice;
//   int tierPriceChanged;
//   QuantityAndStockStatus? quantityAndStockStatus;
//   List<String> categoryIds;
//   int isSalable;
//   bool requestPath;
//   double finalPrice;
//   Customer? customer;
//   Customer? product;
//   String customerWarningFlag;
//
//   factory EyelinerItemData.fromJson(Map<String, dynamic> json) =>
//       EyelinerItemData(
//         entityId: json["entity_id"],
//         attributeSetId: json["attribute_set_id"],
//         typeId: json["type_id"],
//         sku: json["sku"],
//         faceArea: json["face_area"],
//         hasOptions: json["has_options"],
//         requiredOptions: json["required_options"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         name: json["name"],
//         image: json["image"],
//         smallImage: json["small_image"],
//         thumbnail: json["thumbnail"],
//         optionsContainer: json["options_container"],
//         msrpDisplayActualPriceType: json["msrp_display_actual_price_type"],
//         urlKey: json["url_key"],
//         urlPath: json["url_path"],
//         faceColor: json["face_color"],
//         shadeName: json["shade_name"],
//         directions: json["directions"],
//         brand: json["brand"],
//         volume: json["volume"],
//         status: json["status"],
//         visibility: json["visibility"],
//         taxClassId: json["tax_class_id"],
//         size: json["size"],
//         storeYear: json["store_year"],
//         faceSubArea: json["face_sub_area"],
//         drySkin: json["dry_skin"],
//         oilBased: json["oil_based"],
//         sensitiveSkin: json["sensitive_skin"],
//         matte: json["matte"],
//         radiant: json["radiant"],
//         shadeColor: json["shade_color"],
//         veganCrueltyFree: json["vegan_cruelty_free"],
//         tryOn: json["try_on"],
//         price: json["price"],
//         description: json["description"],
//         shortDescription: json["short_description"],
//         ingredients: json["ingredients"],
//         dealFromDate: DateTime.parse(json["deal_from_date"]),
//         dealToDate: DateTime.parse(json["deal_to_date"]),
//         options: List<dynamic>.from(json["options"].map((x) => x)),
//         mediaGallery: StickyMediaGallery.fromJson(json["media_gallery"]),
//         extensionAttributes:
//             ExtensionAttributes.fromJson(json["extension_attributes"]),
//         tierPrice: List<dynamic>.from(json["tier_price"].map((x) => x)),
//         tierPriceChanged: json["tier_price_changed"],
//         quantityAndStockStatus:
//             QuantityAndStockStatus.fromJson(json["quantity_and_stock_status"]),
//         categoryIds: List<String>.from(json["category_ids"].map((x) => x)),
//         isSalable: json["is_salable"],
//         requestPath: json["request_path"],
//         finalPrice: json["final_price"].toDouble(),
//         customer: Customer.fromJson(json["customer"]),
//         product: Customer.fromJson(json["product"]),
//         customerWarningFlag: json["customer_warning_flag"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "entity_id": entityId,
//         "attribute_set_id": attributeSetId,
//         "type_id": typeId,
//         "sku": sku,
//         "face_area": faceArea,
//         "has_options": hasOptions,
//         "required_options": requiredOptions,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "name": name,
//         "image": image,
//         "small_image": smallImage,
//         "thumbnail": thumbnail,
//         "options_container": optionsContainer,
//         "msrp_display_actual_price_type": msrpDisplayActualPriceType,
//         "url_key": urlKey,
//         "url_path": urlPath,
//         "face_color": faceColor,
//         "shade_name": shadeName,
//         "directions": directions,
//         "brand": brand,
//         "volume": volume,
//         "status": status,
//         "visibility": visibility,
//         "tax_class_id": taxClassId,
//         "size": size,
//         "store_year": storeYear,
//         "face_sub_area": faceSubArea,
//         "dry_skin": drySkin,
//         "oil_based": oilBased,
//         "sensitive_skin": sensitiveSkin,
//         "matte": matte,
//         "radiant": radiant,
//         "shade_color": shadeColor,
//         "vegan_cruelty_free": veganCrueltyFree,
//         "try_on": tryOn,
//         "price": price,
//         "description": description,
//         "short_description": shortDescription,
//         "ingredients": ingredients,
//         "deal_from_date": dealFromDate?.toIso8601String(),
//         "deal_to_date": dealToDate?.toIso8601String(),
//         "options": List<dynamic>.from(options.map((x) => x)),
//         "media_gallery": mediaGallery?.toJson(),
//         "extension_attributes": extensionAttributes?.toJson(),
//         "tier_price": List<dynamic>.from(tierPrice.map((x) => x)),
//         "tier_price_changed": tierPriceChanged,
//         "quantity_and_stock_status": quantityAndStockStatus?.toJson(),
//         "category_ids": List<dynamic>.from(categoryIds.map((x) => x)),
//         "is_salable": isSalable,
//         "request_path": requestPath,
//         "final_price": finalPrice,
//         "customer": customer?.toJson(),
//         "product": product?.toJson(),
//         "customer_warning_flag": customerWarningFlag,
//       };
// }
//
// class StickyMediaGallery {
//   StickyMediaGallery({
//     this.images,
//     this.values = const [],
//   });
//
//   StickyImages? images;
//   List<dynamic> values;
//
//   factory StickyMediaGallery.fromJson(Map<String, dynamic> json) =>
//       StickyMediaGallery(
//         images: StickyImages.fromJson(json["images"]),
//         values: List<dynamic>.from(json["values"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "images": images?.toJson(),
//         "values": List<dynamic>.from(values.map((x) => x)),
//       };
// }
//
// class StickyImages {
//   StickyImages({
//     this.the35129,
//   });
//
//   The4429? the35129;
//
//   factory StickyImages.fromJson(Map<String, dynamic> json) => StickyImages(
//         the35129: The4429.fromJson(json["35129"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "35129": the35129?.toJson(),
//       };
// }
//
// class Highlighter {
//   Highlighter({
//     this.itemData,
//     this.recommendedColor = "",
//   });
//
//   HighlighterItemData? itemData;
//   String recommendedColor;
//
//   factory Highlighter.fromJson(Map<String, dynamic> json) => Highlighter(
//         itemData: HighlighterItemData.fromJson(json["item_data"]),
//         recommendedColor: json["recommended_color"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "item_data": itemData?.toJson(),
//         "recommended_color": recommendedColor,
//       };
// }
//
// class HighlighterItemData {
//   HighlighterItemData({
//     this.entityId = "",
//     this.attributeSetId = "",
//     this.typeId = "",
//     this.sku = "",
//     this.faceArea = "",
//     this.hasOptions = "",
//     this.requiredOptions = "",
//     this.createdAt,
//     this.updatedAt,
//     this.name = "",
//     this.image = "",
//     this.smallImage = "",
//     this.thumbnail = "",
//     this.optionsContainer = "",
//     this.msrpDisplayActualPriceType = "",
//     this.urlKey = "",
//     this.urlPath = "",
//     this.faceColor = "",
//     this.shadeName = "",
//     this.directions = "",
//     this.brand = "",
//     this.volume = "",
//     this.status = "",
//     this.visibility = "",
//     this.taxClassId = "",
//     this.size = "",
//     this.storeYear = "",
//     this.faceSubArea = "",
//     this.drySkin = "",
//     this.oilBased = "",
//     this.sensitiveSkin = "",
//     this.matte = "",
//     this.radiant = "",
//     this.shadeColor = "",
//     this.veganCrueltyFree = "",
//     this.tryOn = "",
//     this.brandName = "",
//     this.price = "",
//     this.description = "",
//     this.shortDescription = "",
//     this.ingredients = "",
//     this.dealFromDate,
//     this.dealToDate,
//     this.options = const [],
//     this.mediaGallery,
//     this.extensionAttributes,
//     this.tierPrice = const [],
//     this.tierPriceChanged = 0,
//     this.quantityAndStockStatus,
//     this.categoryIds = const [],
//     this.isSalable = 0,
//     this.requestPath = false,
//     this.finalPrice = 0,
//     this.customer,
//     this.product,
//     this.customerWarningFlag = "",
//   });
//
//   String entityId;
//   String attributeSetId;
//   String typeId;
//   String sku;
//   String faceArea;
//   String hasOptions;
//   String requiredOptions;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String name;
//   String image;
//   String smallImage;
//   String thumbnail;
//   String optionsContainer;
//   String msrpDisplayActualPriceType;
//   String urlKey;
//   String urlPath;
//   String faceColor;
//   String shadeName;
//   String directions;
//   String brand;
//   String volume;
//   String status;
//   String visibility;
//   String taxClassId;
//   String size;
//   String storeYear;
//   String faceSubArea;
//   String drySkin;
//   String oilBased;
//   String sensitiveSkin;
//   String matte;
//   String radiant;
//   String shadeColor;
//   String veganCrueltyFree;
//   String tryOn;
//   String brandName;
//   String price;
//   String description;
//   String shortDescription;
//   String ingredients;
//   DateTime? dealFromDate;
//   DateTime? dealToDate;
//   List<dynamic> options;
//   IndigoMediaGallery? mediaGallery;
//   ExtensionAttributes? extensionAttributes;
//   List<dynamic> tierPrice;
//   int tierPriceChanged;
//   QuantityAndStockStatus? quantityAndStockStatus;
//   List<String> categoryIds;
//   int isSalable;
//   bool requestPath;
//   double finalPrice;
//   Customer? customer;
//   Customer? product;
//   String customerWarningFlag;
//
//   factory HighlighterItemData.fromJson(Map<String, dynamic> json) =>
//       HighlighterItemData(
//         entityId: json["entity_id"],
//         attributeSetId: json["attribute_set_id"],
//         typeId: json["type_id"],
//         sku: json["sku"],
//         faceArea: json["face_area"],
//         hasOptions: json["has_options"],
//         requiredOptions: json["required_options"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         name: json["name"],
//         image: json["image"],
//         smallImage: json["small_image"],
//         thumbnail: json["thumbnail"],
//         optionsContainer: json["options_container"],
//         msrpDisplayActualPriceType: json["msrp_display_actual_price_type"],
//         urlKey: json["url_key"],
//         urlPath: json["url_path"],
//         faceColor: json["face_color"],
//         shadeName: json["shade_name"],
//         directions: json["directions"],
//         brand: json["brand"],
//         volume: json["volume"],
//         status: json["status"],
//         visibility: json["visibility"],
//         taxClassId: json["tax_class_id"],
//         size: json["size"],
//         storeYear: json["store_year"],
//         faceSubArea: json["face_sub_area"],
//         drySkin: json["dry_skin"],
//         oilBased: json["oil_based"],
//         sensitiveSkin: json["sensitive_skin"],
//         matte: json["matte"],
//         radiant: json["radiant"],
//         shadeColor: json["shade_color"],
//         veganCrueltyFree: json["vegan_cruelty_free"],
//         tryOn: json["try_on"],
//         brandName: json["brand_name"],
//         price: json["price"],
//         description: json["description"],
//         shortDescription: json["short_description"],
//         ingredients: json["ingredients"],
//         dealFromDate: DateTime.parse(json["deal_from_date"]),
//         dealToDate: DateTime.parse(json["deal_to_date"]),
//         options: List<dynamic>.from(json["options"].map((x) => x)),
//         mediaGallery: IndigoMediaGallery.fromJson(json["media_gallery"]),
//         extensionAttributes:
//             ExtensionAttributes.fromJson(json["extension_attributes"]),
//         tierPrice: List<dynamic>.from(json["tier_price"].map((x) => x)),
//         tierPriceChanged: json["tier_price_changed"],
//         quantityAndStockStatus:
//             QuantityAndStockStatus.fromJson(json["quantity_and_stock_status"]),
//         categoryIds: List<String>.from(json["category_ids"].map((x) => x)),
//         isSalable: json["is_salable"],
//         requestPath: json["request_path"],
//         finalPrice: json["final_price"].toDouble(),
//         customer: Customer.fromJson(json["customer"]),
//         product: Customer.fromJson(json["product"]),
//         customerWarningFlag: json["customer_warning_flag"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "entity_id": entityId,
//         "attribute_set_id": attributeSetId,
//         "type_id": typeId,
//         "sku": sku,
//         "face_area": faceArea,
//         "has_options": hasOptions,
//         "required_options": requiredOptions,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "name": name,
//         "image": image,
//         "small_image": smallImage,
//         "thumbnail": thumbnail,
//         "options_container": optionsContainer,
//         "msrp_display_actual_price_type": msrpDisplayActualPriceType,
//         "url_key": urlKey,
//         "url_path": urlPath,
//         "face_color": faceColor,
//         "shade_name": shadeName,
//         "directions": directions,
//         "brand": brand,
//         "volume": volume,
//         "status": status,
//         "visibility": visibility,
//         "tax_class_id": taxClassId,
//         "size": size,
//         "store_year": storeYear,
//         "face_sub_area": faceSubArea,
//         "dry_skin": drySkin,
//         "oil_based": oilBased,
//         "sensitive_skin": sensitiveSkin,
//         "matte": matte,
//         "radiant": radiant,
//         "shade_color": shadeColor,
//         "vegan_cruelty_free": veganCrueltyFree,
//         "try_on": tryOn,
//         "brand_name": brandName,
//         "price": price,
//         "description": description,
//         "short_description": shortDescription,
//         "ingredients": ingredients,
//         "deal_from_date": dealFromDate?.toIso8601String(),
//         "deal_to_date": dealToDate?.toIso8601String(),
//         "options": List<dynamic>.from(options.map((x) => x)),
//         "media_gallery": mediaGallery?.toJson(),
//         "extension_attributes": extensionAttributes?.toJson(),
//         "tier_price": List<dynamic>.from(tierPrice.map((x) => x)),
//         "tier_price_changed": tierPriceChanged,
//         "quantity_and_stock_status": quantityAndStockStatus?.toJson(),
//         "category_ids": List<dynamic>.from(categoryIds.map((x) => x)),
//         "is_salable": isSalable,
//         "request_path": requestPath,
//         "final_price": finalPrice,
//         "customer": customer?.toJson(),
//         "product": product?.toJson(),
//         "customer_warning_flag": customerWarningFlag,
//       };
// }
//
// class IndigoMediaGallery {
//   IndigoMediaGallery({
//     this.images,
//     this.values = const [],
//   });
//
//   IndigoImages? images;
//   List<dynamic> values;
//
//   factory IndigoMediaGallery.fromJson(Map<String, dynamic> json) =>
//       IndigoMediaGallery(
//         images: IndigoImages.fromJson(json["images"]),
//         values: List<dynamic>.from(json["values"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "images": images?.toJson(),
//         "values": List<dynamic>.from(values.map((x) => x)),
//       };
// }
//
// class IndigoImages {
//   IndigoImages({
//     this.the4877,
//   });
//
//   The4429? the4877;
//
//   factory IndigoImages.fromJson(Map<String, dynamic> json) => IndigoImages(
//         the4877: The4429.fromJson(json["4877"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "4877": the4877?.toJson(),
//       };
// }
//
// class Lipliner {
//   Lipliner({
//     this.itemData,
//     this.recommendedColor = "",
//   });
//
//   LiplinerItemData? itemData;
//   String recommendedColor;
//
//   factory Lipliner.fromJson(Map<String, dynamic> json) => Lipliner(
//         itemData: LiplinerItemData.fromJson(json["item_data"]),
//         recommendedColor: json["recommended_color"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "item_data": itemData?.toJson(),
//         "recommended_color": recommendedColor,
//       };
// }
//
// class LiplinerItemData {
//   LiplinerItemData({
//     this.entityId = "",
//     this.attributeSetId = "",
//     this.typeId = "",
//     this.sku = "",
//     this.faceArea = "",
//     this.hasOptions = "",
//     this.requiredOptions = "",
//     this.createdAt,
//     this.updatedAt,
//     this.name = "",
//     this.image = "",
//     this.smallImage = "",
//     this.thumbnail = "",
//     this.optionsContainer = "",
//     this.msrpDisplayActualPriceType = "",
//     this.urlKey = "",
//     this.urlPath = "",
//     this.faceColor = "",
//     this.shadeName = "",
//     this.directions = "",
//     this.brand = "",
//     this.volume = "",
//     this.status = "",
//     this.visibility = "",
//     this.taxClassId = "",
//     this.size = "",
//     this.storeYear = "",
//     this.faceSubArea = "",
//     this.drySkin = "",
//     this.oilBased = "",
//     this.sensitiveSkin = "",
//     this.matte = "",
//     this.radiant = "",
//     this.shadeColor = "",
//     this.veganCrueltyFree = "",
//     this.tryOn = "",
//     this.brandName = "",
//     this.price = "",
//     this.description = "",
//     this.shortDescription = "",
//     this.ingredients = "",
//     this.dealFromDate,
//     this.dealToDate,
//     this.options = const [],
//     this.mediaGallery,
//     this.extensionAttributes,
//     this.tierPrice = const [],
//     this.tierPriceChanged = 0,
//     this.quantityAndStockStatus,
//     this.categoryIds = const [],
//     this.isSalable = 0,
//     this.requestPath = false,
//     this.finalPrice = 0,
//     this.customer,
//     this.product,
//     this.customerWarningFlag = "",
//   });
//
//   String entityId;
//   String attributeSetId;
//   String typeId;
//   String sku;
//   String faceArea;
//   String hasOptions;
//   String requiredOptions;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String name;
//   String image;
//   String smallImage;
//   String thumbnail;
//   String optionsContainer;
//   String msrpDisplayActualPriceType;
//   String urlKey;
//   String urlPath;
//   String faceColor;
//   String shadeName;
//   String directions;
//   String brand;
//   String volume;
//   String status;
//   String visibility;
//   String taxClassId;
//   String size;
//   String storeYear;
//   String faceSubArea;
//   String drySkin;
//   String oilBased;
//   String sensitiveSkin;
//   String matte;
//   String radiant;
//   String shadeColor;
//   String veganCrueltyFree;
//   String tryOn;
//   String brandName;
//   String price;
//   String description;
//   String shortDescription;
//   String ingredients;
//   DateTime? dealFromDate;
//   DateTime? dealToDate;
//   List<dynamic> options;
//   IndecentMediaGallery? mediaGallery;
//   ExtensionAttributes? extensionAttributes;
//   List<dynamic> tierPrice;
//   int tierPriceChanged;
//   QuantityAndStockStatus? quantityAndStockStatus;
//   List<String> categoryIds;
//   int isSalable;
//   bool requestPath;
//   int finalPrice;
//   Customer? customer;
//   Customer? product;
//   String customerWarningFlag;
//
//   factory LiplinerItemData.fromJson(Map<String, dynamic> json) =>
//       LiplinerItemData(
//         entityId: json["entity_id"],
//         attributeSetId: json["attribute_set_id"],
//         typeId: json["type_id"],
//         sku: json["sku"],
//         faceArea: json["face_area"],
//         hasOptions: json["has_options"],
//         requiredOptions: json["required_options"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         name: json["name"],
//         image: json["image"],
//         smallImage: json["small_image"],
//         thumbnail: json["thumbnail"],
//         optionsContainer: json["options_container"],
//         msrpDisplayActualPriceType: json["msrp_display_actual_price_type"],
//         urlKey: json["url_key"],
//         urlPath: json["url_path"],
//         faceColor: json["face_color"],
//         shadeName: json["shade_name"],
//         directions: json["directions"],
//         brand: json["brand"],
//         volume: json["volume"],
//         status: json["status"],
//         visibility: json["visibility"],
//         taxClassId: json["tax_class_id"],
//         size: json["size"],
//         storeYear: json["store_year"],
//         faceSubArea: json["face_sub_area"],
//         drySkin: json["dry_skin"],
//         oilBased: json["oil_based"],
//         sensitiveSkin: json["sensitive_skin"],
//         matte: json["matte"],
//         radiant: json["radiant"],
//         shadeColor: json["shade_color"],
//         veganCrueltyFree: json["vegan_cruelty_free"],
//         tryOn: json["try_on"],
//         brandName: json["brand_name"],
//         price: json["price"],
//         description: json["description"],
//         shortDescription: json["short_description"],
//         ingredients: json["ingredients"],
//         dealFromDate: DateTime.parse(json["deal_from_date"]),
//         dealToDate: DateTime.parse(json["deal_to_date"]),
//         options: List<dynamic>.from(json["options"].map((x) => x)),
//         mediaGallery: IndecentMediaGallery.fromJson(json["media_gallery"]),
//         extensionAttributes:
//             ExtensionAttributes.fromJson(json["extension_attributes"]),
//         tierPrice: List<dynamic>.from(json["tier_price"].map((x) => x)),
//         tierPriceChanged: json["tier_price_changed"],
//         quantityAndStockStatus:
//             QuantityAndStockStatus.fromJson(json["quantity_and_stock_status"]),
//         categoryIds: List<String>.from(json["category_ids"].map((x) => x)),
//         isSalable: json["is_salable"],
//         requestPath: json["request_path"],
//         finalPrice: json["final_price"],
//         customer: Customer.fromJson(json["customer"]),
//         product: Customer.fromJson(json["product"]),
//         customerWarningFlag: json["customer_warning_flag"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "entity_id": entityId,
//         "attribute_set_id": attributeSetId,
//         "type_id": typeId,
//         "sku": sku,
//         "face_area": faceArea,
//         "has_options": hasOptions,
//         "required_options": requiredOptions,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "name": name,
//         "image": image,
//         "small_image": smallImage,
//         "thumbnail": thumbnail,
//         "options_container": optionsContainer,
//         "msrp_display_actual_price_type": msrpDisplayActualPriceType,
//         "url_key": urlKey,
//         "url_path": urlPath,
//         "face_color": faceColor,
//         "shade_name": shadeName,
//         "directions": directions,
//         "brand": brand,
//         "volume": volume,
//         "status": status,
//         "visibility": visibility,
//         "tax_class_id": taxClassId,
//         "size": size,
//         "store_year": storeYear,
//         "face_sub_area": faceSubArea,
//         "dry_skin": drySkin,
//         "oil_based": oilBased,
//         "sensitive_skin": sensitiveSkin,
//         "matte": matte,
//         "radiant": radiant,
//         "shade_color": shadeColor,
//         "vegan_cruelty_free": veganCrueltyFree,
//         "try_on": tryOn,
//         "brand_name": brandName,
//         "price": price,
//         "description": description,
//         "short_description": shortDescription,
//         "ingredients": ingredients,
//         "deal_from_date": dealFromDate?.toIso8601String(),
//         "deal_to_date": dealToDate?.toIso8601String(),
//         "options": List<dynamic>.from(options.map((x) => x)),
//         "media_gallery": mediaGallery?.toJson(),
//         "extension_attributes": extensionAttributes?.toJson(),
//         "tier_price": List<dynamic>.from(tierPrice.map((x) => x)),
//         "tier_price_changed": tierPriceChanged,
//         "quantity_and_stock_status": quantityAndStockStatus?.toJson(),
//         "category_ids": List<dynamic>.from(categoryIds.map((x) => x)),
//         "is_salable": isSalable,
//         "request_path": requestPath,
//         "final_price": finalPrice,
//         "customer": customer?.toJson(),
//         "product": product?.toJson(),
//         "customer_warning_flag": customerWarningFlag,
//       };
// }
//
// class IndecentMediaGallery {
//   IndecentMediaGallery({
//     this.images,
//     this.values = const [],
//   });
//
//   IndecentImages? images;
//   List<dynamic> values;
//
//   factory IndecentMediaGallery.fromJson(Map<String, dynamic> json) =>
//       IndecentMediaGallery(
//         images: IndecentImages.fromJson(json["images"]),
//         values: List<dynamic>.from(json["values"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "images": images?.toJson(),
//         "values": List<dynamic>.from(values.map((x) => x)),
//       };
// }
//
// class IndecentImages {
//   IndecentImages({
//     this.the8831,
//   });
//
//   The4429? the8831;
//
//   factory IndecentImages.fromJson(Map<String, dynamic> json) => IndecentImages(
//         the8831: The4429.fromJson(json["8831"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "8831": the8831?.toJson(),
//       };
// }
//
// class Lipstick {
//   Lipstick({
//     this.itemData,
//     this.recommendedColor = "",
//   });
//
//   LipstickItemData? itemData;
//   String recommendedColor;
//
//   factory Lipstick.fromJson(Map<String, dynamic> json) => Lipstick(
//         itemData: LipstickItemData.fromJson(json["item_data"]),
//         recommendedColor: json["recommended_color"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "item_data": itemData?.toJson(),
//         "recommended_color": recommendedColor,
//       };
// }
//
// class LipstickItemData {
//   LipstickItemData({
//     this.entityId = "",
//     this.attributeSetId = "",
//     this.typeId = "",
//     this.sku = "",
//     this.faceArea = "",
//     this.hasOptions = "",
//     this.requiredOptions = "",
//     this.createdAt,
//     this.updatedAt,
//     this.name = "",
//     this.image = "",
//     this.smallImage = "",
//     this.thumbnail = "",
//     this.optionsContainer = "",
//     this.msrpDisplayActualPriceType = "",
//     this.urlKey = "",
//     this.urlPath = "",
//     this.faceColor = "",
//     this.shadeName = "",
//     this.directions = "",
//     this.brand = "",
//     this.volume,
//     this.status = "",
//     this.visibility = "",
//     this.taxClassId = "",
//     this.size = "",
//     this.storeYear = "",
//     this.faceSubArea = "",
//     this.drySkin = "",
//     this.oilBased = "",
//     this.sensitiveSkin = "",
//     this.matte = "",
//     this.radiant = "",
//     this.shadeColor = "",
//     this.veganCrueltyFree = "",
//     this.tryOn = "",
//     this.price = "",
//     this.description = "",
//     this.shortDescription = "",
//     this.ingredients = "",
//     this.dealFromDate,
//     this.dealToDate,
//     this.options = const [],
//     this.mediaGallery,
//     this.extensionAttributes,
//     this.tierPrice = const [],
//     this.tierPriceChanged = 0,
//     this.quantityAndStockStatus,
//     this.categoryIds = const [],
//     this.isSalable = 0,
//     this.requestPath = false,
//     this.finalPrice = 0,
//     this.customer,
//     this.product,
//     this.customerWarningFlag = "",
//   });
//
//   String entityId;
//   String attributeSetId;
//   String typeId;
//   String sku;
//   String faceArea;
//   String hasOptions;
//   String requiredOptions;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String name;
//   String image;
//   String smallImage;
//   String thumbnail;
//   String optionsContainer;
//   String msrpDisplayActualPriceType;
//   String urlKey;
//   String urlPath;
//   String faceColor;
//   String shadeName;
//   String directions;
//   String brand;
//   dynamic volume;
//   String status;
//   String visibility;
//   String taxClassId;
//   String size;
//   String storeYear;
//   String faceSubArea;
//   String drySkin;
//   String oilBased;
//   String sensitiveSkin;
//   String matte;
//   String radiant;
//   String shadeColor;
//   String veganCrueltyFree;
//   String tryOn;
//   String price;
//   String description;
//   String shortDescription;
//   String ingredients;
//   DateTime? dealFromDate;
//   DateTime? dealToDate;
//   List<dynamic> options;
//   HilariousMediaGallery? mediaGallery;
//   ExtensionAttributes? extensionAttributes;
//   List<dynamic> tierPrice;
//   int tierPriceChanged;
//   QuantityAndStockStatus? quantityAndStockStatus;
//   List<String> categoryIds;
//   int isSalable;
//   bool requestPath;
//   double finalPrice;
//   Customer? customer;
//   Customer? product;
//   String customerWarningFlag;
//
//   factory LipstickItemData.fromJson(Map<String, dynamic> json) =>
//       LipstickItemData(
//         entityId: json["entity_id"],
//         attributeSetId: json["attribute_set_id"],
//         typeId: json["type_id"],
//         sku: json["sku"],
//         faceArea: json["face_area"],
//         hasOptions: json["has_options"],
//         requiredOptions: json["required_options"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         name: json["name"],
//         image: json["image"],
//         smallImage: json["small_image"],
//         thumbnail: json["thumbnail"],
//         optionsContainer: json["options_container"],
//         msrpDisplayActualPriceType: json["msrp_display_actual_price_type"],
//         urlKey: json["url_key"],
//         urlPath: json["url_path"],
//         faceColor: json["face_color"],
//         shadeName: json["shade_name"],
//         directions: json["directions"],
//         brand: json["brand"],
//         volume: json["volume"],
//         status: json["status"],
//         visibility: json["visibility"],
//         taxClassId: json["tax_class_id"],
//         size: json["size"],
//         storeYear: json["store_year"],
//         faceSubArea: json["face_sub_area"],
//         drySkin: json["dry_skin"],
//         oilBased: json["oil_based"],
//         sensitiveSkin: json["sensitive_skin"],
//         matte: json["matte"],
//         radiant: json["radiant"],
//         shadeColor: json["shade_color"],
//         veganCrueltyFree: json["vegan_cruelty_free"],
//         tryOn: json["try_on"],
//         price: json["price"],
//         description: json["description"],
//         shortDescription: json["short_description"],
//         ingredients: json["ingredients"],
//         dealFromDate: DateTime.parse(json["deal_from_date"]),
//         dealToDate: DateTime.parse(json["deal_to_date"]),
//         options: List<dynamic>.from(json["options"].map((x) => x)),
//         mediaGallery: HilariousMediaGallery.fromJson(json["media_gallery"]),
//         extensionAttributes:
//             ExtensionAttributes.fromJson(json["extension_attributes"]),
//         tierPrice: List<dynamic>.from(json["tier_price"].map((x) => x)),
//         tierPriceChanged: json["tier_price_changed"],
//         quantityAndStockStatus:
//             QuantityAndStockStatus.fromJson(json["quantity_and_stock_status"]),
//         categoryIds: List<String>.from(json["category_ids"].map((x) => x)),
//         isSalable: json["is_salable"],
//         requestPath: json["request_path"],
//         finalPrice: json["final_price"].toDouble(),
//         customer: Customer.fromJson(json["customer"]),
//         product: Customer.fromJson(json["product"]),
//         customerWarningFlag: json["customer_warning_flag"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "entity_id": entityId,
//         "attribute_set_id": attributeSetId,
//         "type_id": typeId,
//         "sku": sku,
//         "face_area": faceArea,
//         "has_options": hasOptions,
//         "required_options": requiredOptions,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "name": name,
//         "image": image,
//         "small_image": smallImage,
//         "thumbnail": thumbnail,
//         "options_container": optionsContainer,
//         "msrp_display_actual_price_type": msrpDisplayActualPriceType,
//         "url_key": urlKey,
//         "url_path": urlPath,
//         "face_color": faceColor,
//         "shade_name": shadeName,
//         "directions": directions,
//         "brand": brand,
//         "volume": volume,
//         "status": status,
//         "visibility": visibility,
//         "tax_class_id": taxClassId,
//         "size": size,
//         "store_year": storeYear,
//         "face_sub_area": faceSubArea,
//         "dry_skin": drySkin,
//         "oil_based": oilBased,
//         "sensitive_skin": sensitiveSkin,
//         "matte": matte,
//         "radiant": radiant,
//         "shade_color": shadeColor,
//         "vegan_cruelty_free": veganCrueltyFree,
//         "try_on": tryOn,
//         "price": price,
//         "description": description,
//         "short_description": shortDescription,
//         "ingredients": ingredients,
//         "deal_from_date": dealFromDate?.toIso8601String(),
//         "deal_to_date": dealToDate?.toIso8601String(),
//         "options": List<dynamic>.from(options.map((x) => x)),
//         "media_gallery": mediaGallery?.toJson(),
//         "extension_attributes": extensionAttributes?.toJson(),
//         "tier_price": List<dynamic>.from(tierPrice.map((x) => x)),
//         "tier_price_changed": tierPriceChanged,
//         "quantity_and_stock_status": quantityAndStockStatus?.toJson(),
//         "category_ids": List<dynamic>.from(categoryIds.map((x) => x)),
//         "is_salable": isSalable,
//         "request_path": requestPath,
//         "final_price": finalPrice,
//         "customer": customer?.toJson(),
//         "product": product?.toJson(),
//         "customer_warning_flag": customerWarningFlag,
//       };
// }
//
// class HilariousMediaGallery {
//   HilariousMediaGallery({
//     this.images,
//     this.values = const [],
//   });
//
//   HilariousImages? images;
//   List<dynamic> values;
//
//   factory HilariousMediaGallery.fromJson(Map<String, dynamic> json) =>
//       HilariousMediaGallery(
//         images: HilariousImages.fromJson(json["images"]),
//         values: List<dynamic>.from(json["values"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "images": images?.toJson(),
//         "values": List<dynamic>.from(values.map((x) => x)),
//       };
// }
//
// class HilariousImages {
//   HilariousImages({
//     this.the33654,
//   });
//
//   The4429? the33654;
//
//   factory HilariousImages.fromJson(Map<String, dynamic> json) =>
//       HilariousImages(
//         the33654: The4429.fromJson(json["33654"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "33654": the33654?.toJson(),
//       };
// }
//
// class Mascaras {
//   Mascaras({
//     this.itemData,
//     this.recommendedColor = "",
//   });
//
//   MascarasItemData? itemData;
//   String recommendedColor;
//
//   factory Mascaras.fromJson(Map<String, dynamic> json) => Mascaras(
//         itemData: MascarasItemData.fromJson(json["item_data"]),
//         recommendedColor: json["recommended_color"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "item_data": itemData?.toJson(),
//         "recommended_color": recommendedColor,
//       };
// }
//
// class MascarasItemData {
//   MascarasItemData({
//     this.entityId = "",
//     this.attributeSetId = "",
//     this.typeId = "",
//     this.sku = "",
//     this.faceArea = "",
//     this.hasOptions = "",
//     this.requiredOptions = "",
//     this.createdAt,
//     this.updatedAt,
//     this.name = "",
//     this.image = "",
//     this.smallImage = "",
//     this.thumbnail = "",
//     this.optionsContainer = "",
//     this.msrpDisplayActualPriceType = "",
//     this.urlKey = "",
//     this.urlPath = "",
//     this.faceColor = "",
//     this.shadeName = "",
//     this.directions = "",
//     this.brand = "",
//     this.volume = "",
//     this.status = "",
//     this.visibility = "",
//     this.taxClassId = "",
//     this.size = "",
//     this.storeYear = "",
//     this.faceSubArea = "",
//     this.drySkin = "",
//     this.oilBased = "",
//     this.sensitiveSkin = "",
//     this.matte = "",
//     this.radiant = "",
//     this.shadeColor = "",
//     this.veganCrueltyFree = "",
//     this.tryOn = "",
//     this.brandName = "",
//     this.price = "",
//     this.description = "",
//     this.shortDescription = "",
//     this.ingredients = "",
//     this.dealFromDate,
//     this.dealToDate,
//     this.options = const [],
//     this.mediaGallery,
//     this.extensionAttributes,
//     this.tierPrice = const [],
//     this.tierPriceChanged = 0,
//     this.quantityAndStockStatus,
//     this.categoryIds = const [],
//     this.isSalable = 0,
//     this.requestPath = false,
//     this.finalPrice = 0,
//     this.customer,
//     this.product,
//     this.customerWarningFlag = "",
//   });
//
//   String entityId;
//   String attributeSetId;
//   String typeId;
//   String sku;
//   String faceArea;
//   String hasOptions;
//   String requiredOptions;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String name;
//   String image;
//   String smallImage;
//   String thumbnail;
//   String optionsContainer;
//   String msrpDisplayActualPriceType;
//   String urlKey;
//   String urlPath;
//   String faceColor;
//   String shadeName;
//   String directions;
//   String brand;
//   String volume;
//   String status;
//   String visibility;
//   String taxClassId;
//   String size;
//   String storeYear;
//   String faceSubArea;
//   String drySkin;
//   String oilBased;
//   String sensitiveSkin;
//   String matte;
//   String radiant;
//   String shadeColor;
//   String veganCrueltyFree;
//   String tryOn;
//   String brandName;
//   String price;
//   String description;
//   String shortDescription;
//   String ingredients;
//   DateTime? dealFromDate;
//   DateTime? dealToDate;
//   List<dynamic> options;
//   AmbitiousMediaGallery? mediaGallery;
//   ExtensionAttributes? extensionAttributes;
//   List<dynamic> tierPrice;
//   int tierPriceChanged;
//   QuantityAndStockStatus? quantityAndStockStatus;
//   List<String> categoryIds;
//   int isSalable;
//   bool requestPath;
//   double finalPrice;
//   Customer? customer;
//   Customer? product;
//   String customerWarningFlag;
//
//   factory MascarasItemData.fromJson(Map<String, dynamic> json) =>
//       MascarasItemData(
//         entityId: json["entity_id"],
//         attributeSetId: json["attribute_set_id"],
//         typeId: json["type_id"],
//         sku: json["sku"],
//         faceArea: json["face_area"],
//         hasOptions: json["has_options"],
//         requiredOptions: json["required_options"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         name: json["name"],
//         image: json["image"],
//         smallImage: json["small_image"],
//         thumbnail: json["thumbnail"],
//         optionsContainer: json["options_container"],
//         msrpDisplayActualPriceType: json["msrp_display_actual_price_type"],
//         urlKey: json["url_key"],
//         urlPath: json["url_path"],
//         faceColor: json["face_color"],
//         shadeName: json["shade_name"],
//         directions: json["directions"],
//         brand: json["brand"],
//         volume: json["volume"],
//         status: json["status"],
//         visibility: json["visibility"],
//         taxClassId: json["tax_class_id"],
//         size: json["size"],
//         storeYear: json["store_year"],
//         faceSubArea: json["face_sub_area"],
//         drySkin: json["dry_skin"],
//         oilBased: json["oil_based"],
//         sensitiveSkin: json["sensitive_skin"],
//         matte: json["matte"],
//         radiant: json["radiant"],
//         shadeColor: json["shade_color"],
//         veganCrueltyFree: json["vegan_cruelty_free"],
//         tryOn: json["try_on"],
//         brandName: json["brand_name"],
//         price: json["price"],
//         description: json["description"],
//         shortDescription: json["short_description"],
//         ingredients: json["ingredients"],
//         dealFromDate: DateTime.parse(json["deal_from_date"]),
//         dealToDate: DateTime.parse(json["deal_to_date"]),
//         options: List<dynamic>.from(json["options"].map((x) => x)),
//         mediaGallery: AmbitiousMediaGallery.fromJson(json["media_gallery"]),
//         extensionAttributes:
//             ExtensionAttributes.fromJson(json["extension_attributes"]),
//         tierPrice: List<dynamic>.from(json["tier_price"].map((x) => x)),
//         tierPriceChanged: json["tier_price_changed"],
//         quantityAndStockStatus:
//             QuantityAndStockStatus.fromJson(json["quantity_and_stock_status"]),
//         categoryIds: List<String>.from(json["category_ids"].map((x) => x)),
//         isSalable: json["is_salable"],
//         requestPath: json["request_path"],
//         finalPrice: json["final_price"].toDouble(),
//         customer: Customer.fromJson(json["customer"]),
//         product: Customer.fromJson(json["product"]),
//         customerWarningFlag: json["customer_warning_flag"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "entity_id": entityId,
//         "attribute_set_id": attributeSetId,
//         "type_id": typeId,
//         "sku": sku,
//         "face_area": faceArea,
//         "has_options": hasOptions,
//         "required_options": requiredOptions,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "name": name,
//         "image": image,
//         "small_image": smallImage,
//         "thumbnail": thumbnail,
//         "options_container": optionsContainer,
//         "msrp_display_actual_price_type": msrpDisplayActualPriceType,
//         "url_key": urlKey,
//         "url_path": urlPath,
//         "face_color": faceColor,
//         "shade_name": shadeName,
//         "directions": directions,
//         "brand": brand,
//         "volume": volume,
//         "status": status,
//         "visibility": visibility,
//         "tax_class_id": taxClassId,
//         "size": size,
//         "store_year": storeYear,
//         "face_sub_area": faceSubArea,
//         "dry_skin": drySkin,
//         "oil_based": oilBased,
//         "sensitive_skin": sensitiveSkin,
//         "matte": matte,
//         "radiant": radiant,
//         "shade_color": shadeColor,
//         "vegan_cruelty_free": veganCrueltyFree,
//         "try_on": tryOn,
//         "brand_name": brandName,
//         "price": price,
//         "description": description,
//         "short_description": shortDescription,
//         "ingredients": ingredients,
//         "deal_from_date": dealFromDate?.toIso8601String(),
//         "deal_to_date": dealToDate?.toIso8601String(),
//         "options": List<dynamic>.from(options.map((x) => x)),
//         "media_gallery": mediaGallery?.toJson(),
//         "extension_attributes": extensionAttributes?.toJson(),
//         "tier_price": List<dynamic>.from(tierPrice.map((x) => x)),
//         "tier_price_changed": tierPriceChanged,
//         "quantity_and_stock_status": quantityAndStockStatus?.toJson(),
//         "category_ids": List<dynamic>.from(categoryIds.map((x) => x)),
//         "is_salable": isSalable,
//         "request_path": requestPath,
//         "final_price": finalPrice,
//         "customer": customer?.toJson(),
//         "product": product?.toJson(),
//         "customer_warning_flag": customerWarningFlag,
//       };
// }
//
// class AmbitiousMediaGallery {
//   AmbitiousMediaGallery({
//     this.images,
//     this.values = const [],
//   });
//
//   AmbitiousImages? images;
//   List<dynamic> values;
//
//   factory AmbitiousMediaGallery.fromJson(Map<String, dynamic> json) =>
//       AmbitiousMediaGallery(
//         images: AmbitiousImages.fromJson(json["images"]),
//         values: List<dynamic>.from(json["values"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "images": images?.toJson(),
//         "values": List<dynamic>.from(values.map((x) => x)),
//       };
// }
//
// class AmbitiousImages {
//   AmbitiousImages({
//     this.the7222,
//   });
//
//   The4429? the7222;
//
//   factory AmbitiousImages.fromJson(Map<String, dynamic> json) =>
//       AmbitiousImages(
//         the7222: The4429.fromJson(json["7222"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "7222": the7222?.toJson(),
//       };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//
//   Map<T, String> reverseMap = {};
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
