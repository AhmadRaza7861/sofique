// ignore_for_file: unused_catch_clause

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/model/profile.dart';
import 'package:sofiqe/model/recentItemModel.dart';
import 'package:sofiqe/network_service/network_service.dart';
import 'package:sofiqe/utils/api/user_account_api.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';

import '../utils/states/local_storage.dart';
import 'controllers.dart';

class MsProfileController extends GetxController {
  static MsProfileController get to => Get.find();

  static MsProfileController instance = Get.find();
  RecentItemModel? recentItem;
  Profile? profileModle;
  var atmCards = <AtmCard>[];
  late var screen = 0.obs;
  bool isRecentLoading = false;
  bool isLoading = false;
  String selectedGender = "";

  @override
  void onInit() {
    super.onInit();
    print("called on int Profile Controller");
    // getUserProfile();
    getUserQuestionsInformations();
    getUserCardDetailes();
  }

  resetControllers() {
    billingNameController = TextEditingController();
    billingCountryController = TextEditingController();
    billingStreetController = TextEditingController();
    billingPostZipController = TextEditingController();
    billingCityController = TextEditingController();
    billingPhoneController = TextEditingController();
    billingPhoneNumberCodeController = TextEditingController(text: "+1");
    countryCodeController = TextEditingController();
    billingCountryCodeController = TextEditingController();
    regionCodeController = TextEditingController();
    billingRegionCodeController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    countryController = TextEditingController();
    streetController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    phoneNumberCodeController = TextEditingController(text: "+1");
    cardNumberController = TextEditingController();
    monthCardController = TextEditingController();
    cvcController = TextEditingController();
    postCodeController = TextEditingController();
    cityController = TextEditingController(text: "");
    cardNameController = TextEditingController();
    update();
  }

  ///
  /// TextFormFiels controllers that's will use to update profiles
  ///
  ///
  ///
  /// For Testing
  // TextEditingController firstNameController = TextEditingController(text: "Farooq");
  // TextEditingController lastNameController = TextEditingController(text: "Aziz");
  // TextEditingController emailController = TextEditingController(text: "farooqaziz20@gmail.com");
  // TextEditingController countryController = TextEditingController(text: "UK");
  // TextEditingController streetController = TextEditingController(text: "ABC1234");
  // TextEditingController nameController = TextEditingController(text: "Farooq ");
  // TextEditingController phoneController = TextEditingController(text: "076666767667");
  // TextEditingController phoneNumberCodeController = TextEditingController(text: "+44");

  // TextEditingController billingNameController = TextEditingController(text: "Farooq");
  // TextEditingController billingCountryController = TextEditingController(text: "UK");
  // TextEditingController billingStreetController = TextEditingController(text: "ABC1234");
  // TextEditingController billingPostZipController = TextEditingController(text: "123ABC");
  // TextEditingController billingCityController = TextEditingController(text: "ABC123");
  // TextEditingController billingPhoneController = TextEditingController(text: "076666767667");
  // TextEditingController billingPhoneNumberCodeController = TextEditingController(text: "+44");

  // TextEditingController countryCodeController = TextEditingController(text: "");
  // TextEditingController billingCountryCodeController = TextEditingController(text: "");
  // TextEditingController regionCodeController = TextEditingController(text: "ABC123");
  // TextEditingController billingRegionCodeController = TextEditingController(text: "");

  // TextEditingController cardNumberController = TextEditingController();
  // TextEditingController monthCardController = TextEditingController();
  // TextEditingController cvcController = TextEditingController();
  // TextEditingController postCodeController = TextEditingController();
  // TextEditingController cityController = TextEditingController(text: "ABC123");
  // TextEditingController cardNameController = TextEditingController();

  TextEditingController billingNameController = TextEditingController();
  TextEditingController billingCountryController = TextEditingController();
  TextEditingController billingStreetController = TextEditingController();
  TextEditingController billingPostZipController = TextEditingController();
  TextEditingController billingCityController = TextEditingController();
  TextEditingController billingPhoneController = TextEditingController();
  TextEditingController billingPhoneNumberCodeController = TextEditingController(text: "+1");

  TextEditingController countryCodeController = TextEditingController();
  TextEditingController billingCountryCodeController = TextEditingController();
  TextEditingController regionCodeController = TextEditingController();
  TextEditingController billingRegionCodeController = TextEditingController();

  TextEditingController regionIdController = TextEditingController();
  TextEditingController billingIdodeController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phoneNumberCodeController = TextEditingController(text: "+1");

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController monthCardController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController(text: "");
  TextEditingController cardNameController = TextEditingController();

  String? phoneNo;

  RxBool isShiping = RxBool(false);
  RxBool isBilling = RxBool(false);
  RxString shippingAddress = "".obs;
  loadShippindAdressinProvider() async {
    dynamic shipping_address =
        await sfQueryForSharedPrefData(fieldName: 'shipping_address', type: PreferencesDataType.STRING);
    if (shipping_address["found"]) {
      dynamic shippind_data = jsonDecode(shipping_address["shipping_address"]);
      String address = ((shippind_data["street"] ?? [""])[0]) +
          ", " +
          (shippind_data["city"] ?? "") +
          ", " +
          (shippind_data["postcode"] ?? "") +
          ", " +
          (shippind_data["region"] ?? "") +
          ", " +
          (shippind_data["region_code"] ?? "");
      shippingAddress.value = address;
    } else {
      shippingAddress.value = "Please add your address";
    }
  }

  loaddataToControllers() async {
    dynamic shipping_address =
        await sfQueryForSharedPrefData(fieldName: 'shipping_address', type: PreferencesDataType.STRING);
    dynamic billing_address =
        await sfQueryForSharedPrefData(fieldName: 'billing_address', type: PreferencesDataType.STRING);
    dynamic phoneNoCode = await sfQueryForSharedPrefData(fieldName: 'phone_no_code', type: PreferencesDataType.STRING);
    dynamic phoneNoCodeBilling =
        await sfQueryForSharedPrefData(fieldName: 'phone_no_code_billing', type: PreferencesDataType.STRING);

    print("Shippind Data");
    print(shipping_address);

    if (shipping_address["found"]) {
      dynamic shippind_data = jsonDecode(shipping_address["shipping_address"]);
      countryController.text = shippind_data["region"] ?? "";
      streetController.text = (shippind_data["street"] ?? [""])[0];
      nameController.text = (shippind_data["firstname"] ?? "") + " " + (shippind_data["lastname"] ?? "");
      phoneController.text = shippind_data["telephone"] ?? "";
      phoneNumberCodeController.text = phoneNoCode["found"] ? phoneNoCode["phone_no_code"] : "+1";
      postCodeController.text = shippind_data["postcode"] ?? "";
      cityController.text = shippind_data["city"] ?? "";
      countryCodeController.text = shippind_data["country_id"] ?? "";
      regionCodeController.text = shippind_data["region_code"] ?? "";
      regionIdController.text = (shippind_data["region_id"] ?? "").toString();
      emailController.text = shippind_data["email"] ?? "";
      firstNameController.text = (shippind_data["firstname"] ?? "");
      lastNameController.text = (shippind_data["lastname"] ?? "");
      isShiping.value = (shippind_data["sameAsBilling"] ?? "0").toString() == "1" ? true : false;
    }
    print("Biliing Data");
    print(billing_address);

    if (billing_address["found"]) {
      dynamic billing_data = jsonDecode(billing_address["billing_address"]);
      print((billing_data["firstname"] ?? "") + " " + (billing_data["lastname"] ?? ""));
      billingNameController.text = (billing_data["firstname"] ?? "") + " " + (billing_data["lastname"] ?? "");
      billingCountryController.text = billing_data["region"] ?? "";
      billingStreetController.text = (billing_data["street"] ?? [""])[0];
      billingPostZipController.text = billing_data["postcode"] ?? "";
      billingCityController.text = billing_data["city"] ?? "";
      billingPhoneController.text = billing_data["telephone"] ?? "";
      billingPhoneNumberCodeController.text =
          phoneNoCodeBilling["found"] ? phoneNoCodeBilling["phone_no_code_billing"] : "+1";
      billingCountryCodeController.text = billing_data["country_id"] ?? "";
      billingRegionCodeController.text = billing_data["region_code"] ?? "";
      billingIdodeController.text = (billing_data["region_id"] ?? "").toString();
    }
  }

  Future<bool> updateUserProfile() async {
    isRecentLoading = true;
    var result;
    update();

    ///
    /// Customize the request body
    ///

    var body;

    ///-----new body with billing address
    if (isShiping.value) {
      ///---only both same
      body = {
        "customer": {
          "email": emailController.text,
          "firstname": firstNameController.text,
          "lastname": lastNameController.text,
          "gender": getGenderCount(),
          "website_id": profileModle?.websiteId,
          "custom_attributes": [
            {"attribute_code": "phone_number", "value": '${phoneController.text}'}
          ],
          "addresses": [
            {
              "region": {"region_code": "TX", "region": "Texas", "region_id": 57},
              "postcode": postCodeController.text,
              "city": cityController.text,
              "country_id": countryController.text.toUpperCase(),
              "firstname": firstNameController.text,
              "lastname": lastNameController.text,
              "street": ['${streetController.text}'],
              "telephone": '${phoneNumberCodeController.text} ${phoneController.text}',
              "default_shipping": isShiping.value,
              "default_billing": isBilling.value,
            }
          ]
        }
      };
    } else {
      ///---only both are different
      print('------ its updating with different addresses -------');
      body = {
        "customer": {
          "email": emailController.text,
          "firstname": firstNameController.text,
          "lastname": lastNameController.text,
          "gender": getGenderCount(),
          "website_id": profileModle?.websiteId,
          "custom_attributes": [
            {"attribute_code": "phone_number", "value": '${phoneController.text}'}
          ],
          "addresses": [
            {
              "region": {"region_code": "TX", "region": "Texas", "region_id": 57},
              "postcode": postCodeController.text,
              "city": cityController.text,
              "country_id": countryController.text.toUpperCase(),
              "firstname": firstNameController.text,
              "lastname": lastNameController.text,
              "street": ['${streetController.text}'],
              "telephone": '${phoneNumberCodeController.text} ${phoneController.text}',
              "default_shipping": isShiping.value,
              "default_billing": isBilling.value,
            },
            {
              "region": {"region_code": "TX", "region": "Texas", "region_id": 57},
              "postcode": billingPostZipController.text,
              "city": billingCityController.text,
              "country_id": billingCountryController.text.toUpperCase(),
              "firstname": firstNameController.text,
              "lastname": lastNameController.text,
              "street": ['${billingStreetController.text}'],
              "telephone": '${phoneNumberCodeController.text} ${phoneController.text}',
              "default_shipping": isShiping.value,
              "default_billing": isBilling.value,
            }
          ]
        }
      };
    }

    print(body.toString());
    try {
      http.Response? response = await NetworkHandler.patchMethodWithBodyCall(
          body: jsonEncode(body),
          // url: "https://dev.sofiqe.com/rest/default/V1/customers/me",
          url: "https://sofiqe.com/rest/default/V1/customers/me", // API 98, 103
          headers: APIEndPoints.headers(await APITokens.customerSavedToken));
      print("Responce of API is ${response?.body}");

      if (response?.statusCode == 200) {
        Get.snackbar('Succesfully', 'User profile updated Succesfully',
            isDismissible: true, backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
        //  Get.snackbar('Error', 'Card Api is in under Development');
        //  updateCardDetailes();
        return true;
      } else {
        result = json.decode(response!.body);
        Get.snackbar('Error', '${result[0]["message"]}',
            isDismissible: true, backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong',
          isDismissible: true, backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      // Get.snackbar('Error', '${result["message"]}', isDismissible: true);
      update();
      return false;
    }
  }

  //Araj
  Future<bool> updateUserProfileAddress() async {
    isRecentLoading = true;
    var result;
    update();

    ///
    /// Customize the request body
    ///

    ///
    //todo: there is static region code
    //needs to update api as well as code

    var body = {
      "customer": {
        "email": profileModle?.email,
        "firstname": profileModle?.firstname,
        "lastname": profileModle?.lastname,
        "gender": profileModle?.gender,
        "website_id": profileModle?.websiteId,
        "custom_attributes": [
          {"attribute_code": "phone_number", "value": '${phoneController.text}'}
        ],
        "addresses": [
          {
            "region": {"region_code": "TX", "region": "Texas", "region_id": 57},
            "postcode": postCodeController.text,
            "city": cityController.text,
            "country_id": countryController.text.toUpperCase(),
            "firstname": firstNameController.text,
            "lastname": lastNameController.text,
            "street": ['${streetController.text}'],
            "telephone": '${phoneNumberCodeController.text} ${phoneController.text}',
            "default_shipping": isShiping.value,
            "default_billing": isBilling.value,
          }
        ]
      }
    };

    //#endregion
    print(body.toString());
    print("==========address========" + body.toString());
    try {
      http.Response? response = await NetworkHandler.patchMethodWithBodyCall(
          body: jsonEncode(body),
          // url: "https://dev.sofiqe.com/rest/default/V1/customers/me",
          url: "https://sofiqe.com/rest/default/V1/customers/me", // API 98, 103
          headers: APIEndPoints.headers(await APITokens.customerSavedToken));
      print("Responce of API is ${response?.body}");

      if (response?.statusCode == 200) {
        Get.snackbar('Successfully', 'Address has been updated.',
            backgroundColor: Colors.black, dismissDirection: DismissDirection.down, isDismissible: true);
        //  Get.snackbar('Error', 'Card Api is in under Development');
        updateCardDetailes();
        return true;
      } else {
        result = json.decode(response!.body);
        Get.snackbar('Error', '${result[0]["message"]}', isDismissible: true);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', '${result["message"]}', isDismissible: true);
      update();
      return false;
    }
  }

  getUserProfile() async {
    isRecentLoading = true;
    update();
    try {
      var result = await sfAPIGetUserDetails(await APITokens.customerSavedToken);
      print("Userrr Address Details");
      print(result);
      if (result != null) {
        profileModle = Profile.fromJson(result);
        saveFCMToken();
        if (profileModle?.gender == 0) {
          selectedGender = "FEMALE";
        } else if (profileModle?.gender == 1) {
          selectedGender = "MALE";
        } else if (profileModle?.gender == 2) {
          selectedGender = "GENDERLESS";
        } else if (profileModle?.gender == 3) {
          selectedGender = "LBGT";
        }
        firstNameController.text = profileModle?.firstname ?? "";
        lastNameController.text = profileModle?.lastname ?? "";
        emailController.text = profileModle?.email ?? "";
        if (profileModle?.addresses != null && profileModle?.addresses?.length != 0) {
          phoneController.text = profileModle!.getPhoneNumber();
          phoneNumberCodeController.text = profileModle?.addresses?[0].telephone!.split(' ').first ?? "";
          countryController.text = profileModle?.addresses?[0].countryId ?? "";

          isBilling.value = profileModle?.addresses?[0].defaultBilling ?? false;
          cityController.text = profileModle?.addresses?[0].city ?? "";
          postCodeController.text = profileModle?.addresses?[0].postcode ?? "";
          print('isShipping  ${profileModle?.addresses?[0].defaultShipping}');

          isShiping.value = profileModle?.addresses?[0].defaultShipping ?? true;
          streetController.text = profileModle?.addresses?[0].street?[0] ?? "";

          if (profileModle!.addresses != null && profileModle!.addresses!.length > 1) {
            billingStreetController.text = profileModle?.addresses?[1].street?[0] ?? "";
            billingCityController.text = profileModle?.addresses?[1].city ?? "";
            billingPostZipController.text = profileModle?.addresses?[1].postcode ?? "";
            billingCountryController.text = profileModle?.addresses?[1].countryId ?? "";
          }
        }
        List listAddress = result["addresses"] ?? [];

        dynamic shippingaddress = {};
        dynamic billingaddress = {};
        for (int i = 0; i < listAddress.length; i++) {
          dynamic address = listAddress[i];
          if (address["default_shipping"] == true) {
            shippingaddress = address;
          }
          if (address["default_billing"] == true) {
            billingaddress = address;
          }
          if (address["default_shipping"] == true && address["default_billing"] == true) {
            isShiping.value = true;
          }
        }
        Map<String, dynamic> addressInfo = {
          "addressInformation": {
            "shippingAddress": {
              "region": shippingaddress[""] ?? "",
              "region_id": shippingaddress["region_id"] ?? 0,
              "country_id": shippingaddress["country_id"] ?? "",
              "street": shippingaddress["street"] ?? [""],
              "company": "Revered-Tech",
              "telephone": shippingaddress["telephone"] ?? "",
              "postcode": shippingaddress["postcode"] ?? "",
              "city": shippingaddress["city"] ?? "",
              "firstname": shippingaddress["firstname"] ?? "",
              "lastname": shippingaddress["lastname"] ?? "",
              "email": result["email"] ?? "",
              "prefix": "",
              "region_code": (shippingaddress["region"] ?? []).length > 0
                  ? (((shippingaddress["region"] ?? [])[0]) ?? {})["region_code"] ?? ""
                  : "",
              "sameAsBilling": isShiping.value ? 1 : 0
            },
            "billingAddress": {
              "region": billingaddress[""] ?? "",
              "region_id": billingaddress["region_id"] ?? 0,
              "country_id": billingaddress["country_id"] ?? "",
              "street": billingaddress["street"] ?? [""],
              "company": "Revered-Tech",
              "telephone": billingaddress["telephone"] ?? "",
              "postcode": billingaddress["postcode"] ?? "",
              "city": billingaddress["city"] ?? "",
              "firstname": billingaddress["firstname"] ?? "",
              "lastname": billingaddress["lastname"] ?? "",
              "email": billingaddress["email"] ?? "",
              "prefix": "",
              "region_code": (billingaddress["region"] ?? []).length > 0
                  ? (((billingaddress["region"] ?? [])[0]) ?? {})["region_code"] ?? ""
                  : "",
            },
            "shipping_method_code": "flatrate",
            "shipping_carrier_code": "flatrate"
          }
        };
        sfStoreInSharedPrefData(
            fieldName: 'shipping_address',
            value: jsonEncode(addressInfo['addressInformation']['shippingAddress']),
            type: PreferencesDataType.STRING);

        sfStoreInSharedPrefData(
            fieldName: 'phone_no_code', value: phoneNumberCodeController.value.text, type: PreferencesDataType.STRING);
        sfStoreInSharedPrefData(
            fieldName: 'phone_no_code_billing',
            value: billingPhoneNumberCodeController.value.text,
            type: PreferencesDataType.STRING);
        sfStoreInSharedPrefData(
            fieldName: 'billing_address',
            value: jsonEncode(addressInfo['addressInformation']['billingAddress']),
            type: PreferencesDataType.STRING);
      } else {
        Get.snackbar('Error', '${result[0]["message"]}', isDismissible: true);
      }
      isRecentLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    } finally {
      isRecentLoading = false;
      update();
    }
  }

  saveFCMToken() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      String token = await APITokens.customerSavedToken;
      Uri url = Uri.parse('${APIEndPoints.setUserFCMToken}');
      int customerid = -1;
      Map<String, dynamic> customerIdMap =
          await sfQueryForSharedPrefData(fieldName: 'customer-id', type: PreferencesDataType.INT);

      if (customerIdMap['found']) {
        customerid = customerIdMap["customer-id"] ?? -1;
        print("FCM == Test");
        print(customerid);
        print(fcmToken ?? "No Token");
      }

      http.Response response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(
              {"data": "{'fcmtoken':'${fcmToken}','customer_id':'${customerid}','subscriber_ip':'','visitor_id':''}"}));
      print("FCM == Response Body");
      print(response.body);
      print(response.statusCode);
    } catch (e) {
      print("FCM == ISSUE");

      print(e);
    }
  }

  getUserQuestionsInformations() async {
    isRecentLoading = true;
    update();

    try {
      var result = await sfAPIGetUserDetails(await APITokens.customerSavedToken);

      if (result != null) {
        profileModle = Profile.fromJson(result);

        try {
          if (profileModle?.customAttributes!.length != 0) {
            makeOverProvider.tryitOn.value = profileModle?.customAttributes?[1].value != null ? true : false;
          }
        } on Exception catch (e) {
          makeOverProvider.tryitOn.value = false;
        }
      } else {
        Get.snackbar('Error', '${result[0]["message"]}', isDismissible: true);
      }
      isRecentLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    } finally {
      isRecentLoading = false;
      update();
    }
  }

  getGenderCount() {
    if (selectedGender == "FEMALE") {
      return 0;
    } else if (selectedGender == "MALE") {
      return 1;
    } else if (selectedGender == "GENDERLESS") {
      return 2;
    } else if (selectedGender == "LBGT") {
      return 3;
    }
  }

  //104
  getUserCardDetailes() async {
    try {
      http.Response? response = await NetworkHandler.getMethodCall(
          url: "https://sofiqe.com/rest/V1/getcardinformation?number=1&name=1&expiry_date=1&type=1",
          // "https://dev.sofiqe.com/rest/V1/getcardinformation?number=1&name=1&expiry_date=1&type=1",
          headers: APIEndPoints.headers(await APITokens.customerSavedToken));
      print("MM after api  ${response!.statusCode}");
      if (response.statusCode == 200) {
        Iterable types = json.decode(response.body);
        atmCards = types.map((e) => AtmCard.fromJson(e)).toList();
        print("atm length ==  ${atmCards.length}");
        if (atmCards.length > 0) {
          cardNumberController.text = atmCards[0].number.toString();
          monthCardController.text = atmCards[0].expiryDate.toString();
          cvcController.text = atmCards[0].cvc.toString();
          cardNameController.text = atmCards[0].name.toString();
        } else {
          // Get.snackbar('Error', 'No Card Found');
        }
      } else {
        var result = json.decode(response.body);
        Get.snackbar('Error', '${result[0]["message"]}', isDismissible: true);
      }
      print("Responce of API is ${response.body}");
    } catch (e) {
    } finally {
      isRecentLoading = false;
      update();
    }
  }

  // 105
  Future<bool> updateCardDetailes() async {
    var body = {
      "card": {
        "number": cardNumberController.text.replaceAll(" ", ""),
        "expiry_date": monthCardController.text,
        "cvc": cvcController.text,
        "name": cardNameController.text,
      }
    };
    print("MMcard=${body.toString()}");
    try {
      http.Response? response = await NetworkHandler.postMethodCall(
          body: body,
          // url: "https://dev.sofiqe.com/rest/V1/getcardinformation",
          url: "https://sofiqe.com/rest/V1/getcardinformation",
          headers: APIEndPoints.headers(await APITokens.customerSavedToken));

      if (response?.statusCode == 200) {
        Get.showSnackbar(
          GetSnackBar(
            message: 'User profile updated Successfully',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.white,
          ),
        );

        print("LOGGG");
        return true;
      } else {
        print("EROORRR");
        var result = json.decode(response!.body);
        Get.showSnackbar(
          GetSnackBar(
            message: '${result["message"]}',
            duration: Duration(seconds: 2),
          ),
        );
        return false;
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Card api not working \n ${e.toString()}',
          duration: Duration(seconds: 2),
        ),
      );
      isRecentLoading = false;
      update();
      return false;
    }
  }

  getRecenItems() async {
    isRecentLoading = true;
    update();
    print("_____________________________________");
    print("\t\tBeareer Token ${APITokens.bearerToken}\t\t");
    print("_____________________________________");

    try {
      http.Response? response = await NetworkHandler.getMethodCall(
          url: "https://sofiqe.com/rest/default/V1/customer/getscannedproduct/",
          // "https://dev.sofiqe.com/rest/default/V1/customer/getscannedproduct/",
          headers: APIEndPoints.headers(await APITokens.customerSavedToken));
      print("after api  ${response!.statusCode}");
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        recentItem = RecentItemModel.fromJson(result[0]);
      } else {
        var result = json.decode(response.body);
        Get.snackbar('Error', '${result[0]["message"]}');
      }
      print("Responce of API is ${response.body}");
    } catch (e) {
    } finally {
      isRecentLoading = false;
      update();
    }
  }
}
