class SelectedProduct {
	List<Items>? items;
	var searchCriteria;
	var totalCount;

	SelectedProduct({this.items, this.searchCriteria, this.totalCount});

	SelectedProduct.fromJson(Map<String, dynamic> json) {
		if (json['items'] != null) {
			items = <Items>[];
			json['items'].forEach((v) { items!.add(new Items.fromJson(v)); });
		}
		searchCriteria = json['search_criteria'];
		totalCount = json['total_count'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.items != null) {
			data['items'] = this.items!.map((v) => v.toJson()).toList();
		}
		data['search_criteria'] = this.searchCriteria;
		data['total_count'] = this.totalCount;
		return data;
	}
}

class Items {
	String?entityId;
	String?customerId;
	String?faceSubArea;
	String?shadeColour;
	ProductSelected? product;

	Items({this.entityId, this.customerId, this.faceSubArea, this.shadeColour, this.product});

	Items.fromJson(Map<String, dynamic> json) {
		entityId = json['entity_id'];
		customerId = json['customer_id'];
		faceSubArea = json['FaceSubArea'];
		shadeColour = json['ShadeColour'];
		product = json['product'] != null ? new ProductSelected.fromJson(json['product']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['entity_id'] = this.entityId;
		data['customer_id'] = this.customerId;
		data['FaceSubArea'] = this.faceSubArea;
		data['ShadeColour'] = this.shadeColour;

		return data;
	}
}

class ProductSelected {
	String?entityId;
	String?attributeSetId;
	String?typeId;
	String?sku;
	String?hasOptions;
	String?requiredOptions;
	String?createdAt;
	String?updatedAt;
	String?name;
	String?image;
	String?smallImage;
	String?thumbnail;
	String?optionsContainer;
	String?msrpDisplayActualPriceType;
	String?urlKey;
	String?faceColor;
	String?shadeName;
	String?directions;
	String?brand;
	String?volume;
	String?price;
	String? specialPrice;
	String?description;
	String?shortDescription;
	String?ingredients;
	String?status;
	String?visibility;
	String?taxClassId;
	String?size;
	String?storeYear;
	String?faceArea;
	String?faceSubArea;
	String?drySkin;
	String?oilBased;
	String?sensitiveSkin;
	String?matte;
	String?radiant;
	String?shadeColor;
	String?dealFromDate;
	String?dealToDate;

  String? avgrating;
  String? productUrl;
  String? rewardPoints;
  String? reviewCount;
	var options;
	MediaGallery? mediaGallery;
	var extensionAttributes;
	var tierPrice;
	int? tierPriceChanged;
	QuantityAndStockStatus? quantityAndStockStatus;
	List<String>? categoryIds;
	int? isSalable;
	bool? isWished;
	String? urlPath;

	ProductSelected({this.entityId, this.rewardPoints,this.reviewCount, this.attributeSetId, this.typeId, this.sku, this.hasOptions, this.requiredOptions, this.createdAt, this.updatedAt, this.name, this.image, this.smallImage, this.thumbnail, this.optionsContainer, this.msrpDisplayActualPriceType, this.urlKey, this.faceColor, this.shadeName, this.directions, this.brand, this.volume, this.price,this.specialPrice, this.description, this.shortDescription, this.ingredients, this.status, this.visibility, this.taxClassId, this.size, this.storeYear, this.faceArea, this.faceSubArea, this.drySkin, this.oilBased, this.sensitiveSkin, this.matte, this.radiant, this.shadeColor, this.dealFromDate, this.dealToDate, this.options, this.mediaGallery, this.extensionAttributes, this.tierPrice, this.tierPriceChanged, this.quantityAndStockStatus, this.categoryIds, this.isSalable,this.isWished, this.urlPath,this.productUrl});

	ProductSelected.fromJson(Map<String, dynamic> json) {
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
		faceColor = json['face_color'];
		shadeName = json['shade_name'];
		directions = json['directions'];
		brand = json['brand'];
		volume = json['volume'];
		price = json['price'];
		productUrl=json['product_url'];
		rewardPoints=json['reward_points'].toString();
		reviewCount=json['review_count'].toString();

		try{
			specialPrice = (json['special_price']==null)?"":json['special_price'];
		}catch(e){
			specialPrice = "";
		}
		description = json['description'];
		shortDescription = json['short_description'];
		ingredients = json['ingredients'];
		status = json['status'];
		visibility = json['visibility'];
		taxClassId = json['tax_class_id'];
		size = json['size'];
		storeYear = json['store_year'];
		faceArea = json['face_area'];
		faceSubArea = json['face_sub_area'];
		drySkin = json['dry_skin'];
		oilBased = json['oil_based'];
		sensitiveSkin = json['sensitive_skin'];
		matte = json['matte'];
		radiant = json['radiant'];
		shadeColor = json['shade_color'];
		dealFromDate = json['deal_from_date'];
		dealToDate = json['deal_to_date'];
		avgrating=json['avgrating'].toString();
		if (json['options'] != null) {
			options = json['options'];

		}
		mediaGallery = json['media_gallery'] != null ? new MediaGallery.fromJson(json['media_gallery']) : null;
		extensionAttributes = json['extension_attributes'] != null ? json['extension_attributes']: null;
		if (json['tier_price'] != null) {
			tierPrice = json['tier_price'];

		}
		tierPriceChanged = json['tier_price_changed'];
		quantityAndStockStatus = json['quantity_and_stock_status'] != null ? new QuantityAndStockStatus.fromJson(json['quantity_and_stock_status']) : null;
		categoryIds = json['category_ids'].cast<String>();
		isSalable = json['is_salable'];
		isWished = json['is_in_wishlist'];
		urlPath = json['url_path'];
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
		data['face_color'] = this.faceColor;
		data['shade_name'] = this.shadeName;
		data['directions'] = this.directions;
		data['brand'] = this.brand;
		data['volume'] = this.volume;
		data['price'] = this.price;
		data['description'] = this.description;
		data['short_description'] = this.shortDescription;
		data['ingredients'] = this.ingredients;
		data['status'] = this.status;
		data['visibility'] = this.visibility;
		data['tax_class_id'] = this.taxClassId;
		data['size'] = this.size;
		data['store_year'] = this.storeYear;
		data['face_area'] = this.faceArea;
		data['face_sub_area'] = this.faceSubArea;
		data['dry_skin'] = this.drySkin;
		data['oil_based'] = this.oilBased;
		data['sensitive_skin'] = this.sensitiveSkin;
		data['matte'] = this.matte;
		data['radiant'] = this.radiant;
		data['shade_color'] = this.shadeColor;
		data['deal_from_date'] = this.dealFromDate;
		data['deal_to_date'] = this.dealToDate;
		if (this.options != null) {
			data['options'] = this.options.map((v) => v.toJson()).toList();
		}
		if (this.mediaGallery != null) {
			data['media_gallery'] = this.mediaGallery!.toJson();
		}
		if (this.extensionAttributes != null) {
			data['extension_attributes'] = this.extensionAttributes.toJson();
		}
		if (this.tierPrice != null) {
			data['tier_price'] = this.tierPrice.map((v) => v.toJson()).toList();
		}
		data['tier_price_changed'] = this.tierPriceChanged;
		if (this.quantityAndStockStatus != null) {
			data['quantity_and_stock_status'] = this.quantityAndStockStatus!.toJson();
		}
		data['category_ids'] = this.categoryIds;
		data['is_salable'] = this.isSalable;
		data['url_path'] = this.urlPath;
		return data;
	}
}



class MediaGallery {
	var images;
	var values;

	MediaGallery({this.images, this.values});

	MediaGallery.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? json['images']: null;
		if (json['values'] != null) {
			values = json['values'];
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.images != null) {
			data['images'] = this.images!.toJson();
		}
		if (this.values != null) {
			data['values'] = this.values.map((v) => v.toJson()).toList();
		}
		return data;
	}
}


class QuantityAndStockStatus {
	bool? isInStock;
	int? qty;

	QuantityAndStockStatus({this.isInStock, this.qty});

	QuantityAndStockStatus.fromJson(Map<String, dynamic> json) {
		isInStock = json['is_in_stock'];
		qty = json['qty'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['is_in_stock'] = this.isInStock;
		data['qty'] = this.qty;
		return data;
	}
}

// class Product{
// 	String? entityId;
// 	String? attributeSetId;
// 	String? typeId;
// 	String? sku;
// 	String? hasOptions;
// 	String? requiredOptions;
// 	String? createdAt;
// 	String? updatedAt;
// 	String? name;
// 	String? image;
// 	String? smallImage;
// 	String? thumbnail;
// 	String? optionsContainer;
// 	String? msrpDisplayActualPriceType;
// 	String? urlKey;
// 	String? faceColor;
// 	String? shadeName;
// 	String? directions;
// 	String? brand;
// 	String? volume;
// 	String? price;
// 	String? description;
// 	String? shortDescription;
// 	String? ingredients;
// 	String? status;
// 	String? visibility;
// 	String? taxClassId;
// 	String? size;
// 	String? storeYear;
// 	String? faceArea;
// 	String? faceSubArea;
// 	String? drySkin;
// 	String? oilBased;
// 	String? sensitiveSkin;
// 	String? matte;
// 	String? radiant;
// 	String? shadeColor;
// 	String? dealFromDate;
// 	String? dealToDate;
//   var options;
// 	MediaGallery? mediaGallery;
// 	var extensionAttributes;
// 	var tierPrice;
// 	int? tierPriceChanged;
// 	QuantityAndStockStatus? quantityAndStockStatus;
// 	List<String>? categoryIds;
// 	int? isSalable;
// 	String? urlPath;

// 	Product({this.entityId, this.attributeSetId, this.typeId, this.sku, this.hasOptions, this.requiredOptions, this.createdAt, this.updatedAt, this.name, this.image, this.smallImage, this.thumbnail, this.optionsContainer, this.msrpDisplayActualPriceType, this.urlKey, this.faceColor, this.shadeName, this.directions, this.brand, this.volume, this.price, this.description, this.shortDescription, this.ingredients, this.status, this.visibility, this.taxClassId, this.size, this.storeYear, this.faceArea, this.faceSubArea, this.drySkin, this.oilBased, this.sensitiveSkin, this.matte, this.radiant, this.shadeColor, this.dealFromDate, this.dealToDate, this.options, this.mediaGallery, this.extensionAttributes, this.tierPrice, this.tierPriceChanged, this.quantityAndStockStatus, this.categoryIds, this.isSalable, this.urlPath});

// 	Product.fromJson(Map<String, dynamic> json) {
// 		entityId = json['entity_id'];
// 		attributeSetId = json['attribute_set_id'];
// 		typeId = json['type_id'];
// 		sku = json['sku'];
// 		hasOptions = json['has_options'];
// 		requiredOptions = json['required_options'];
// 		createdAt = json['created_at'];
// 		updatedAt = json['updated_at'];
// 		name = json['name'];
// 		image = json['image'];
// 		smallImage = json['small_image'];
// 		thumbnail = json['thumbnail'];
// 		optionsContainer = json['options_container'];
// 		msrpDisplayActualPriceType = json['msrp_display_actual_price_type'];
// 		urlKey = json['url_key'];
// 		faceColor = json['face_color'];
// 		shadeName = json['shade_name'];
// 		directions = json['directions'];
// 		brand = json['brand'];
// 		volume = json['volume'];
// 		price = json['price'];
// 		description = json['description'];
// 		shortDescription = json['short_description'];
// 		ingredients = json['ingredients'];
// 		status = json['status'];
// 		visibility = json['visibility'];
// 		taxClassId = json['tax_class_id'];
// 		size = json['size'];
// 		storeYear = json['store_year'];
// 		faceArea = json['face_area'];
// 		faceSubArea = json['face_sub_area'];
// 		drySkin = json['dry_skin'];
// 		oilBased = json['oil_based'];
// 		sensitiveSkin = json['sensitive_skin'];
// 		matte = json['matte'];
// 		radiant = json['radiant'];
// 		shadeColor = json['shade_color'];
// 		dealFromDate = json['deal_from_date'];
// 		dealToDate = json['deal_to_date'];
// 		if (json['options'] != null) {
// 			options = 	json['options'];

// 		}
// 		mediaGallery = json['media_gallery'] != null ? new MediaGallery.fromJson(json['media_gallery']) : null;
// 		extensionAttributes = json['extension_attributes'] != null ? json['extension_attributes']: null;
// 		if (json['tier_price'] != null) {
// 			tierPrice = json['tier_price'];
// 		}
// 		tierPriceChanged = json['tier_price_changed'];
// 		quantityAndStockStatus = json['quantity_and_stock_status'] != null ? new QuantityAndStockStatus.fromJson(json['quantity_and_stock_status']) : null;
// 		categoryIds = json['category_ids'].cast<String>();
// 		isSalable = json['is_salable'];
// 		urlPath = json['url_path'];
// 	}


// }


