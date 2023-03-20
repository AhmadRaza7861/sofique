
class Product1 {
  late int? id;
  late String? name;
  late String? sku;
  late double? price;
   double? discountedPrice=0.0;
  late String image;
  late String description;
  // late int faceSubArea;
  // late String faceSubAreaName = 'sofiqe';
  late List? options;
  late String? avgrating;
  late String? reviewCount;
  late String? rewardPoints;
  late String? productUrl;
  late String color = '#ffffff';
  // late String brand = '';
  // bool allergyInducing = false;
  Product1({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    required this.image,
    required this.description,
    // required this.faceSubArea,
    this.color = '#ffffff',
    // this.faceSubAreaName = '',
    this.options,
    this.avgrating,
    this.reviewCount,
    this.rewardPoints,
    this.productUrl,
     this.discountedPrice,
    // this.allergyInducing = false,
  })
  {
    // this.getSubAreaName();
  }

  Product1.fromDefaultMap(Map m) {
    String image = '';
    // String description = '';
    // int faceSubArea = -1;
    // faceSubAreaName = '';
    // discountedPrice = null;

    // if (m.containsKey('custom_attributes')) {
    //   List customAttributes = m['custom_attributes'];
    //   customAttributes.forEach(
    //         (attribute) {
    //       if (attribute['attribute_code'] == 'short_description') {
    //         description = attribute['value'];
    //       } else if (attribute['attribute_code'] == 'face_sub_area') {
    //         faceSubArea = double.parse(attribute['value']).toInt();
    //       } else if (attribute['attribute_code'] == 'image') {
    //         image = attribute['value'];
    //       } else if (attribute['attribute_code'] == 'face_color') {
    //         color = attribute['value'];
    //       }
    //     },
    //   );
    // }

    this.id = m['id'];
    this.sku = m['sku'];
    this.name = m['name'];
    this.price = m['price'].toDouble() ?? 0.0;
    this.color = m['face_color'];
    this.image = image;
    this.avgrating=m['avgrating'].toString();
    this.reviewCount=m['review_count'].toString();
    this.rewardPoints=m['reward_points'].toString();
    this.productUrl=m['product_url'].toString();
    this.description = description;
    // this.faceSubArea = faceSubArea;

    // this.getSubAreaName();
  }

  Product1.fromMap(Map m) {
    int tempId = m.containsKey('id') ? m['id'] : m.containsKey('product_id') ? m['product_id'] : int.parse(m['entity_id']);

    this.id = tempId;
    this.name = m['name'];
    this.price = m['price'].runtimeType == String
        ? double.parse(m['price'])
        : m['price'].toDouble();
    this.sku = m['sku'];
    // this.options = m['options'] != null ? m['options'] : [];
    this.image = m['image'] != null ? m['image'] : '';
    // this.brand = m['brand'] != null ? m['brand'] : '';
    // this.discountedPrice =
    // m['discountedPrice'] != null ? m['discountedPrice'] : null;
    // this.faceSubArea =
    // m.containsKey('face_sub_area') ? int.parse(m['face_sub_area']) : -1;
    // this.color = m.containsKey('face_color')
    //     ? m['face_color'] != null
    //     ? m['face_color']
    //     : '#ffffff'
    // //     : '#ffffff';
    // List customAttributes =
    // m.containsKey('custom_attributes') ? m['custom_attributes'] : [];
    // customAttributes.forEach(
    //       (ca) {
    //     if (ca.containsKey('description')) {
    //       this.description = ca['description'];
    //     }
    //
    //     if (ca.containsKey('face_sub_area')) {
    //       switch (ca['face_sub_area'].runtimeType) {
    //         case String:
    //           this.faceSubArea = int.parse(ca['face_sub_area']);
    //           break;
    //         case int:
    //           this.faceSubArea = ca['face_sub_area'];
    //           break;
    //         default:
    //           this.faceSubArea = -1;
    //           break;
    //       }
    //     }
    //   },
    // );
   // getSubAreaName();
  }

  // getSubAreaName() {
  //   if (faceSubAreaName.isNotEmpty) {
  //     return;
  //   }
  //   if (faceSubAreaMapping.containsKey(faceSubArea) && faceSubArea != -1) {
  //     faceSubAreaName = faceSubAreaMapping[faceSubArea] as String;
  //   } else {
  //     faceSubAreaName = 'popular';
  //   }
  // }
}
