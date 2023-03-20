class ShippingMethodModel {
  List<PaymentMethods>? paymentMethods;
  Totals? totals;

  ShippingMethodModel({this.paymentMethods, this.totals});

  ShippingMethodModel.fromJson(Map<String, dynamic> json) {
    if (json['payment_methods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(new PaymentMethods.fromJson(v));
      });
    }
    totals =
    json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentMethods != null) {
      data['payment_methods'] =
          this.paymentMethods!.map((v) => v.toJson()).toList();
    }
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    return data;
  }
}

class PaymentMethods {
  String? code;
  String? title;

  PaymentMethods({this.code, this.title});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    return data;
  }
}

class Totals {
  double? grandTotal;
  double? baseGrandTotal;
  double? subtotal;
  double? baseSubtotal;
  int? discountAmount;
  int? baseDiscountAmount;
  double? subtotalWithDiscount;
  double? baseSubtotalWithDiscount;
  double? shippingAmount;
  double? baseShippingAmount;
  int? shippingDiscountAmount;
  int? baseShippingDiscountAmount;
  int? taxAmount;
  int? baseTaxAmount;
  Null weeeTaxAppliedAmount;
  int? shippingTaxAmount;
  int? baseShippingTaxAmount;
  double? subtotalInclTax;
  double? shippingInclTax;
  double? baseShippingInclTax;
  String? baseCurrencyCode;
  String? quoteCurrencyCode;
  int? itemsQty;
  List<Items>? items;
  List<TotalSegments>? totalSegments;

  Totals(
      {this.grandTotal,
        this.baseGrandTotal,
        this.subtotal,
        this.baseSubtotal,
        this.discountAmount,
        this.baseDiscountAmount,
        this.subtotalWithDiscount,
        this.baseSubtotalWithDiscount,
        this.shippingAmount,
        this.baseShippingAmount,
        this.shippingDiscountAmount,
        this.baseShippingDiscountAmount,
        this.taxAmount,
        this.baseTaxAmount,
        this.weeeTaxAppliedAmount,
        this.shippingTaxAmount,
        this.baseShippingTaxAmount,
        this.subtotalInclTax,
        this.shippingInclTax,
        this.baseShippingInclTax,
        this.baseCurrencyCode,
        this.quoteCurrencyCode,
        this.itemsQty,
        this.items,
        this.totalSegments});

  Totals.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'];
    baseGrandTotal = json['base_grand_total'];
    subtotal = json['subtotal'];
    baseSubtotal = json['base_subtotal'];
    discountAmount = json['discount_amount'];
    baseDiscountAmount = json['base_discount_amount'];
    subtotalWithDiscount = json['subtotal_with_discount'];
    baseSubtotalWithDiscount = json['base_subtotal_with_discount'];
    shippingAmount = json['shipping_amount'];
    baseShippingAmount = json['base_shipping_amount'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    taxAmount = json['tax_amount'];
    baseTaxAmount = json['base_tax_amount'];
    weeeTaxAppliedAmount = json['weee_tax_applied_amount'];
    shippingTaxAmount = json['shipping_tax_amount'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    subtotalInclTax = json['subtotal_incl_tax'];
    shippingInclTax = json['shipping_incl_tax'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseCurrencyCode = json['base_currency_code'];
    quoteCurrencyCode = json['quote_currency_code'];
    itemsQty = json['items_qty'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['total_segments'] != null) {
      totalSegments = <TotalSegments>[];
      json['total_segments'].forEach((v) {
        totalSegments!.add(new TotalSegments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grand_total'] = this.grandTotal;
    data['base_grand_total'] = this.baseGrandTotal;
    data['subtotal'] = this.subtotal;
    data['base_subtotal'] = this.baseSubtotal;
    data['discount_amount'] = this.discountAmount;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['subtotal_with_discount'] = this.subtotalWithDiscount;
    data['base_subtotal_with_discount'] = this.baseSubtotalWithDiscount;
    data['shipping_amount'] = this.shippingAmount;
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['shipping_discount_amount'] = this.shippingDiscountAmount;
    data['base_shipping_discount_amount'] = this.baseShippingDiscountAmount;
    data['tax_amount'] = this.taxAmount;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['weee_tax_applied_amount'] = this.weeeTaxAppliedAmount;
    data['shipping_tax_amount'] = this.shippingTaxAmount;
    data['base_shipping_tax_amount'] = this.baseShippingTaxAmount;
    data['subtotal_incl_tax'] = this.subtotalInclTax;
    data['shipping_incl_tax'] = this.shippingInclTax;
    data['base_shipping_incl_tax'] = this.baseShippingInclTax;
    data['base_currency_code'] = this.baseCurrencyCode;
    data['quote_currency_code'] = this.quoteCurrencyCode;
    data['items_qty'] = this.itemsQty;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.totalSegments != null) {
      data['total_segments'] =
          this.totalSegments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? itemId;
  double? price;
  double? basePrice;
  int? qty;
  double? rowTotal;
  double? baseRowTotal;
  int? rowTotalWithDiscount;
  int? taxAmount;
  int? baseTaxAmount;
  int? taxPercent;
  int? discountAmount;
  int? baseDiscountAmount;
  int? discountPercent;
  double? priceInclTax;
  double? basePriceInclTax;
  double? rowTotalInclTax;
  double? baseRowTotalInclTax;
  String? options;
  Null weeeTaxAppliedAmount;
  Null weeeTaxApplied;
  ExtensionAttributes? extensionAttributes;
  String? name;

  Items(
      {this.itemId,
        this.price,
        this.basePrice,
        this.qty,
        this.rowTotal,
        this.baseRowTotal,
        this.rowTotalWithDiscount,
        this.taxAmount,
        this.baseTaxAmount,
        this.taxPercent,
        this.discountAmount,
        this.baseDiscountAmount,
        this.discountPercent,
        this.priceInclTax,
        this.basePriceInclTax,
        this.rowTotalInclTax,
        this.baseRowTotalInclTax,
        this.options,
        this.weeeTaxAppliedAmount,
        this.weeeTaxApplied,
        this.extensionAttributes,
        this.name});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    price = json['price'];
    basePrice = json['base_price'];
    qty = json['qty'];
    rowTotal = json['row_total'];
    baseRowTotal = json['base_row_total'];
    rowTotalWithDiscount = json['row_total_with_discount'];
    taxAmount = json['tax_amount'];
    baseTaxAmount = json['base_tax_amount'];
    taxPercent = json['tax_percent'];
    discountAmount = json['discount_amount'];
    baseDiscountAmount = json['base_discount_amount'];
    discountPercent = json['discount_percent'];
    priceInclTax = json['price_incl_tax'];
    basePriceInclTax = json['base_price_incl_tax'];
    rowTotalInclTax = json['row_total_incl_tax'];
    baseRowTotalInclTax = json['base_row_total_incl_tax'];
    options = json['options'];
    weeeTaxAppliedAmount = json['weee_tax_applied_amount'];
    weeeTaxApplied = json['weee_tax_applied'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['price'] = this.price;
    data['base_price'] = this.basePrice;
    data['qty'] = this.qty;
    data['row_total'] = this.rowTotal;
    data['base_row_total'] = this.baseRowTotal;
    data['row_total_with_discount'] = this.rowTotalWithDiscount;
    data['tax_amount'] = this.taxAmount;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['tax_percent'] = this.taxPercent;
    data['discount_amount'] = this.discountAmount;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['discount_percent'] = this.discountPercent;
    data['price_incl_tax'] = this.priceInclTax;
    data['base_price_incl_tax'] = this.basePriceInclTax;
    data['row_total_incl_tax'] = this.rowTotalInclTax;
    data['base_row_total_incl_tax'] = this.baseRowTotalInclTax;
    data['options'] = this.options;
    data['weee_tax_applied_amount'] = this.weeeTaxAppliedAmount;
    data['weee_tax_applied'] = this.weeeTaxApplied;
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes!.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class ExtensionAttributes {
  String? mposc;

  ExtensionAttributes({this.mposc});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    mposc = json['mposc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mposc'] = mposc;
    return data;
  }
}

class TotalSegments {
  String? code;
  String? title;
  double? value;
  ExtensionAttributes? extensionAttributes;
  String? area;

  TotalSegments(
      {this.code, this.title, this.value, this.extensionAttributes, this.area});

  TotalSegments.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    value = json['value'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    data['value'] = this.value;
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes!.toJson();
    }
    data['area'] = this.area;
    return data;
  }
}

class ExtensionAttributess {
  String? taxGrandtotalDetails;

  ExtensionAttributess({this.taxGrandtotalDetails});

  ExtensionAttributess.fromJson(Map<String, dynamic> json) {
    taxGrandtotalDetails = json['tax_grandtotal_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax_grandtotal_details'] = this.taxGrandtotalDetails;
    return data;
  }
}