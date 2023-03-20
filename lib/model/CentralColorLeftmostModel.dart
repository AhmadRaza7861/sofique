class CentralColorLeftmost {
	String? faceArea;
	String? faceSubArea;
	List<CentralColours>? centralColours;
	String? subareaLeftmostCentralColour;
	List<FaceSubareaLeftmostListOfProducts>? faceSubareaLeftmostListOfProducts;

	CentralColorLeftmost({this.faceArea, this.faceSubArea, this.centralColours, this.subareaLeftmostCentralColour, this.faceSubareaLeftmostListOfProducts});

	CentralColorLeftmost.fromJson(Map<String, dynamic> json) {
        List<FaceSubareaLeftmostListOfProducts> temp=[];
    if (json['Face_subarea_leftmost_list_of_products'].length > 0) {
  json['Face_subarea_leftmost_list_of_products'].forEach((key, value) {
    temp.add(FaceSubareaLeftmostListOfProducts.fromJson(value,key,json['Face_sub_area']));
    });
    }
		faceArea = json['Face_area'];
		faceSubArea = json['Face_sub_area'];
		if (json['central_colours'].length > 0) {
			centralColours = <CentralColours>[];
			json['central_colours'].forEach((v) { centralColours!.add(new CentralColours.fromJson(v)); });
		}
		subareaLeftmostCentralColour = json['Subarea_leftmost_central_colour'];
		faceSubareaLeftmostListOfProducts = temp;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Face_area'] = this.faceArea;
		data['Face_sub_area'] = this.faceSubArea;
		if (this.centralColours != null) {
      data['central_colours'] = this.centralColours!.map((v) => v.toJson()).toList();
    }
		data['Subarea_leftmost_central_colour'] = this.subareaLeftmostCentralColour;
		if (this.faceSubareaLeftmostListOfProducts != null) {
      data['Face_subarea_leftmost_list_of_products'] = faceSubareaLeftmostListOfProducts == null
            ? null
            : List<dynamic>.from(faceSubareaLeftmostListOfProducts!.map((x) => x.toJson()));
    }
		return data;
	}
}

class CentralColours {
	String? colourAltName;
	String? colourAltHEX;

	CentralColours({this.colourAltName, this.colourAltHEX});

	CentralColours.fromJson(Map<String, dynamic> json) {
		colourAltName = json['ColourAltName'];
		colourAltHEX = json['ColourAltHEX'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ColourAltName'] = this.colourAltName;
		data['ColourAltHEX'] = this.colourAltHEX;
		return data;
	}
}


class FaceSubareaLeftmostListOfProducts {
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
	String? faceArea;
	String? faceSubArea;
	String? faceSubAreaName;
	String? drySkin;
	String? oilBased;
	String? sensitiveSkin;
	String? matte;
	String? radiant;
	String? shadeColor;
	String? veganCrueltyFree;
	String? tryOn;
	String? brandName;
	String? price;
	String? dealFromDate;
	String? dealToDate;
	String? description;
	String? shortDescription;
	String? ingredients;
	int? storeId;
  String? key;

	FaceSubareaLeftmostListOfProducts({this.entityId, this.attributeSetId, this.typeId, this.sku, this.hasOptions, this.requiredOptions, this.createdAt, this.updatedAt, this.name, this.image, this.smallImage, this.thumbnail, this.optionsContainer, this.msrpDisplayActualPriceType, this.urlKey, this.urlPath, this.faceColor, this.shadeName, this.directions, this.brand, this.volume, this.status, this.visibility, this.taxClassId, this.size, this.storeYear, this.faceArea, this.faceSubArea, this.drySkin, this.oilBased, this.sensitiveSkin, this.matte, this.radiant, this.shadeColor, this.veganCrueltyFree, this.tryOn, this.brandName, this.price, this.dealFromDate, this.dealToDate, this.description, this.shortDescription, this.ingredients, this.storeId,this.key});

	FaceSubareaLeftmostListOfProducts.fromJson(Map<String, dynamic> json,String key,String faceSubarea) {
    key=key;
    faceSubAreaName=faceSubarea;
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
		veganCrueltyFree = json['vegan_cruelty_free'];
		tryOn = json['try_on'];
		brandName = json['brand_name'];
		price = json['price'];
		dealFromDate = json['deal_from_date'];
		dealToDate = json['deal_to_date'];
		description = json['description'];
		shortDescription = json['short_description'];
		ingredients = json['ingredients'];
		storeId = json['store_id'] ;
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
		data['face_area'] = this.faceArea;
		data['face_sub_area'] = this.faceSubArea;
		data['dry_skin'] = this.drySkin;
		data['oil_based'] = this.oilBased;
		data['sensitive_skin'] = this.sensitiveSkin;
		data['matte'] = this.matte;
		data['radiant'] = this.radiant;
		data['shade_color'] = this.shadeColor;
		data['vegan_cruelty_free'] = this.veganCrueltyFree;
		data['try_on'] = this.tryOn;
		data['brand_name'] = this.brandName;
		data['price'] = this.price;
		data['deal_from_date'] = this.dealFromDate;
		data['deal_to_date'] = this.dealToDate;
		data['description'] = this.description;
		data['short_description'] = this.shortDescription;
		data['ingredients'] = this.ingredients;
		data['store_id'] = this.storeId;
		return data;
	}
}
