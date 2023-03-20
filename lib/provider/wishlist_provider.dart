// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofiqe/utils/api/wishlist_api.dart';
import 'package:sofiqe/utils/states/local_storage.dart';

String localWishList = 'local-wishlist';

class WishListModel {
  String sku;
  String id;

  WishListModel(this.sku, this.id);

  String getSku() {
    return this.sku;
  }
}

class WishListProvider extends GetxController {
  static WishListProvider instance = Get.find();

  RxList<WishListModel> wishlistSkuList = <WishListModel>[].obs;
  RxBool wishlistAvailable = false.obs;
  RxString userToken = ''.obs;

  WishListProvider() {
    _initData();
  }

  _initData() async {
    this.defaults();
    await this.getUserToken();
  }

  ///
  /// Customize the request body
  /// [body] is the request body
  /// [url] is the url of the request
  /// [method] is the method of the request
  /// [token] is the token of the request
  /// [isAuth] is the authentication of the request
  ///
  ///
  Future<bool> addItemToWishList(String sku, int id, int customerId) async {
    try {
      wishlistSkuList.add(WishListModel(sku, "0"));
      await sfAPIAddItemToWishList(int.parse(sku), customerId);
      await getWishList();
      return true;
    } catch (err) {
      wishlistSkuList.removeWhere((element) => element.sku == sku);
      Get.showSnackbar(
        GetSnackBar(
          message: 'Could not add item to wishlist. Please try again',
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  Future<bool> removeItemToWishList(String sku) async {
    try {
      var temp = wishlistSkuList.firstWhere((element) => element.sku == sku, orElse: () => WishListModel(sku, "0"));
      wishlistSkuList.removeWhere((element) => element.sku == sku);
      await sfAPRemoveItemToWishList(temp.id);
      await getWishList();
      return true;
    } catch (err) {
      wishlistSkuList.removeWhere((element) => element.sku == sku);
      Get.showSnackbar(
        GetSnackBar(
          message: 'Could not add item to wishlist. Please try again',
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  Future<void> saveInLocalWishList(String sku, int id, bool isAdd) async {
    try {
      if (isAdd) {
        wishlistSkuList.add(WishListModel(sku, "0"));
      } else {
        wishlistSkuList.removeWhere((element) => element.sku == sku);
      }

      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.containsKey(localWishList)) {
        List locallyStoredWishList = json.decode(pref.getString(localWishList) as String);

        if (isAdd) {
          locallyStoredWishList.add(
            {
              'sku': sku,
              'id': id,
            },
          );
        } else {
          locallyStoredWishList.remove(
            {
              'sku': sku,
              'id': id,
            },
          );
        }

        pref.setString(
          localWishList,
          json.encode(
            locallyStoredWishList,
          ),
        );
      } else {
        if (isAdd) {
          pref.setString(
            localWishList,
            json.encode(
              [
                {
                  'sku': sku,
                  'id': id,
                }
              ],
            ),
          );
        }
      }
    } catch (err) {
      wishlistSkuList.removeWhere((element) => element.sku == sku);

      print('Error saveInLocalWishList : $err');
    }
  }

  Future<void> getUserToken() async {
    Map customerTokenMap = await sfQueryForSharedPrefData(fieldName: 'user-token', type: PreferencesDataType.STRING);
    if (customerTokenMap['found']) {
      userToken.value = customerTokenMap['user-token'];
      this.getWishList();
    } else {
      defaults();
    }
  }

  void defaults() {
    wishlistSkuList.clear();
    userToken.value = '';
    wishlistAvailable.value = false;
  }

  Future<void> syncLocalWishList() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.containsKey(localWishList)) {
        List locallyStoredWishList = json.decode(pref.getString(localWishList) as String);
        pref.setString(
          localWishList,
          json.encode(
            locallyStoredWishList,
          ),
        );
        Map uidMap = await sfQueryForSharedPrefData(fieldName: 'uid', type: PreferencesDataType.INT);
        int uid = uidMap['uid'];
        locallyStoredWishList.forEach(
          (wishListItem) {
            this.addItemToWishList(wishListItem['sku'], wishListItem['id'], uid);
          },
        );
      }
    } catch (err) {
      print('Error syncLocalWishList : $err');
    }
  }

  Future<void> login() async {
    this.defaults();
    await this.getUserToken();
    await this.getWishList();
    await syncLocalWishList();
  }

  Future<void> logout() async {
    this.defaults();
  }

  Future<void> getWishList() async {
    try {
      Map<String, dynamic> response = await sfAPIFetchWishList(userToken.value);
      print(response);

      if (!response.containsKey('result')) {
        throw 'Result field not found';
      }
      List wishListItems = response['result'];
      this.wishlistSkuList.clear();
      wishListItems.forEach(
        (item) {
          this.wishlistSkuList.add(WishListModel(item['product']['sku'], item['wishlist_item_id']));
        },
      );
    } catch (e) {
      print('Error fetching wishlist: $e');
    }
  }
}
