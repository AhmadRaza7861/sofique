class WishlistModel {
  bool? status;
  String? message;
  String? code;
  List<Result>? result;

  WishlistModel({this.status, this.message, this.code, this.result});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? wishlistItemId;
  String? wishlistId;
  String? productId;
  String? storeId;
  String? addedAt;
  var description;
  int? qty;
  Product? product;
  List<Ratings>? review;

  Result(
      {this.wishlistItemId,
      this.wishlistId,
      this.productId,
      this.storeId,
      this.addedAt,
      this.description,
      this.qty,
      this.product,
      this.review});

  Result.fromJson(Map<String, dynamic> json) {
    wishlistItemId = json['wishlist_item_id'];
    wishlistId = json['wishlist_id'];
    productId = json['product_id'];
    storeId = json['store_id'];
    addedAt = json['added_at'];
    description = json['description'];
    qty = json['qty'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['ratings'] != null) {
      review = <Ratings>[];
      json['ratings'].forEach((v) {
        review!.add(new Ratings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wishlist_item_id'] = this.wishlistItemId;
    data['wishlist_id'] = this.wishlistId;
    data['product_id'] = this.productId;
    data['store_id'] = this.storeId;
    data['added_at'] = this.addedAt;
    data['description'] = this.description;
    data['qty'] = this.qty;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? entityId;
  String? attributeSetId;
  String? typeId;
  String? sku;
  String? hasOptions;
  String? requiredOptions;
  String? createdAt;
  String? updatedAt;
  String? price;
  String? taxClassId;
  var finalPrice;
  String? minimalPrice;
  String? minPrice;
  String? maxPrice;
  var tierPrice;
  String? name;
  String? image;
  String? smallImage;
  String? thumbnail;
  String? msrpDisplayActualPriceType;
  String? urlKey;
  String? urlPath;
  String? brand;
  String? volume;
  String? shortDescription;
  String? dealFromDate;
  String? dealToDate;
  String? status;
  String? visibility;
  String? size;
  String? storeYear;
  int? storeId;
  var options;
  String? requestPath;
  var imageLabel;
  var smallImageLabel;
  var thumbnailLabel;
  String? shadeColor;

  Product(
      {this.entityId,
      this.attributeSetId,
      this.typeId,
      this.sku,
      this.hasOptions,
      this.requiredOptions,
      this.createdAt,
      this.updatedAt,
      this.price,
      this.taxClassId,
      this.finalPrice,
      this.minimalPrice,
      this.minPrice,
      this.maxPrice,
      this.tierPrice,
      this.name,
      this.image,
      this.smallImage,
      this.thumbnail,
      this.msrpDisplayActualPriceType,
      this.urlKey,
      this.urlPath,
      this.brand,
      this.volume,
      this.shortDescription,
      this.dealFromDate,
      this.dealToDate,
      this.status,
      this.visibility,
      this.size,
      this.storeYear,
      this.storeId,
      this.options,
      this.requestPath,
      this.imageLabel,
      this.smallImageLabel,
      this.thumbnailLabel,
      this.shadeColor});

  Product.fromJson(Map<String, dynamic> json) {
    entityId = json['entity_id'];
    attributeSetId = json['attribute_set_id'];
    typeId = json['type_id'];
    sku = json['sku'];
    hasOptions = json['has_options'];
    requiredOptions = json['required_options'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    taxClassId = json['tax_class_id'];
    finalPrice = json['final_price'];
    minimalPrice = json['minimal_price'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    tierPrice = json['tier_price'];
    name = json['name'];
    image = json['image'];
    smallImage = json['small_image'];
    thumbnail = json['thumbnail'];
    msrpDisplayActualPriceType = json['msrp_display_actual_price_type'];
    urlKey = json['url_key'];
    urlPath = json['url_path'];
    brand = json['brand'];
    volume = json['volume'];
    shortDescription = json['short_description'];
    dealFromDate = json['deal_from_date'];
    dealToDate = json['deal_to_date'];
    status = json['status'];
    visibility = json['visibility'];
    size = json['size'];
    storeYear = json['store_year'];
    storeId = json['store_id'];
    if (json['options'] != null) {
      options = json['options'];
    }
    requestPath = json['request_path'];
    imageLabel = json['image_label'];
    smallImageLabel = json['small_image_label'];
    thumbnailLabel = json['thumbnail_label'];
    shadeColor = json['shade_color'];
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
    data['price'] = this.price;
    data['tax_class_id'] = this.taxClassId;
    data['final_price'] = this.finalPrice;
    data['minimal_price'] = this.minimalPrice;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['tier_price'] = this.tierPrice;
    data['name'] = this.name;
    data['image'] = this.image;
    data['small_image'] = this.smallImage;
    data['thumbnail'] = this.thumbnail;
    data['msrp_display_actual_price_type'] = this.msrpDisplayActualPriceType;
    data['url_key'] = this.urlKey;
    data['url_path'] = this.urlPath;
    data['brand'] = this.brand;
    data['volume'] = this.volume;
    data['short_description'] = this.shortDescription;
    data['deal_from_date'] = this.dealFromDate;
    data['deal_to_date'] = this.dealToDate;
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['size'] = this.size;
    data['store_year'] = this.storeYear;
    data['store_id'] = this.storeId;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    data['request_path'] = this.requestPath;
    data['image_label'] = this.imageLabel;
    data['small_image_label'] = this.smallImageLabel;
    data['thumbnail_label'] = this.thumbnailLabel;
    data['shade_color'] = this.shadeColor;
    return data;
  }
}

class Ratings {
  int? voteId;
  int? ratingId;
  String? ratingName;
  int? percent;
  int? value;

  Ratings(
      {this.voteId, this.ratingId, this.ratingName, this.percent, this.value});

  Ratings.fromJson(Map<String, dynamic> json) {
    voteId = json['vote_id'];
    ratingId = json['rating_id'];
    ratingName = json['rating_name'];
    percent = json['percent'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_id'] = this.voteId;
    data['rating_id'] = this.ratingId;
    data['rating_name'] = this.ratingName;
    data['percent'] = this.percent;
    data['value'] = this.value;
    return data;
  }
}
