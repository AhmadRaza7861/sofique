class AddressClass {
  final Customer? customer;

  AddressClass({
    this.customer,
  });

  AddressClass.fromJson(Map<String, dynamic> json)
      : customer = (json['customer'] as Map<String, dynamic>?) != null
            ? Customer.fromJson(json['customer'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'customer': customer?.toJson()};
}

class Customer {
  final String? email;
  final String? firstname;
  final String? lastname;
  final int? websiteId;
  final List<Addresses>? addresses;

  Customer({
    this.email,
    this.firstname,
    this.lastname,
    this.websiteId,
    this.addresses,
  });

  Customer.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String?,
        firstname = json['firstname'] as String?,
        lastname = json['lastname'] as String?,
        websiteId = json['website_id'] as int?,
        addresses = (json['addresses'] as List?)
            ?.map((dynamic e) => Addresses.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'website_id': websiteId,
        'addresses': addresses?.map((e) => e.toJson()).toList()
      };
}

class Addresses {
  final Region? region;
  final String? countryId;
  final List<String>? street;
  final String? telephone;
  final String? postcode;
  final String? city;
  final String? firstname;
  final String? lastname;
  final bool? defaultShipping;
  final bool? defaultBilling;

  Addresses({
    this.region,
    this.countryId,
    this.street,
    this.telephone,
    this.postcode,
    this.city,
    this.firstname,
    this.lastname,
    this.defaultShipping,
    this.defaultBilling,
  });

  Addresses.fromJson(Map<String, dynamic> json)
      : region = (json['region'] as Map<String, dynamic>?) != null
            ? Region.fromJson(json['region'] as Map<String, dynamic>)
            : null,
        countryId = json['country_id'] as String?,
        street =
            (json['street'] as List?)?.map((dynamic e) => e as String).toList(),
        telephone = json['telephone'] as String?,
        postcode = json['postcode'] as String?,
        city = json['city'] as String?,
        firstname = json['firstname'] as String?,
        lastname = json['lastname'] as String?,
        defaultShipping = json['default_shipping'] as bool?,
        defaultBilling = json['default_billing'] as bool?;

  Map<String, dynamic> toJson() => {
        'region': region?.toJson(),
        'country_id': countryId,
        'street': street,
        'telephone': telephone,
        'postcode': postcode,
        'city': city,
        'firstname': firstname,
        'lastname': lastname,
        'default_shipping': defaultShipping,
        'default_billing': defaultBilling
      };
}

class Region {
  final String? regionCode;
  final String? region;
  final int? regionId;

  Region({
    this.regionCode,
    this.region,
    this.regionId,
  });

  Region.fromJson(Map<String, dynamic> json)
      : regionCode = json['region_code'] as String?,
        region = json['region'] as String?,
        regionId = json['region_id'] as int?;

  Map<String, dynamic> toJson() =>
      {'region_code': regionCode, 'region': region, 'region_id': regionId};
}

class AddressClass2 {
  final int? id;
  final int? customerId;
  final Region? region;
  final int? regionId;
  final String? countryId;
  final List<String>? street;
  final String? telephone;
  final String? postcode;
  final String? city;
  final String? firstname;
  final String? lastname;
  final bool? defaultShipping;
  final bool? defaultBilling;

  AddressClass2({
    this.id,
    this.customerId,
    this.region,
    this.regionId,
    this.countryId,
    this.street,
    this.telephone,
    this.postcode,
    this.city,
    this.firstname,
    this.lastname,
    this.defaultShipping,
    this.defaultBilling,
  });

  AddressClass2.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        customerId = json['customer_id'] as int?,
        region = (json['region'] as Map<String, dynamic>?) != null
            ? Region.fromJson(json['region'] as Map<String, dynamic>)
            : null,
        regionId = json['region_id'] as int?,
        countryId = json['country_id'] as String?,
        street =
            (json['street'] as List?)?.map((dynamic e) => e as String).toList(),
        telephone = json['telephone'] as String?,
        postcode = json['postcode'] as String?,
        city = json['city'] as String?,
        firstname = json['firstname'] as String?,
        lastname = json['lastname'] as String?,
        defaultShipping = json['default_shipping'] as bool?,
        defaultBilling = json['default_billing'] as bool?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'region': region?.toJson(),
        'region_id': regionId,
        'country_id': countryId,
        'street': street,
        'telephone': telephone,
        'postcode': postcode,
        'city': city,
        'firstname': firstname,
        'lastname': lastname,
        'default_shipping': defaultShipping,
        'default_billing': defaultBilling
      };
}

class NewAddressClass {
  final Customer1? customer1;

  NewAddressClass({
    this.customer1,
  });

  NewAddressClass.fromJson(Map<String, dynamic> json)
      : customer1 = (json['customer'] as Map<String, dynamic>?) != null
            ? Customer1.fromJson(json['customer'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'customer': customer1?.toJson()};
}

class Customer1 {
  final String? email;
  final String? firstname;
  final String? lastname;
  final int? websiteId;
  final List<Addresses1>? addresses1;

  Customer1({
    this.email,
    this.firstname,
    this.lastname,
    this.websiteId,
    this.addresses1,
  });

  Customer1.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String?,
        firstname = json['firstname'] as String?,
        lastname = json['lastname'] as String?,
        websiteId = json['website_id'] as int?,
        addresses1 = (json['addresses'] as List?)
            ?.map((dynamic e) => Addresses1.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'website_id': websiteId,
        'addresses': addresses1?.map((e) => e.toJson()).toList()
      };
}

class Addresses1 {
  final Region? region;
  final String? countryId;
  final List<String>? street;
  final String? telephone;
  final String? postcode;
  final String? city;
  final String? firstname;
  final String? lastname;
  final bool? defaultShipping;
  final bool? defaultBilling;

  Addresses1({
    this.region,
    this.countryId,
    this.street,
    this.telephone,
    this.postcode,
    this.city,
    this.firstname,
    this.lastname,
    this.defaultShipping,
    this.defaultBilling,
  });

  Addresses1.fromJson(Map<String, dynamic> json)
      : region = (json['region'] as Map<String, dynamic>?) != null
            ? Region.fromJson(json['region'] as Map<String, dynamic>)
            : null,
        countryId = json['country_id'] as String?,
        street =
            (json['street'] as List?)?.map((dynamic e) => e as String).toList(),
        telephone = json['telephone'] as String?,
        postcode = json['postcode'] as String?,
        city = json['city'] as String?,
        firstname = json['firstname'] as String?,
        lastname = json['lastname'] as String?,
        defaultShipping = json['default_shipping'] as bool?,
        defaultBilling = json['default_billing'] as bool?;

  Map<String, dynamic> toJson() => {
        'region': region?.toJson(),
        'country_id': countryId,
        'street': street,
        'telephone': telephone,
        'postcode': postcode,
        'city': city,
        'firstname': firstname,
        'lastname': lastname,
        'default_shipping': defaultShipping,
        'default_billing': defaultBilling
      };
}

class UserAddressClass {
  final AddressInformation? addressInformation;

  UserAddressClass({
    this.addressInformation,
  });

  UserAddressClass.fromJson(Map<String, dynamic> json)
      : addressInformation =
            (json['addressInformation'] as Map<String, dynamic>?) != null
                ? AddressInformation.fromJson(
                    json['addressInformation'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() =>
      {'addressInformation': addressInformation?.toJson()};
}

class AddressInformation {
  final ShippingAddress? shippingAddress;
  final BillingAddress? billingAddress;
  final String? shippingCarrierCode;
  final String? shippingMethodCode;

  AddressInformation({
    this.shippingAddress,
    this.billingAddress,
    this.shippingCarrierCode,
    this.shippingMethodCode,
  });

  AddressInformation.fromJson(Map<String, dynamic> json)
      : shippingAddress =
            (json['shipping_address'] as Map<String, dynamic>?) != null
                ? ShippingAddress.fromJson(
                    json['shipping_address'] as Map<String, dynamic>)
                : null,
        billingAddress =
            (json['billing_address'] as Map<String, dynamic>?) != null
                ? BillingAddress.fromJson(
                    json['billing_address'] as Map<String, dynamic>)
                : null,
        shippingCarrierCode = json['shipping_carrier_code'] as String?,
        shippingMethodCode = json['shipping_method_code'] as String?;

  Map<String, dynamic> toJson() => {
        'shipping_address': shippingAddress?.toJson(),
        'billing_address': billingAddress?.toJson(),
        'shipping_carrier_code': shippingCarrierCode,
        'shipping_method_code': shippingMethodCode
      };
}

class ShippingAddress {
  final String? region;
  final int? regionId;
  final String? regionCode;
  final String? countryId;
  final List<String>? street;
  final String? postcode;
  final String? city;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? telephone;

  ShippingAddress({
    this.region,
    this.regionId,
    this.regionCode,
    this.countryId,
    this.street,
    this.postcode,
    this.city,
    this.firstname,
    this.lastname,
    this.email,
    this.telephone,
  });

  ShippingAddress.fromJson(Map<String, dynamic> json)
      : region = json['region'] as String?,
        regionId = json['region_id'] as int?,
        regionCode = json['region_code'] as String?,
        countryId = json['country_id'] as String?,
        street =
            (json['street'] as List?)?.map((dynamic e) => e as String).toList(),
        postcode = json['postcode'] as String?,
        city = json['city'] as String?,
        firstname = json['firstname'] as String?,
        lastname = json['lastname'] as String?,
        email = json['email'] as String?,
        telephone = json['telephone'] as String?;

  Map<String, dynamic> toJson() => {
        'region': region,
        'region_id': regionId,
        'region_code': regionCode,
        'country_id': countryId,
        'street': street,
        'postcode': postcode,
        'city': city,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'telephone': telephone
      };
}

class BillingAddress {
  final String? region;
  final int? regionId;
  final String? regionCode;
  final String? countryId;
  final List<String>? street;
  final String? postcode;
  final String? city;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? telephone;

  BillingAddress({
    this.region,
    this.regionId,
    this.regionCode,
    this.countryId,
    this.street,
    this.postcode,
    this.city,
    this.firstname,
    this.lastname,
    this.email,
    this.telephone,
  });

  BillingAddress.fromJson(Map<String, dynamic> json)
      : region = json['region'] as String?,
        regionId = json['region_id'] as int?,
        regionCode = json['region_code'] as String?,
        countryId = json['country_id'] as String?,
        street =
            (json['street'] as List?)?.map((dynamic e) => e as String).toList(),
        postcode = json['postcode'] as String?,
        city = json['city'] as String?,
        firstname = json['firstname'] as String?,
        lastname = json['lastname'] as String?,
        email = json['email'] as String?,
        telephone = json['telephone'] as String?;

  Map<String, dynamic> toJson() => {
        'region': region,
        'region_id': regionId,
        'region_code': regionCode,
        'country_id': countryId,
        'street': street,
        'postcode': postcode,
        'city': city,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'telephone': telephone
      };
}
