class RecentItemModel {
  Data? data;
  String? status;

  RecentItemModel({this.data, this.status});

  RecentItemModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? totalCount;
  int? pageSize;
  int? currentpage;
  List<Items>? items;

  Data({this.totalCount, this.pageSize, this.currentpage, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    pageSize = json['page_size'];
    currentpage = json['currentpage'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    data['page_size'] = this.pageSize;
    data['currentpage'] = this.currentpage;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? sku;
  String? name;
  String? price;
  String? status;
  String? typeId;
  String? brand;
  String? scanColour;
  String? image;
  String? urlKey;
  String? shortDescription;
  String? shadeColor;
  String? smallImage;
  String? optionsContainer;
  String? description;
  String? volume;
  String? thumbnail;
  String? shadeName;
  String? faceColor;
  String? dealFromDate;
  String? taxClassId;
  String? directions;
  String? dealToDate;
  String? ingredients;
  String? msrpDisplayActualPriceType;
  String? storeYear;
  String? drySkin;
  String? oilBased;
  List<String>? categoryIds;
  String? sensitiveSkin;
  String? matte;
  String? radiant;
  String? faceArea;
  String? requiredOptions;
  String? hasOptions;
  String? faceSubArea;
  String? size;
  String? giftMessageAvailable;
  String? dealStatus;
  String? dealDiscountType;
  String? smFeatured;

  Items(
      {this.id,
      this.sku,
      this.name,
      this.price,
      this.status,
      this.typeId,
      this.brand,
      this.scanColour,
      this.image,
      this.urlKey,
      this.shortDescription,
      this.shadeColor,
      this.smallImage,
      this.optionsContainer,
      this.description,
      this.volume,
      this.thumbnail,
      this.shadeName,
      this.faceColor,
      this.dealFromDate,
      this.taxClassId,
      this.directions,
      this.dealToDate,
      this.ingredients,
      this.msrpDisplayActualPriceType,
      this.storeYear,
      this.drySkin,
      this.oilBased,
      this.categoryIds,
      this.sensitiveSkin,
      this.matte,
      this.radiant,
      this.faceArea,
      this.requiredOptions,
      this.hasOptions,
      this.faceSubArea,
      this.size,
      this.giftMessageAvailable,
      this.dealStatus,
      this.dealDiscountType,
      this.smFeatured});


  //null values not handled... changed by Ashwani on 13-04-2022
  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? '' : json['id'];
    sku = json['sku'] == null ? '' : json['sku'];
    name = json['name'] == null ? '' : json['name'];
    price = json['price'] == null ? '' : json['price'];
    status = json['status'] == null ? '' : json['status'];
    typeId = json['type_id'] == null ? '' : json['type_id'];
    brand = json['brand'] == null ? '' : json['brand'];
    scanColour = json['scan_colour'] == null ? '' : json['scan_colour'];
    image = json['image'] == null ? '' : json['image'];
    urlKey = json['url_key'] == null ? '' : json['url_key'];
    shortDescription = json['short_description'] == null ? '' : json['short_description'];
    shadeColor = json['shade_color'] == null ? '' : json['shade_color'];
    smallImage = json['small_image'] == null ? '' : json['small_image'];
    optionsContainer = json['options_container'] == null ? '' : json['options_container'];
    description = json['description'] == null ? '' : json['description'];
    volume = json['volume'] == null ? '' : json['volume'];
    thumbnail = json['thumbnail'] == null ? '' : json['thumbnail'];
    shadeName = json['shade_name'] == null ? '' : json['shade_name'];
    faceColor = json['face_color'] == null ? '' : json['face_color'];
    dealFromDate = json['deal_from_date'] == null ? '' : json['deal_from_date'];
    taxClassId = json['tax_class_id'] == null ? '' : json['tax_class_id'];
    directions = json['directions'] == null ? '' : json['directions'];
    dealToDate = json['deal_to_date'] == null ? '' : json['deal_to_date'];
    ingredients = json['ingredients'] == null ? '' : json['ingredients'];
    msrpDisplayActualPriceType = json['msrp_display_actual_price_type'] == null ? '' : json['msrp_display_actual_price_type'];
    storeYear = json['store_year'] == null ? '' : json['store_year'];
    drySkin = json['dry_skin'] == null ? '' : json['dry_skin'];
    oilBased = json['oil_based'] == null ? '' : json['oil_based'];
    categoryIds = json['category_ids'] == null ? <String>[] : json['category_ids'].cast<String>();
    sensitiveSkin = json['sensitive_skin'] == null ? '' : json['sensitive_skin'];
    matte = json['matte'] == null ? '' : json['matte'];
    radiant = json['radiant'] == null ? '' : json['radiant'];
    faceArea = json['face_area'] == null ? '' : json['face_area'];
    requiredOptions = json['required_options'] == null ? '' : json['required_options'];
    hasOptions = json['has_options'] == null ? '' : json['has_options'];
    faceSubArea = json['face_sub_area'] == null ? '' : json['face_sub_area'];
    size = json['size'] == null ? '' : json['size'];
    giftMessageAvailable = json['gift_message_available'] == null ? '' : json['gift_message_available'];
    dealStatus = json['deal_status'] == null ? '' : json['deal_status'];
    dealDiscountType = json['deal_discount_type'] == null ? '' : json['deal_discount_type'];
    smFeatured = json['sm_featured'] == null ? '' : json['sm_featured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['price'] = this.price;
    data['status'] = this.status;
    data['type_id'] = this.typeId;
    data['brand'] = this.brand;
    data['scan_colour'] = this.scanColour;
    data['image'] = this.image;
    data['url_key'] = this.urlKey;
    data['short_description'] = this.shortDescription;
    data['shade_color'] = this.shadeColor;
    data['small_image'] = this.smallImage;
    data['options_container'] = this.optionsContainer;
    data['description'] = this.description;
    data['volume'] = this.volume;
    data['thumbnail'] = this.thumbnail;
    data['shade_name'] = this.shadeName;
    data['face_color'] = this.faceColor;
    data['deal_from_date'] = this.dealFromDate;
    data['tax_class_id'] = this.taxClassId;
    data['directions'] = this.directions;
    data['deal_to_date'] = this.dealToDate;
    data['ingredients'] = this.ingredients;
    data['msrp_display_actual_price_type'] = this.msrpDisplayActualPriceType;
    data['store_year'] = this.storeYear;
    data['dry_skin'] = this.drySkin;
    data['oil_based'] = this.oilBased;
    data['category_ids'] = this.categoryIds;
    data['sensitive_skin'] = this.sensitiveSkin;
    data['matte'] = this.matte;
    data['radiant'] = this.radiant;
    data['face_area'] = this.faceArea;
    data['required_options'] = this.requiredOptions;
    data['has_options'] = this.hasOptions;
    data['face_sub_area'] = this.faceSubArea;
    data['size'] = this.size;
    data['gift_message_available'] = this.giftMessageAvailable;
    data['deal_status'] = this.dealStatus;
    data['deal_discount_type'] = this.dealDiscountType;
    data['sm_featured'] = this.smFeatured;
    return data;
  }
}
