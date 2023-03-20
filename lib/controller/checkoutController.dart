import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/controller/msProfileController.dart';
import 'package:sofiqe/model/AddressClass.dart';
import 'package:sofiqe/utils/api/checkout_api.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';
import 'package:sofiqe/utils/states/local_storage.dart';

class CheckoutController extends GetxController {
  static CheckoutController instance = Get.find();

  static CheckoutController get to => Get.find();
  List? checkoutPaymentMethods;
  bool isRecentLoading = false;
  bool isLoading = false;

  var isProcessingOrder = false.obs;
  int giftCardAmount = 0;
  ClearPayTokenResponse? clearPayTokenResponse;
  List<EstimateShippingCost>? estimateShippingCostList;

  updateProcessingStatus(bool status) => isProcessingOrder.value = status;
  //Araj get payment methods: for guest call 160, for customer call 148
  getCheckoutDetails(bool isLoggedIn, int cartDetails) async {
    isRecentLoading = true;
    update();
    try {
      if (isLoggedIn) {
        // API 148 for customer
        checkoutPaymentMethods = await sfAPIGetPaymentMethods(cartDetails);
        if (!checkoutPaymentMethods![0].containsKey('code')) {
          throw 'Proper key not found in response';
        }
        // print("Checkout list == $checkoutPaymentMethods");
        if (checkoutPaymentMethods!.isEmpty) {
          Get.showSnackbar(
            GetSnackBar(
              message: '${checkoutPaymentMethods![0]["message"]}',
              // ignore: prefer_const_constructors
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        //API 160 for guest
        checkoutPaymentMethods = await sfAPIGetPaymentMethodsForGuest();
        if (!checkoutPaymentMethods![0].containsKey('code')) {
          throw 'Proper key not found in response';
        }
        // print("Checkout list == $checkoutPaymentMethods");
        if (checkoutPaymentMethods!.isEmpty) {
          Get.showSnackbar(
            GetSnackBar(
              message: '${checkoutPaymentMethods![0]["message"]}',
              duration: Duration(seconds: 2),
            ),
          );
        }
      }

      isRecentLoading = false;
      update();
    } catch (e) {
      print("Error:  $e");
    } finally {
      isRecentLoading = false;
      update();
    }
  }

  //Araj Api 159 EstimateShippingCost
  Future<void> sfAPIEstimateShippingCost(Map address, bool isLoggedin, int cartId) async {
    Uri uri;
    var response;
    print("ESC = ${jsonEncode(address)}");
    if (!isLoggedin) {
      //for guest

      String cartIdG =
          (await sfQueryForSharedPrefData(fieldName: 'cart-token', type: PreferencesDataType.STRING)).values.last;
      uri = Uri.parse(APIEndPoints.estimateShippingCost(cartIdG));
      response = await http.post(uri,
          headers: APIEndPoints.headers(APITokens.bearerToken), body: jsonEncode(address)); //Araj Api 159
    } else {
      // for customer
      MsProfileController _ = Get.find<MsProfileController>();
      ShippingAddress s2 = ShippingAddress(
        email: "${_.emailController.value.text}",
        firstname: "${_.firstNameController.value.text}",
        lastname: "${_.lastNameController.value.text}",
        telephone: "${_.phoneController.value.text}",
        regionId: 1,
        region: "Surrey",
        postcode: "${_.postCodeController.value.text}",
        countryId: "${_.countryCodeController.value.text}",
        city: "${_.cityController.value.text}",
        regionCode: "SU",
        street: ["${_.streetController.value.text}"],
      );
      BillingAddress b2 = BillingAddress(
        email: "${_.emailController.value.text}",
        firstname: "${_.billingNameController.value.text}",
        lastname: "${_.lastNameController.value.text}",
        telephone: "${_.billingPhoneController.value.text}",
        regionId: 1,
        region: "Surrey",
        postcode: "${_.billingPostZipController.value.text}",
        countryId: "${_.billingCountryCodeController.value.text}",
        city: "${_.billingCityController.value.text}",
        regionCode: "SU",
        street: ["${_.billingStreetController.value.text}"],
      );
      AddressInformation addressInformation = AddressInformation(
        billingAddress: b2,
        shippingAddress: s2,
        shippingCarrierCode: "flatrate",
        shippingMethodCode: "flatrate",
      );
      uri = Uri.parse(APIEndPoints.applyShippingMethod(cartId));
      response = await http.post(uri,
          headers: APIEndPoints.headers(APITokens.bearerToken),
          body: jsonEncode(UserAddressClass(addressInformation: addressInformation).toJson()));
    }
    // response = await http.post(uri, headers: APIEndPoints.headers(APITokens.bearerToken), body: jsonEncode(address));

    print(uri);
    print("ESC ========= ${response.body}");

    var data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      Get.snackbar('Error', '${data['message']}',
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Color(0xFFFFFFFF));
      throw "";
      // throw data['parameters']['message'];
    }
    //if response successful
    List dataList = jsonDecode(response.body) as List;
    estimateShippingCostList?.clear();
    estimateShippingCostList = dataList.map((i) => EstimateShippingCost.fromJson(i)).toList();
  }

  // Araj API 149a Select payment method with reward points
  Future<String> getSelectedPaymentMethod(int cartDetail, String selectedMethod) async {
    isRecentLoading = true;
    update();
    try {
      var body = {
        "method": {
          'method': "$selectedMethod",
        }
      };

//for customer
      Uri uri = Uri.parse(APIEndPoints.selectedPaymentMethod(cartDetail));

      var token = APITokens.adminBearerId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.put(uri, headers: headers, body: jsonEncode(body));
      print("SPM=${response.body}");
      var result = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return "Error";
      }
      isRecentLoading = false;
      update();
      return result;
    } catch (err) {
      print("Error: $err");
      rethrow;
    } finally {
      isRecentLoading = false;
      update();
    }
  }

  // Araj API 149b Clearpay checkout
  Future<String> getSelectedPaymentMethodClearPay(var cartDetail, String selectedMethod, var billingAddress) async {
    isRecentLoading = true;

    try {
      var clearpayToken = clearPayTokenResponse!.clearpayToken;
      var body = {
        "email": "${billingAddress['email']}",
        "method": {
          // "paymentMethod": {
          "method": "$selectedMethod",
          "additional_data": {"clearpay_token": "$clearpayToken"}
        },
        "billing_address": billingAddress
      };

      Uri uri;
      uri = Uri.parse(APIEndPoints.selectedPaymentMethod(cartDetail));
      var token = APITokens.adminBearerId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      print("SPMCP=${jsonEncode(body)}");
      final response = await http.put(uri, headers: headers, body: jsonEncode(body));
      print("SPMCP=${response.body}");
      var result = jsonDecode(response.body);
      print("DATA====DATA2222$result");
      if (response.statusCode != 200) {
        return "Error";
      }
      return result;
    } catch (err) {
      print("Error: $err");
      Get.showSnackbar(
        GetSnackBar(
          message: '$err',
          duration: Duration(seconds: 2),
        ),
      );
      rethrow;
    } finally {
      isRecentLoading = false;
      update();
    }
  }

  Future<String> getSelectedPaymentMethodStripe(
    var cartDetail,
    String stripeToken,
    var billingAddress,
  ) async {
    isRecentLoading = true;

    try {
      var body = {
        "email": "${billingAddress['email']}",
        "method": {
          // "paymentMethod": {
          "method": "stripe_payments",
          "additional_data": {"cc_stripejs_token": stripeToken}
        },
        "billing_address": billingAddress
      };

      Uri uri;
      uri = Uri.parse(APIEndPoints.selectedPaymentMethod(cartDetail));
      var token = APITokens.adminBearerId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      print(APIEndPoints.selectedPaymentMethod(cartDetail));
      print("SPMCP=Data${jsonEncode(body)}");
      final response = await http.put(uri, headers: headers, body: jsonEncode(body));
      print("SPMCP=${response.body}");
      var result = jsonDecode(response.body);
      print("DATA====DATA22222$result");
      print(response.statusCode);
      if (response.statusCode != 200) {
        return "Error";
      }
      return result;
    } catch (err) {
      print("Error: $err");
      Get.showSnackbar(
        GetSnackBar(
          message: '$err',
          duration: Duration(seconds: 2),
        ),
      );
      rethrow;
    } finally {
      isRecentLoading = false;
      update();
    }
  }

  dynamic getAdditionalDataforClearPay() {
    var clearpayToken = clearPayTokenResponse == null ? "" : clearPayTokenResponse!.clearpayToken;

    return {"clearpay_token": "$clearpayToken"};
  }
//

  // Set Payment API for guest Clearpay checkout for guest
  Future<dynamic> setPaymentInformationClearPayForGuest(
      var cartDetail, String selectedMethod, var billingAddress) async {
    isRecentLoading = true;
    update();
    try {
      var clearpayToken = clearPayTokenResponse!.clearpayToken;
      var body = {
        "email": "${billingAddress['email']}",
        // "method": {
        "paymentMethod": {
          "method": "$selectedMethod",
          "additional_data": {"clearpay_token": "$clearpayToken"}
        },
        "billing_address": billingAddress
      };
      dynamic b = jsonEncode(body);

      print(b);

      Uri uri;
      uri = Uri.parse(APIEndPoints.setPaymentInformationForGuest(cartDetail));
      var token = APITokens.adminBearerId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      print("SPMCP=${jsonEncode(body)}");
      final response = await http.post(uri, headers: headers, body: jsonEncode(body));
      print("SPMCP=BODY=${response.body}");
      print("SPMCP=RC${response.statusCode}");
      var result = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return "Error";
      }
      return result;
      // return "";
    } catch (err) {
      print("Error: $err");
      Get.showSnackbar(
        GetSnackBar(
          message: '$err',
          duration: Duration(seconds: 2),
        ),
      );
      rethrow;
    } finally {
      isRecentLoading = false;
      update();
    }
  }

  // Set Payment Info API for guest Clearpay checkout for guest
  Future<dynamic> setPaymentInformationStripeForGuest(var cartDetail, String stripeToken, var billingAddress) async {
    isRecentLoading = true;
    update();
    // try {
    var body = {
      "email": "${billingAddress['email']}",
      // "method": {
      "paymentMethod": {
        "method": "stripe_payments",
        "additional_data": {"cc_stripejs_token": "$stripeToken"}
      },
      "billing_address": billingAddress
    };
    dynamic b = jsonEncode(body);

    print(b);

    Uri uri;
    uri = Uri.parse(APIEndPoints.setPaymentInformationForGuest(cartDetail));
    var token = APITokens.adminBearerId;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print("SPMCP=${jsonEncode(body)}");
    final response = await http.post(uri, headers: headers, body: jsonEncode(body));
    print("SPMCP=BODY=${response.body}");
    print("SPMCP=RC${response.statusCode}");
    var result = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return "Error";
    }
    return result;
  }

  // Araj API for guest Clearpay checkout for guest
  Future<String> getSelectedPaymentMethodClearPayForGuest(
      var cartDetail, String selectedMethod, var billingAddress) async {
    isRecentLoading = true;
    update();
    try {
      var clearpayToken = clearPayTokenResponse!.clearpayToken;
      var body = {
        "email": "${billingAddress['email']}",
        // "method": {
        "paymentMethod": {
          "method": "$selectedMethod",
          "additional_data": {"clearpay_token": "$clearpayToken"}
        },
        "billing_address": billingAddress
      };
      dynamic b = jsonEncode(body);

      print(b);

      Uri uri;
      uri = Uri.parse(APIEndPoints.getPaymentMethodsForGuest(cartDetail));
      var token = APITokens.adminBearerId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      print("SPMCP=${jsonEncode(body)}");
      final response = await http.post(uri, headers: headers, body: jsonEncode(body));
      print("SPMCP= Test${response.body}");
      var result = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return "Error";
      }
      return result;
      // return "";
    } catch (err) {
      print("Error: $err");
      Get.showSnackbar(
        GetSnackBar(
          message: '$err',
          duration: Duration(seconds: 2),
        ),
      );
      rethrow;
    } finally {
      isRecentLoading = false;
      update();
    }
  }

  //Araj Api 113a
  generateGiftCard(String myName, String myEmail, String receiverName, String receiverEmail, String yourMsg,
      String orderId, String customerId, String currency) async {
    isRecentLoading = true;
    update();
    try {
      var result = await sfAPIGenerateGiftCard(
          myName, myEmail, receiverName, receiverEmail, yourMsg, orderId, customerId, currency);
      print("GiftCard =$result");

      isRecentLoading = false;
      update();
    } catch (e) {
      print("Error: $e");
    } finally {
      isRecentLoading = false;
      update();
    }
  }

  //Araj API 113.b. Apply giftcard
  Future<int> sfAPIApplyGiftCard(String giftCard) async {
    try {
      Uri uri = Uri.parse(APIEndPoints.applyGiftCard(giftCard));
      var token = APITokens.adminBearerId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.put(
        uri,
        headers: headers,
      );

      print(response.body);
      var result = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw result;
      }
      print("Result");
      return result;
    } catch (err) {
      print("Error: $err");
      rethrow;
    }
  }

//Araj Api 113b Apply giftcard
  Future<int> applyGiftcard(String giftCard) async {
    try {
      Uri uri = Uri.parse(APIEndPoints.applyGiftCard(giftCard));
      var token = APITokens.adminBearerId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Request request = http.Request('PUT', uri);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode != 200) {
        giftCardAmount = 0;
        throw await response.stream.bytesToString();
      }
      int responseBody = json.decode(await response.stream.bytesToString());
      giftCardAmount = responseBody;
      print("Response body ==  $responseBody");

      return responseBody;
    } catch (err) {
      giftCardAmount = 0;
      rethrow;
    }
  }

//Araj API 147 Apply to  Reward point
  Future<bool> applyRewardPoints(int cartDetail, int rewardPoints) async {
    try {
      Uri uri = Uri.parse(APIEndPoints.applyRewardpoint(cartDetail, rewardPoints));

      var token = APITokens.adminBearerId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
        uri,
        headers: headers,
      );

      print(response.body);
      var result = jsonDecode(response.body);
      print("ResultVip=$result");
      if (response.statusCode != 200) {
        Get.showSnackbar(
          GetSnackBar(
            message: 'You does not use vip point ',
            duration: Duration(seconds: 2),
          ),
        );
        return false;
        // throw result;
      }
      return result;
    } catch (err) {
      print("Error: $err");
      rethrow;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  //112a get clearpay token and redirected url for payment
  getClearPayToken(var cartDetail) async {
    try {
      Uri uri = Uri.parse(APIEndPoints.getClearPayToken());
      var token = APITokens.adminBearerId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = {
        "cart_id": '$cartDetail',
        "redirectPath": {
          "confirmPath": "https://sofiqe.com/clearpayconfirm.html",
          "cancelPath": "https://sofiqe.com/clearpaycancel.html"
        }
      };
      print("getClearPayToken=A${jsonEncode(body)}");
      final response = await http.post(uri, headers: headers, body: jsonEncode(body));
      print("getClearPayToken=B${response.body}");
      var result = jsonDecode(response.body);
      if (response.statusCode != 200) {
        Get.showSnackbar(
          GetSnackBar(
            message: '${result['message']}',
            duration: Duration(seconds: 2),
          ),
        );
        throw result['message'];
      }
      clearPayTokenResponse = ClearPayTokenResponse.fromJson(jsonDecode(response.body));
      print("getClearPayToken: ${clearPayTokenResponse!.clearpayRedirectCheckoutUrl}");
      return clearPayTokenResponse!.clearpayRedirectCheckoutUrl;
    } catch (err) {
      print("getClearPayToken-Error: $err");
      rethrow;
    }
  }

  // API 111a get paypal token and redirected url
  getPaypalToken(var cartDetail) async {
    try {
      print("============cartddetail============$cartDetail");
      Uri uri = Uri.parse(APIEndPoints.getPaypalToken());
      var token = APITokens.adminBearerId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      // change return_url and cancel_url
      var body = {"cart_id": '$cartDetail', "cancel_url": "https://sofiqe.com", "return_url": "https://sofiqe.com"};
      print("getPaypalToken=${jsonEncode(body)}");
      final response = await http.post(uri, headers: headers, body: jsonEncode(body));
      print("getPaypalToken=${response.body}");
      var result = jsonDecode(response.body);
      if (response.statusCode != 200) {
        Get.showSnackbar(
          GetSnackBar(
            message: '${result['message']}',
            duration: Duration(seconds: 2),
          ),
        );
        throw result['message'];
      }
      // save response for letter use
    } catch (err) {
      print("getClearPayToken-Error: $err");
      rethrow;
    }
  }
}

class ClearPayTokenResponse {
  String? clearpayToken;
  String? clearpayExpires;
  String? clearpayRedirectCheckoutUrl;

  ClearPayTokenResponse({this.clearpayToken, this.clearpayExpires, this.clearpayRedirectCheckoutUrl});

  ClearPayTokenResponse.fromJson(Map<String, dynamic> json) {
    clearpayToken = json['clearpay_token'];
    clearpayExpires = json['clearpay_auth_token_expires'];
    clearpayRedirectCheckoutUrl = json['clearpay_redirect_checkout_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clearpay_token'] = this.clearpayToken;
    data['clearpay_auth_token_expires'] = this.clearpayExpires;
    data['clearpay_redirect_checkout_url'] = this.clearpayRedirectCheckoutUrl;
    return data;
  }
}

class EstimateShippingCost {
  String? carrierCode;
  String? methodCode;
  String? carrierTitle;
  double? amount;
  double? baseAmount;
  bool? available;
  String? errorMessage;
  double? priceExclTax;
  double? priceInclTax;

  EstimateShippingCost(
      {this.carrierCode,
      this.methodCode,
      this.carrierTitle,
      this.amount,
      this.baseAmount,
      this.available,
      this.errorMessage,
      this.priceExclTax,
      this.priceInclTax});

  EstimateShippingCost.fromJson(Map<String, dynamic> json) {
    carrierCode = json['carrier_code'];
    methodCode = json['method_code'];
    carrierTitle = json['carrier_title'];
    amount = (json['amount'] != null) ? double.parse("${json['amount']}") : 0.0;
    baseAmount = (json['base_amount'] != null) ? double.parse("${json['base_amount']}") : 0.0;
    available = json['available'];
    errorMessage = json['error_message'];
    priceExclTax = (json['price_excl_tax'] != null) ? double.parse("${json['price_excl_tax']}") : 0.0;
    priceInclTax = (json['price_incl_tax'] != null) ? double.parse("${json['price_incl_tax']}") : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carrier_code'] = this.carrierCode;
    data['method_code'] = this.methodCode;
    data['carrier_title'] = this.carrierTitle;
    data['amount'] = this.amount;
    data['base_amount'] = this.baseAmount;
    data['available'] = this.available;
    data['error_message'] = this.errorMessage;
    data['price_excl_tax'] = this.priceExclTax;
    data['price_incl_tax'] = this.priceInclTax;
    return data;
  }
}
