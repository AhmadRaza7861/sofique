// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';

import '../utils/api/free_shipping_amount_api.dart';

String localWishList = 'local-wishlist';

class FreeShippingProvider extends GetxController {
  static String shippingValue = "";

  static FreeShippingProvider instance = Get.find();
 
  var status = false;

  FreeShippingProvider() {
    _initData();
  }

  _initData() async {
    await this.getFreeShippingInfo();
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

  Future<bool> getFreeShippingInfo() async {
    try {
      List freeShippingResponse = await sfAPIGetFreeShippingInfo();

      if (freeShippingResponse.isNotEmpty) {
        status = freeShippingResponse[0]['status'];
        shippingValue = freeShippingResponse[0]['amount'].toString();
        // String message = freeShippingResponse[0]['message'];

        print(shippingValue);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
