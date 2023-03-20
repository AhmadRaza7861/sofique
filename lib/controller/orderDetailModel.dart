class OrderDetailModel {
  String? result;
  Data? data;

  OrderDetailModel({this.result, this.data});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? orderId;
  String? orderIncrementId;
  String? date;
  String? status;
  String? state;
  String? count;
  String? totals;
  String? totalQty;
  List<Items>? items;
  ShippingAddress? shippingAddress;
  BillingAddress? billingAddress;
  PaymentMethod? paymentMethod;

  Data(
      {this.orderId,
      this.orderIncrementId,
      this.date,
      this.status,
      this.state,
      this.count,
      this.totals,
      this.totalQty,
      this.items,
      this.shippingAddress,
      this.billingAddress,
      this.paymentMethod});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'] == null ? "" : json['order_id'];
    orderIncrementId = json['order_increment_id'] == null ? "" : json['order_increment_id'];
    date = json['date'] == null ? "" : json['date'];
    status = json['status'] == null ? "" : json['status'];
    state = json['state'] == null ? "" : json['state'];
    count = json['count'] == null ? "" : json['count'];
    totals = json['totals'] == null ? "" : json['totals'];
    totalQty = json['total_qty'] == null ? "" : json['total_qty'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    paymentMethod = json['payment_method'] != null
        ? new PaymentMethod.fromJson(json['payment_method'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_increment_id'] = this.orderIncrementId;
    data['date'] = this.date;
    data['status'] = this.status;
    data['state'] = this.state;
    data['count'] = this.count;
    data['totals'] = this.totals;
    data['total_qty'] = this.totalQty;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    if (this.paymentMethod != null) {
      data['payment_method'] = this.paymentMethod!.toJson();
    }
    return data;
  }
}

class Items {
  String? sku;
  String? name;
  String? image;
  String? orderQty;
  String? price;
  var productOptions;
  var additionalOptions;
  CustomAttributes? customAttributes;

  Items(
      {this.sku,
      this.name,
      this.image,
      this.orderQty,
      this.price,
      this.productOptions,
      this.additionalOptions,
      this.customAttributes});

  Items.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    name = json['name'];
    image = json['image'];
    orderQty = json['order_qty'];
    price = json['price'];
    if (json['productOptions'] != null) {
      productOptions = [];
      productOptions = json['productOptions'];
    }
    if (json['additionalOptions'] != null) {
      additionalOptions = [];
      additionalOptions = json['additionalOptions'];
    }
    customAttributes = json['custom_attributes'] != null
        ? new CustomAttributes.fromJson(json['custom_attributes'])
        : null;
    // extensionAttributes = json['extension_attributes'] != null ? new ExtensionAttributes.fromJson(json['extension_attributes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['image'] = this.image;
    data['order_qty'] = this.orderQty;
    data['price'] = this.price;
    if (this.productOptions != null) {
      data['productOptions'] =
          this.productOptions.map((v) => v.toJson()).toList();
    }
    if (this.additionalOptions != null) {
      data['additionalOptions'] =
          this.additionalOptions.map((v) => v.toJson()).toList();
    }
    if (this.customAttributes != null) {
      data['custom_attributes'] = this.customAttributes!.toJson();
    }

    return data;
  }
}

class CustomAttributes {
  String? image;
  String? urlKey;
  String? shortDescription;
  String? smallImage;
  String? optionsContainer;
  String? description;
  String? brand;
  String? thumbnail;
  String? dealFromDate;
  String? taxClassId;
  String? directions;
  String? dealToDate;
  String? msrpDisplayActualPriceType;
  String? storeYear;
  String? drySkin;
  String? oilBased;
  List<String>? categoryIds;
  String? sensitiveSkin;
  String? urlPath;
  String? matte;
  String? radiant;
  String? faceArea;
  String? requiredOptions;
  String? hasOptions;
  String? faceSubArea;
  String? size;
  String? volume;

  CustomAttributes(
      {this.image,
      this.urlKey,
      this.shortDescription,
      this.smallImage,
      this.optionsContainer,
      this.description,
      this.brand,
      this.thumbnail,
      this.dealFromDate,
      this.taxClassId,
      this.directions,
      this.dealToDate,
      this.msrpDisplayActualPriceType,
      this.storeYear,
      this.drySkin,
      this.oilBased,
      this.categoryIds,
      this.sensitiveSkin,
      this.urlPath,
      this.matte,
      this.radiant,
      this.faceArea,
      this.requiredOptions,
      this.hasOptions,
      this.faceSubArea,
      this.size,
      this.volume});

  CustomAttributes.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    urlKey = json['url_key'];
    shortDescription = json['short_description'];
    smallImage = json['small_image'];
    optionsContainer = json['options_container'];
    description = json['description'];
    brand = json['brand'];
    thumbnail = json['thumbnail'];
    dealFromDate = json['deal_from_date'];
    taxClassId = json['tax_class_id'];
    directions = json['directions'];
    dealToDate = json['deal_to_date'];
    msrpDisplayActualPriceType = json['msrp_display_actual_price_type'];
    storeYear = json['store_year'];
    drySkin = json['dry_skin'];
    oilBased = json['oil_based'];
    categoryIds = json['category_ids'].cast<String>();
    sensitiveSkin = json['sensitive_skin'];
    urlPath = json['url_path'];
    matte = json['matte'];
    radiant = json['radiant'];
    faceArea = json['face_area'];
    requiredOptions = json['required_options'];
    hasOptions = json['has_options'];
    faceSubArea = json['face_sub_area'];
    size = json['size'];
    volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['url_key'] = this.urlKey;
    data['short_description'] = this.shortDescription;
    data['small_image'] = this.smallImage;
    data['options_container'] = this.optionsContainer;
    data['description'] = this.description;
    data['brand'] = this.brand;
    data['thumbnail'] = this.thumbnail;
    data['deal_from_date'] = this.dealFromDate;
    data['tax_class_id'] = this.taxClassId;
    data['directions'] = this.directions;
    data['deal_to_date'] = this.dealToDate;
    data['msrp_display_actual_price_type'] = this.msrpDisplayActualPriceType;
    data['store_year'] = this.storeYear;
    data['dry_skin'] = this.drySkin;
    data['oil_based'] = this.oilBased;
    data['category_ids'] = this.categoryIds;
    data['sensitive_skin'] = this.sensitiveSkin;
    data['url_path'] = this.urlPath;
    data['matte'] = this.matte;
    data['radiant'] = this.radiant;
    data['face_area'] = this.faceArea;
    data['required_options'] = this.requiredOptions;
    data['has_options'] = this.hasOptions;
    data['face_sub_area'] = this.faceSubArea;
    data['size'] = this.size;
    data['volume'] = this.volume;
    return data;
  }
}

class ShippingAddress {
  String? entityId;
  String? parentId;
  String? customerAddressId;
  String? quoteAddressId;
  String? regionId;
  var customerId;
  var fax;
  String? region;
  String? postcode;
  String? lastname;
  String? street;
  String? city;
  String? email;
  var telephone;
  String? countryId;
  String? firstname;
  String? addressType;
  var prefix;
  var middlename;
  var suffix;
  var company;
  var vatId;
  var vatIsValid;
  var vatRequestId;
  var vatRequestDate;
  var vatRequestSuccess;
  var vertexVatCountryCode;

  ShippingAddress(
      {this.entityId,
      this.parentId,
      this.customerAddressId,
      this.quoteAddressId,
      this.regionId,
      this.customerId,
      this.fax,
      this.region,
      this.postcode,
      this.lastname,
      this.street,
      this.city,
      this.email,
      this.telephone,
      this.countryId,
      this.firstname,
      this.addressType,
      this.prefix,
      this.middlename,
      this.suffix,
      this.company,
      this.vatId,
      this.vatIsValid,
      this.vatRequestId,
      this.vatRequestDate,
      this.vatRequestSuccess,
      this.vertexVatCountryCode});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    entityId = json['entity_id'];
    parentId = json['parent_id'];
    customerAddressId = json['customer_address_id'];
    quoteAddressId = json['quote_address_id'];
    regionId = json['region_id'];
    customerId = json['customer_id'];
    fax = json['fax'];
    region = json['region'];
    postcode = json['postcode'];
    lastname = json['lastname'];
    street = json['street'];
    city = json['city'];
    email = json['email'];
    telephone = json['telephone'];
    countryId = json['country_id'];
    firstname = json['firstname'];
    addressType = json['address_type'];
    prefix = json['prefix'];
    middlename = json['middlename'];
    suffix = json['suffix'];
    company = json['company'];
    vatId = json['vat_id'];
    vatIsValid = json['vat_is_valid'];
    vatRequestId = json['vat_request_id'];
    vatRequestDate = json['vat_request_date'];
    vatRequestSuccess = json['vat_request_success'];
    vertexVatCountryCode = json['vertex_vat_country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entity_id'] = this.entityId;
    data['parent_id'] = this.parentId;
    data['customer_address_id'] = this.customerAddressId;
    data['quote_address_id'] = this.quoteAddressId;
    data['region_id'] = this.regionId;
    data['customer_id'] = this.customerId;
    data['fax'] = this.fax;
    data['region'] = this.region;
    data['postcode'] = this.postcode;
    data['lastname'] = this.lastname;
    data['street'] = this.street;
    data['city'] = this.city;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['country_id'] = this.countryId;
    data['firstname'] = this.firstname;
    data['address_type'] = this.addressType;
    data['prefix'] = this.prefix;
    data['middlename'] = this.middlename;
    data['suffix'] = this.suffix;
    data['company'] = this.company;
    data['vat_id'] = this.vatId;
    data['vat_is_valid'] = this.vatIsValid;
    data['vat_request_id'] = this.vatRequestId;
    data['vat_request_date'] = this.vatRequestDate;
    data['vat_request_success'] = this.vatRequestSuccess;
    data['vertex_vat_country_code'] = this.vertexVatCountryCode;
    return data;
  }
}

class BillingAddress {
  String? entityId;
  String? parentId;
  var customerAddressId;
  String? quoteAddressId;
  String? regionId;
  var customerId;
  var fax;
  String? region;
  String? postcode;
  String? lastname;
  String? street;
  String? city;
  String? email;
  var telephone;
  String? countryId;
  String? firstname;
  String? addressType;
  var prefix;
  var middlename;
  var suffix;
  var company;
  var vatId;
  var vatIsValid;
  var vatRequestId;
  var vatRequestDate;
  var vatRequestSuccess;
  var vertexVatCountryCode;

  BillingAddress(
      {this.entityId,
      this.parentId,
      this.customerAddressId,
      this.quoteAddressId,
      this.regionId,
      this.customerId,
      this.fax,
      this.region,
      this.postcode,
      this.lastname,
      this.street,
      this.city,
      this.email,
      this.telephone,
      this.countryId,
      this.firstname,
      this.addressType,
      this.prefix,
      this.middlename,
      this.suffix,
      this.company,
      this.vatId,
      this.vatIsValid,
      this.vatRequestId,
      this.vatRequestDate,
      this.vatRequestSuccess,
      this.vertexVatCountryCode});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    entityId = json['entity_id'];
    parentId = json['parent_id'];
    customerAddressId = json['customer_address_id'];
    quoteAddressId = json['quote_address_id'];
    regionId = json['region_id'];
    customerId = json['customer_id'];
    fax = json['fax'];
    region = json['region'];
    postcode = json['postcode'];
    lastname = json['lastname'];
    street = json['street'];
    city = json['city'];
    email = json['email'];
    telephone = json['telephone'];
    countryId = json['country_id'];
    firstname = json['firstname'];
    addressType = json['address_type'];
    prefix = json['prefix'];
    middlename = json['middlename'];
    suffix = json['suffix'];
    company = json['company'];
    vatId = json['vat_id'];
    vatIsValid = json['vat_is_valid'];
    vatRequestId = json['vat_request_id'];
    vatRequestDate = json['vat_request_date'];
    vatRequestSuccess = json['vat_request_success'];
    vertexVatCountryCode = json['vertex_vat_country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entity_id'] = this.entityId;
    data['parent_id'] = this.parentId;
    data['customer_address_id'] = this.customerAddressId;
    data['quote_address_id'] = this.quoteAddressId;
    data['region_id'] = this.regionId;
    data['customer_id'] = this.customerId;
    data['fax'] = this.fax;
    data['region'] = this.region;
    data['postcode'] = this.postcode;
    data['lastname'] = this.lastname;
    data['street'] = this.street;
    data['city'] = this.city;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['country_id'] = this.countryId;
    data['firstname'] = this.firstname;
    data['address_type'] = this.addressType;
    data['prefix'] = this.prefix;
    data['middlename'] = this.middlename;
    data['suffix'] = this.suffix;
    data['company'] = this.company;
    data['vat_id'] = this.vatId;
    data['vat_is_valid'] = this.vatIsValid;
    data['vat_request_id'] = this.vatRequestId;
    data['vat_request_date'] = this.vatRequestDate;
    data['vat_request_success'] = this.vatRequestSuccess;
    data['vertex_vat_country_code'] = this.vertexVatCountryCode;
    return data;
  }
}

class PaymentMethod {
  String? entityId;
  String? parentId;
  var baseShippingCaptured;
  var shippingCaptured;
  var amountRefunded;
  var baseAmountPaid;
  var amountCanceled;
  var baseAmountAuthorized;
  var baseAmountPaidOnline;
  var baseAmountRefundedOnline;
  String? baseShippingAmount;
  String? shippingAmount;
  var amountPaid;
  var amountAuthorized;
  String? baseAmountOrdered;
  var baseShippingRefunded;
  var shippingRefunded;
  var baseAmountRefunded;
  String? amountOrdered;
  var baseAmountCanceled;
  var quotePaymentId;
  var additionalData;
  var ccExpMonth;
  String? ccSsStartYear;
  var echeckBankName;
  String? method;
  var ccDebugRequestBody;
  var ccSecureVerify;
  var protectionEligibility;
  var ccApproval;
  var ccLast4;
  var ccStatusDescription;
  var echeckType;
  var ccDebugResponseSerialized;
  String? ccSsStartMonth;
  var echeckAccountType;
  var lastTransId;
  var ccCidStatus;
  var ccOwner;
  var ccType;
  var poNumber;
  String? ccExpYear;
  var ccStatus;
  var echeckRoutingNumber;
  var accountStatus;
  var anetTransMethod;
  var ccDebugResponseBody;
  var ccSsIssue;
  var echeckAccountName;
  var ccAvsStatus;
  var ccNumberEnc;
  var ccTransId;
  var addressStatus;
  AdditionalInformation? additionalInformation;

  PaymentMethod(
      {this.entityId,
      this.parentId,
      this.baseShippingCaptured,
      this.shippingCaptured,
      this.amountRefunded,
      this.baseAmountPaid,
      this.amountCanceled,
      this.baseAmountAuthorized,
      this.baseAmountPaidOnline,
      this.baseAmountRefundedOnline,
      this.baseShippingAmount,
      this.shippingAmount,
      this.amountPaid,
      this.amountAuthorized,
      this.baseAmountOrdered,
      this.baseShippingRefunded,
      this.shippingRefunded,
      this.baseAmountRefunded,
      this.amountOrdered,
      this.baseAmountCanceled,
      this.quotePaymentId,
      this.additionalData,
      this.ccExpMonth,
      this.ccSsStartYear,
      this.echeckBankName,
      this.method,
      this.ccDebugRequestBody,
      this.ccSecureVerify,
      this.protectionEligibility,
      this.ccApproval,
      this.ccLast4,
      this.ccStatusDescription,
      this.echeckType,
      this.ccDebugResponseSerialized,
      this.ccSsStartMonth,
      this.echeckAccountType,
      this.lastTransId,
      this.ccCidStatus,
      this.ccOwner,
      this.ccType,
      this.poNumber,
      this.ccExpYear,
      this.ccStatus,
      this.echeckRoutingNumber,
      this.accountStatus,
      this.anetTransMethod,
      this.ccDebugResponseBody,
      this.ccSsIssue,
      this.echeckAccountName,
      this.ccAvsStatus,
      this.ccNumberEnc,
      this.ccTransId,
      this.addressStatus,
      this.additionalInformation});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    entityId = json['entity_id'];
    parentId = json['parent_id'];
    baseShippingCaptured = json['base_shipping_captured'];
    shippingCaptured = json['shipping_captured'];
    amountRefunded = json['amount_refunded'];
    baseAmountPaid = json['base_amount_paid'];
    amountCanceled = json['amount_canceled'];
    baseAmountAuthorized = json['base_amount_authorized'];
    baseAmountPaidOnline = json['base_amount_paid_online'];
    baseAmountRefundedOnline = json['base_amount_refunded_online'];
    baseShippingAmount = json['base_shipping_amount'];
    shippingAmount = json['shipping_amount'];
    amountPaid = json['amount_paid'];
    amountAuthorized = json['amount_authorized'];
    baseAmountOrdered = json['base_amount_ordered'];
    baseShippingRefunded = json['base_shipping_refunded'];
    shippingRefunded = json['shipping_refunded'];
    baseAmountRefunded = json['base_amount_refunded'];
    amountOrdered = json['amount_ordered'];
    baseAmountCanceled = json['base_amount_canceled'];
    quotePaymentId = json['quote_payment_id'];
    additionalData = json['additional_data'];
    ccExpMonth = json['cc_exp_month'];
    ccSsStartYear = json['cc_ss_start_year'];
    echeckBankName = json['echeck_bank_name'];
    method = json['method'];
    ccDebugRequestBody = json['cc_debug_request_body'];
    ccSecureVerify = json['cc_secure_verify'];
    protectionEligibility = json['protection_eligibility'];
    ccApproval = json['cc_approval'];
    ccLast4 = json['cc_last_4'];
    ccStatusDescription = json['cc_status_description'];
    echeckType = json['echeck_type'];
    ccDebugResponseSerialized = json['cc_debug_response_serialized'];
    ccSsStartMonth = json['cc_ss_start_month'];
    echeckAccountType = json['echeck_account_type'];
    lastTransId = json['last_trans_id'];
    ccCidStatus = json['cc_cid_status'];
    ccOwner = json['cc_owner'];
    ccType = json['cc_type'];
    poNumber = json['po_number'];
    ccExpYear = json['cc_exp_year'];
    ccStatus = json['cc_status'];
    echeckRoutingNumber = json['echeck_routing_number'];
    accountStatus = json['account_status'];
    anetTransMethod = json['anet_trans_method'];
    ccDebugResponseBody = json['cc_debug_response_body'];
    ccSsIssue = json['cc_ss_issue'];
    echeckAccountName = json['echeck_account_name'];
    ccAvsStatus = json['cc_avs_status'];
    ccNumberEnc = json['cc_number_enc'];
    ccTransId = json['cc_trans_id'];
    addressStatus = json['address_status'];
    additionalInformation = (json['additional_information'] != null
        ? new AdditionalInformation.fromJson(json['additional_information'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entity_id'] = this.entityId;
    data['parent_id'] = this.parentId;
    data['base_shipping_captured'] = this.baseShippingCaptured;
    data['shipping_captured'] = this.shippingCaptured;
    data['amount_refunded'] = this.amountRefunded;
    data['base_amount_paid'] = this.baseAmountPaid;
    data['amount_canceled'] = this.amountCanceled;
    data['base_amount_authorized'] = this.baseAmountAuthorized;
    data['base_amount_paid_online'] = this.baseAmountPaidOnline;
    data['base_amount_refunded_online'] = this.baseAmountRefundedOnline;
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['shipping_amount'] = this.shippingAmount;
    data['amount_paid'] = this.amountPaid;
    data['amount_authorized'] = this.amountAuthorized;
    data['base_amount_ordered'] = this.baseAmountOrdered;
    data['base_shipping_refunded'] = this.baseShippingRefunded;
    data['shipping_refunded'] = this.shippingRefunded;
    data['base_amount_refunded'] = this.baseAmountRefunded;
    data['amount_ordered'] = this.amountOrdered;
    data['base_amount_canceled'] = this.baseAmountCanceled;
    data['quote_payment_id'] = this.quotePaymentId;
    data['additional_data'] = this.additionalData;
    data['cc_exp_month'] = this.ccExpMonth;
    data['cc_ss_start_year'] = this.ccSsStartYear;
    data['echeck_bank_name'] = this.echeckBankName;
    data['method'] = this.method;
    data['cc_debug_request_body'] = this.ccDebugRequestBody;
    data['cc_secure_verify'] = this.ccSecureVerify;
    data['protection_eligibility'] = this.protectionEligibility;
    data['cc_approval'] = this.ccApproval;
    data['cc_last_4'] = this.ccLast4;
    data['cc_status_description'] = this.ccStatusDescription;
    data['echeck_type'] = this.echeckType;
    data['cc_debug_response_serialized'] = this.ccDebugResponseSerialized;
    data['cc_ss_start_month'] = this.ccSsStartMonth;
    data['echeck_account_type'] = this.echeckAccountType;
    data['last_trans_id'] = this.lastTransId;
    data['cc_cid_status'] = this.ccCidStatus;
    data['cc_owner'] = this.ccOwner;
    data['cc_type'] = this.ccType;
    data['po_number'] = this.poNumber;
    data['cc_exp_year'] = this.ccExpYear;
    data['cc_status'] = this.ccStatus;
    data['echeck_routing_number'] = this.echeckRoutingNumber;
    data['account_status'] = this.accountStatus;
    data['anet_trans_method'] = this.anetTransMethod;
    data['cc_debug_response_body'] = this.ccDebugResponseBody;
    data['cc_ss_issue'] = this.ccSsIssue;
    data['echeck_account_name'] = this.echeckAccountName;
    data['cc_avs_status'] = this.ccAvsStatus;
    data['cc_number_enc'] = this.ccNumberEnc;
    data['cc_trans_id'] = this.ccTransId;
    data['address_status'] = this.addressStatus;
    if (this.additionalInformation != null) {
      data['additional_information'] = this.additionalInformation!.toJson();
    }
    return data;
  }
}

class AdditionalInformation {
  String? methodTitle;

  AdditionalInformation({this.methodTitle});

  AdditionalInformation.fromJson(Map<String, dynamic> json) {
    methodTitle = json['method_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method_title'] = this.methodTitle;
    return data;
  }
}
