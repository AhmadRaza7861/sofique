// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sofiqe/model/profile.dart';
import 'package:sofiqe/model/user_model.dart';
import 'package:sofiqe/provider/wishlist_provider.dart';
import 'package:sofiqe/utils/api/user_account_api.dart';
import 'package:sofiqe/utils/states/local_storage.dart';

import '../utils/api/free_shipping_amount_api.dart';

class AccountProvider extends ChangeNotifier {
  late String userToken;
  late int customerId;
  bool isLoggedIn = false;
  late bool goldPremium;
  User? user;
  String freeShippingAmount = '';
  Profile? profileModle;
  String? shipAddress;

  AccountProvider() {
    _initData();
  }

  _initData() async {
    // userToken = '';
    customerId = -1;
    isLoggedIn = false;
    goldPremium = false;
    await checkSavedAccount();
    await getFreeShippingInfo();
  }

  Future<bool> getFreeShippingInfo() async {
    try {
      List freeShippingResponse = await sfAPIGetFreeShippingInfo();

      if (freeShippingResponse.isNotEmpty) {
        // String status = freeShippingResponse[0]['status'];
        freeShippingAmount = freeShippingResponse[0]['amount'];
        // String message = freeShippingResponse[0]['message'];
      }
    } catch (e) {}
    return true;
  }

  Future<void> checkSavedAccount() async {
    Map userTokenMap = await sfQueryForSharedPrefData(fieldName: 'user-token', type: PreferencesDataType.STRING);
    if (userTokenMap['found']) {
      getUserDetails(userTokenMap['user-token']);
      userToken = userTokenMap['user-token'];
      // print("USERTOKEN = " + userToken.toString());
    }
  }

  //160
  Future<void> getUserDetails(String userToken) async {
    try {
      var result = await sfAPIGetUserDetails(userToken);

      // print("getUserDetails getUserDetails ${result}");

      if (result != null) {
        profileModle = Profile.fromJson(result);
        await sfStoreInSharedPrefData(
            fieldName: 'customer-id', value: profileModle?.id ?? -1, type: PreferencesDataType.INT);
        customerId = profileModle?.id ?? -1;
        if (profileModle?.addresses != null && profileModle?.addresses?.length != 0) {
          shipAddress = profileModle?.addresses?[0].street?[0] ?? "";
          if (shipAddress!.isNotEmpty) {
            shipAddress = shipAddress! + ", ";
          }
          try {
            shipAddress = shipAddress! + (profileModle?.addresses?[0].street?[1] ?? "");
            if (shipAddress!.isNotEmpty) {
              shipAddress = shipAddress! + ", ";
            }
          } catch (e) {}
          shipAddress = shipAddress! + (profileModle?.addresses?[0].city ?? "");
          if (shipAddress!.isNotEmpty) {
            shipAddress = shipAddress! + ", ";
          }
          //
          shipAddress = shipAddress! + (profileModle?.addresses?[0].postcode ?? "");
          if (shipAddress!.isNotEmpty) {
            shipAddress = shipAddress! + ", ";
          }
          //
          shipAddress = shipAddress! + (profileModle?.addresses?[0].region!.region ?? "");
          if (shipAddress!.isNotEmpty) {
            shipAddress = shipAddress! + ", ";
          }
          shipAddress = shipAddress! + (profileModle?.addresses?[0].countryId ?? "");
          // print("SHIP=$shipAddress");
        }
      } else {
        // Get.snackbar('Error', '${result[0]["message"]}', isDismissible: true);
      }
    } catch (e) {
      print(e.toString());
    }

    try {
      Map userMap = await sfAPIGetUserDetails(userToken);
      // print("UPRESPONSE");
      // print(userMap);
      user = User(
        id: userMap['id'],
        email: userMap['email'] ?? "",
        firstName: userMap['firstname'] ?? "",
        lastName: userMap['lastname'] ?? "",
        addresses: userMap['addresses'] ?? [],
      );
      // print(user!.email);
      customerId = user!.id;
      isLoggedIn = true;
      await sfStoreInSharedPrefData(fieldName: 'uid', value: userMap['id'], type: PreferencesDataType.INT);
      await sfStoreInSharedPrefData(fieldName: 'email', value: userMap['email'], type: PreferencesDataType.STRING);
      await sfStoreInSharedPrefData(
          fieldName: 'name',
          value: '${userMap['firstname'] ?? ""} ${userMap['lastname']}',
          type: PreferencesDataType.STRING);

      notifyListeners();
    } catch (e) {
      print("EXCEPTION USER DATA ${e}");
      //  await sfRemoveFromSharedPrefData(fieldName: 'user-token');
    }
  }

  Future<void> saveProfilePicture() async {
    var dir = (await getExternalStorageDirectory());
    File file = File(join(dir!.path, 'front_facing.jpg'));
    log('========  save profile/selfie picture API called  =======');
    sfAPISaveProfilePicture(file, customerId);
  }

  Future<bool> login(String username, String password, BuildContext c) async {
    print("LOGIN RESULT 1111");
    var result = await sfAPILogin(username, password, c);
    print("LOGIN RESULT ${result}");
    if (result != 'error') {
      print("LOGIN RESULT 1111 Not error");
      isLoggedIn = true;
      userToken = result;
      await sfStoreInSharedPrefData(fieldName: 'user-token', value: result, type: PreferencesDataType.STRING);
      print("LOGIN RESULT 1111 sfStoreInSharedPrefData set ");
      await getUserDetails(userToken);
      print("LOGIN RESULT 1111  getuser detail ");
      notifyListeners();

      /// Fetch wishlist
      WishListProvider wp = Get.find();
      print("LOGIN RESULT 1111  Fetch wishlist ");
      wp.login();
      print("LOGIN RESULT 1111  Fetch wishlist AFTER ");

      ///

      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    userToken = '';
    customerId = -1;
    isLoggedIn = false;
    goldPremium = false;
    user = null;
    await sfRemoveFromSharedPrefData(fieldName: 'user-token');
    await sfRemoveFromSharedPrefData(fieldName: 'uid');

    /// Remove wishlist
    WishListProvider wp = Get.find();
    wp.logout();

    ///

    notifyListeners();
  }

  Future<bool> subscribe(Map<String, String> cardDetails) async {
    Map<String, String> cardMap = {
      "customerId": "$customerId",
      "ccNu": "${cardDetails['card_number']}",
      "cvvNu": "${cardDetails['cvv']}",
      "expDate": "${(cardDetails['expiration_date'] as String).replaceAll('/', '')}",
      "isSubcribe": "1",
    };
    try {
      bool success = await sfAPISubscribeCustomerToGold(cardMap);
      if (success) {
        goldPremium = true;
        notifyListeners();
      } else {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Could not complete request, please try again',
            duration: Duration(seconds: 2),
          ),
        );
      }
      return success;
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Could not complete subsciption process: $e',
          duration: Duration(seconds: 2),
        ),
      );
    }
    return false;
  }
}
