import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/controller/msProfileController.dart';
import 'package:sofiqe/model/AddressClass.dart';
// Utils
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';
import 'package:sofiqe/utils/states/local_storage.dart';
import 'package:sofiqe/utils/states/user_account_data.dart';

Future<http.Response> sfAPIGetShippingAddressFromCustomerID({required int customerId}) async {
  Uri url = Uri.parse('${APIEndPoints.getShippingaDDres(customerId)}');
  http.Response response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${APITokens.bearerToken}',
  });
  print("API 6.C=> Body=> Shipping Address=  " + response.body.toString());

  MsProfileController _ = Get.find<MsProfileController>();
  AddressClass2 a = AddressClass2.fromJson(jsonDecode(response.body));
  _.firstNameController.text = a.firstname.toString();
  _.lastNameController.text = a.lastname.toString();
  _.nameController.text = a.firstname.toString();
  _.countryController.text = a.region?.region.toString() ?? "";
  final string = a.street?.reduce((value, element) => value + ',' + element);
  _.streetController.text = string ?? "";
  _.postCodeController.text = a.postcode.toString();
  _.cityController.text = a.city.toString();
  _.phoneController.text = a.telephone.toString();
  return response;
}

Future<http.Response> sfAPIGetBillingAddressFromCustomerID({required int customerId}) async {
  Uri url = Uri.parse('${APIEndPoints.getBillingaDDres(customerId)}');
  http.Response response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${APITokens.bearerToken}',
  });

  print(await APITokens.customerSavedToken);
  print("API 6.b=> Body=> Billing Address=  " + response.body.toString());

  MsProfileController _ = Get.find<MsProfileController>();
  AddressClass2 a = AddressClass2.fromJson(jsonDecode(response.body));
  _.billingNameController.text = a.firstname.toString();
  _.billingCountryController.text = a.region?.region.toString() ?? "";
  final string = a.street?.reduce((value, element) => value + ',' + element);
  _.billingStreetController.text = string ?? "";
  _.billingPostZipController.text = a.postcode.toString();
  _.billingCityController.text = a.city.toString();
  _.billingPhoneController.text = a.telephone.toString();
  return response;
}

Future<String> sfAPIAddShippingAddress(Map address, bool isLoggedin, int cartId) async {
  Uri uri;
  var response;
  try {
    if (!isLoggedin) {
      print("DATag = ${jsonEncode(address)}");
      String cartIdG =
          (await sfQueryForSharedPrefData(fieldName: 'cart-token', type: PreferencesDataType.STRING)).values.last;
      uri = Uri.parse(APIEndPoints.addShippingAddress(cartIdG)); //Araj Api 159

      print(uri.toString());
      response = await http.post(uri, headers: APIEndPoints.headers(APITokens.bearerToken), body: jsonEncode(address));

      print("data  == ${response.body}");
      print("DATA");
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        Get.snackbar('Error', '${data['message']}',
            isDismissible: true,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Color(0xFFFFFFFF));
        throw "";
        // throw data['message'];
      }
    } else {
      print("DATAc = ${jsonEncode(address)}");
      print("==========CartId===========$cartId");
      uri = Uri.parse(APIEndPoints.applyShippingMethod(cartId));

      print("==========CartId===========$cartId");
      response = await http.post(uri, headers: APIEndPoints.headers(APITokens.bearerToken), body: jsonEncode(address));

      print("data  == ${response.body}");

      print("DATA");
      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        Get.snackbar('Error', '${data['parameters']['message']}',
            isDismissible: true,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Color(0xFFFFFFFF));
        throw "";
        // throw data['parameters']['message'];
      }
    }
  } catch (e) {
    print(e);
  }
  String shipAddress = address['addressInformation']['shippingAddress']['street'][0] ?? "";
  if (shipAddress.isNotEmpty) {
    shipAddress = shipAddress + ", ";
  }
  try {
    shipAddress = shipAddress + (address['addressInformation']['shippingAddress']['street'][1] ?? "");
    if (shipAddress.isNotEmpty) {
      shipAddress = shipAddress + ", ";
    }
  } catch (e) {}
  shipAddress = shipAddress + (address['addressInformation']['shippingAddress']['city'] ?? "");
  if (shipAddress.isNotEmpty) {
    shipAddress = shipAddress + ", ";
  }
  //
  shipAddress = shipAddress + (address['addressInformation']['shippingAddress']['postcode'] ?? "");
  if (shipAddress.isNotEmpty) {
    shipAddress = shipAddress + ", ";
  }
  //
  shipAddress = shipAddress + (address['addressInformation']['shippingAddress']['region'] ?? "");
  if (shipAddress.isNotEmpty) {
    shipAddress = shipAddress + ", ";
  }
  shipAddress = shipAddress + (address['addressInformation']['shippingAddress']['countryId'] ?? "");
  print("SHIP=$shipAddress");

  return shipAddress;
}

Future<dynamic> sfAPIFetchCountryDetails() async {
  Uri uri = Uri.parse(APIEndPoints.countryDetails);
  final response = await http.get(
    uri,
    headers: APIEndPoints.headers(APITokens.bearerToken),
  );
  if (response.statusCode != 200) {
    return response;
  } else {
    print("COUNTRY=${json.decode(response.body)}");
    return response;
  }
}


// Araj Api 161 & 150 pay/order: for guest call 161, for customer call 150

Future<String> sfApiPlaceOrder(bool isLoggedIn, int cartId, String paymentCode, dynamic additionaldata) async {
  Uri uri;
  var response;
  if (!isLoggedIn) {
    //for guest
    String cartIdG =
        (await sfQueryForSharedPrefData(fieldName: 'cart-token', type: PreferencesDataType.STRING)).values.last;

    uri = Uri.parse(APIEndPoints.placeOrder(cartIdG));

    print("API 161 => URL=$uri =>TOKEN=${APITokens.bearerToken} =>CARTID=$cartIdG =>method=$paymentCode");
    print(jsonEncode({
      "paymentMethod": {'method': "$paymentCode", "additional_data": additionaldata}
    }));
    response = await http.put(uri,
        headers: APIEndPoints.headers(
          APITokens.bearerToken,
        ),
        body: jsonEncode({
          "paymentMethod": {"method": "$paymentCode", "additional_data": additionaldata}
        }));
  } else {
    //for customer
    uri = Uri.parse(APIEndPoints.placeCustOrder(cartId));
    print("API 150 => URL=$uri =>TOKEN=${APITokens.bearerToken} =>CARTID=$cartId");
    response = await http.put(
      uri,
      body: jsonEncode({
        "paymentMethod": {'method': "$paymentCode", "additional_data": additionaldata}
      }),
      headers: APIEndPoints.headers(
        APITokens.bearerToken,
      ),
    );
  }

  print("==========akshay$uri=${response.body}");
  var result = jsonDecode(response.body);

  if (response.statusCode != 200) {
    print("ERROR");

    Get.showSnackbar(
      GetSnackBar(
        message: '${result['message']}',
        duration: Duration(seconds: 2),
      ),
    );

    throw result;
    // throw sfApiPlaceOrder(isLoggedIn, selectedMathod);
  }
  await sfClearCartToken();
  return result;
}

//APi to Get Order Details From Order ID
Future<dynamic> getOrderDetailfromOrderId(bool isLoggedIn, String orderId) async {
  Uri uri;
  var response;

  uri = Uri.parse(APIEndPoints.getOrderDetails(orderId));
  print(uri.toString());
  response = await http.get(
    uri,
    headers: APIEndPoints.headers(
      APITokens.bearerToken,
    ),
  );
  var result = jsonDecode(response.body);
  if (response.statusCode != 200) {
    print("ERROR");
    Get.showSnackbar(
      GetSnackBar(
        message: '${result['message']}',
        duration: Duration(seconds: 2),
      ),
    );
    throw result;
  }
  return result;
}
