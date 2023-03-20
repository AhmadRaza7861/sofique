import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/model/shoppingHistoryModel.dart';
import 'package:sofiqe/network_service/network_service.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';
import 'package:http/http.dart' as http;

import '../utils/states/local_storage.dart';

class ShoppingHistory extends GetxController {
  static ShoppingHistory get to => Get.find();

  bool isShoppingListLoading = false;
  String isShoppingListError = "Forbidden";
  ShoppingHistoryModel? historyList;

  getShoppingHistory() async {
    isShoppingListLoading = true;
    update();
    var result;
    try {
      Map uidMap = await sfQueryForSharedPrefData(fieldName: 'uid', type: PreferencesDataType.INT);
      int uid = uidMap['uid'];
      print('uuuuuu id  $uid');
      http.Response? response = await NetworkHandler.getMethodCall(
          url: "https://sofiqe.com/rest/V1/ms2/orders/customer/$uid",
          // url: "https://dev.sofiqe.com/rest/V1/ms2/orders/customer/$uid",
          headers: APIEndPoints.headers(await APITokens.customerSavedToken));
      print("after api  ${response!.statusCode}");
      print("after api  https://sofiqe.com/rest/V1/ms2/orders/customer/$uid");
      // "after api  https://dev.sofiqe.com/rest/V1/ms2/orders/customer/$uid");
      if (response.statusCode == 200) {
        result = json.decode(response.body);
        print("2222222222" + response.body.toString());
        print("333333333333");
        try {
          print("historyList");
          (result[0]["result"] == "error")
              ? historyList = null
              : historyList = ShoppingHistoryModel.fromJson(result[0]);
        } catch (e) {
          historyList = null;
          Get.snackbar('Error', '${result[0]["message"]}', isDismissible: true);
        }
      } else if (response.statusCode == 401) {
        historyList = null;
        Get.snackbar('Error', 'User Session Token Expire', isDismissible: true);
      } else {
        historyList = null;
        var result = json.decode(response.body);
        Get.snackbar('Error', '${result[0]["message"]}', isDismissible: true);
      }
      print("Responce of API is ${response.body}");
    } catch (e) {
    } finally {}
    isShoppingListLoading = false;
    update();
  }

  orderAgain(BuildContext context, String orderId) async {
    try {
      http.Response? response = await NetworkHandler.postMethodCall(
          url: "https://sofiqe.com/rest/V1/customers/$orderId/buyagain",
          // url: "https://dev.sofiqe.com/rest/V1/customers/$orderId/buyagain",
          headers: APIEndPoints.headers(await APITokens.customerSavedToken));

      if (response!.statusCode == 200) {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Please go to cart for checkout.',
            duration: Duration(seconds: 2),
            isDismissible: true,
          ),
        );
        Provider.of<CartProvider>(context, listen: false).fetchCartDetails();
      } else if (response.statusCode == 401) {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Something went wrong.',
            duration: Duration(seconds: 2),
            isDismissible: true,
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Something went wrong.',
            duration: Duration(seconds: 2),
            isDismissible: true,
          ),
        );
      }
    } catch (e) {}
  }

  @override
  void onInit() {
    super.onInit();
    //getShoppingHistory();
  }
}
