import 'dart:convert';

import 'package:get/get.dart';
import 'package:sofiqe/network_service/network_service.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:http/http.dart' as http;
import '../utils/constants/api_tokens.dart';
import 'orderDetailModel.dart';

class OrderDetailController extends GetxController {
   static OrderDetailController get to => Get.find();
  
  OrderDetailModel? orderModel;
  bool isOrderLoading = false;

  ///
  /// Customize the request body
  /// [body] is the request body
  /// [url] is the url of the request
  /// [method] is the method of the request
  getOrderDetails(String orderId) async {
    isOrderLoading = true;
    update();
    try {
      http.Response? response = await NetworkHandler.getMethodCall(
          // url: "https://dev.sofiqe.com/rest/V1/ms2/orders/order/$orderId",
          url: "https://sofiqe.com/rest/V1/ms2/orders/order/$orderId",
          headers: APIEndPoints.headers(await APITokens.customerSavedToken));
      print("after api  ${response!.statusCode}");
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        orderModel = OrderDetailModel.fromJson(result[0]);
      } else {
        var result = json.decode(response.body);
        Get.snackbar('Error', '${result[0]["message"]}', isDismissible: true);
      }
      print("Responce of API is ${response.body}");
    } catch (e) {
      print("Catch : Responce of Order API is Error");
    }
    isOrderLoading = false;
    update();
  }







}
