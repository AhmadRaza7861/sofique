class NewProductModel {
  late int? id;
  late String? name;
  late int? qty;
  late String? sku;
  late double? price;
  late double? discountedPrice;
  late String image;
  late String description;
  late String faceSubArea;
  late String faceSubAreaName = 'sofiqe';
  late List? options;
  late String color = '#ffffff';
  late String brand = '';
  late String avgRating = "0.0";
  late String rewardsPoint = "";
  late String reviewCount = "";
  late String productURL = "";
  bool hasOption = false;
  late double vipRatio;

  bool allergyInducing = false;
  NewProductModel(
      {required this.id,
      required this.name,
      required this.sku,
      required this.price,
      required this.image,
      required this.description,
      required this.faceSubArea,
      required this.avgRating,
      this.reviewCount = '0',
      this.rewardsPoint = '0',
      this.color = '#ffffff',
      this.faceSubAreaName = '',
      this.options,
      this.productURL = '',
      this.discountedPrice,
      this.allergyInducing = false,
      this.hasOption = false}) {
    this.getSubAreaName();
  }

  NewProductModel.fromDefaultMap(Map m) {
    String image = '';
    String description = '';
    String faceSubArea = '';
    faceSubAreaName = '';
    discountedPrice = null;

    if (m.containsKey('custom_attributes')) {
      List customAttributes = m['custom_attributes'];
      customAttributes.forEach(
        (attribute) {
          if (attribute['attribute_code'] == 'short_description') {
            description = attribute['value'];
          } else if (attribute['attribute_code'] == 'face_sub_area') {
            faceSubArea = double.parse(attribute['value']).toString();
          } else if (attribute['attribute_code'] == 'image') {
            image = attribute['value'];
          } else if (attribute['attribute_code'] == 'face_color') {
            color = attribute['value'];
          }
        },
      );
    }

    this.id = m['id'];
    this.sku = m['sku'];
    this.name = m['name'];
    this.price = m['price'] != null ? m['price'].toDouble() : 0.0;
    this.options = m['options'];
    this.image = image;
    this.description = description;
    this.faceSubArea = faceSubArea;
    if (m['extension_attributes'] != null &&
        m['extension_attributes']['avgrating'] != null) {
      this.avgRating = m['extension_attributes']['avgrating'];
    }
    if (m['extension_attributes'] != null &&
        m['extension_attributes']['product_url'] != null) {
      this.productURL = m['extension_attributes']['product_url'];
    }
    if (m['extension_attributes'] != null &&
        m['extension_attributes']['reward_points'] != null) {
      this.rewardsPoint = m['extension_attributes']['reward_points'];
    }
    if (m['extension_attributes'] != null &&
        m['extension_attributes']['review_count'] != null) {
      this.reviewCount = m['extension_attributes']['review_count'];
    }

    this.getSubAreaName();
  }

  NewProductModel.fromMap(Map m) {
    int tempId = m.containsKey('id') ? m['id'] : int.parse(m['entity_id']);

    this.id = tempId;
    this.name = m['name'];
    this.price = m['price'].runtimeType == String
        ? double.parse(m['price'])
        : m['price'].toDouble();
    this.sku = m['sku'];
    this.options = m['options'] != null ? m['options'] : [];
    this.image = m['image'] != null ? m['image'] : '';
    this.brand = m['brand'] != null ? m['brand'] : '';
    this.discountedPrice =
        m['discountedPrice'] != null ? m['discountedPrice'] : null;
    this.faceSubArea = m.containsKey('face_sub_area') ? m['face_sub_area'] : -1;
    this.color = m.containsKey('face_color')
        ? m['face_color'] != null
            ? m['face_color']
            : '#ffffff'
        : '#ffffff';
    List customAttributes =
        m.containsKey('custom_attributes') ? m['custom_attributes'] : [];
    if (m['extension_attributes'] != null &&
        m['extension_attributes']['avgrating'] != null) {
      this.avgRating = m['extension_attributes']['avgrating'];
    }
    if (m['extension_attributes'] != null &&
        m['extension_attributes']['review_count'] != null) {
      this.reviewCount = m['extension_attributes']['review_count'];
    }
    customAttributes.forEach(
      (ca) {
        if (ca.containsKey('description')) {
          this.description = ca['description'];
        }

        if (ca.containsKey('face_sub_area')) {
          switch (ca['face_sub_area'].runtimeType) {
            case String:
              this.faceSubArea = ca['face_sub_area'];
              break;
            case int:
              this.faceSubArea = ca['face_sub_area'];
              break;
            default:
              this.faceSubArea = '';
              break;
          }
        }
      },
    );
    getSubAreaName();
  }

  NewProductModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> extensionAttributes = json['extension_attributes'];
    print(extensionAttributes.length);
    this.qty = extensionAttributes['stock_item']['qty'];
    this.price = double.parse((json["price"] ?? "0").toString());
  }

  getSubAreaName() {
    if (faceSubAreaName.isNotEmpty) {
      return;
    }
    // if (faceSubAreaMapping.containsKey(faceSubArea) && faceSubArea != -1) {
    //   faceSubAreaName = faceSubAreaMapping[faceSubArea] as String;
    // } else {
    //   faceSubAreaName = 'popular';
    // }
  }
}
