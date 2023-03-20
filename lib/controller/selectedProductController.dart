import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/model/selectedProductModel.dart';
import 'package:sofiqe/network_service/network_service.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';

class SelectedProductController extends GetxController {
  var tryMySelectionList=[].obs;
  var IstryMySelection=false.obs;
  var isreplace=false.obs;
  var isreplace_1=false.obs;
  var index1=0.obs;
  var index=0.obs;
  List temp=[].obs;
  List temp1=[].obs;
  List temp2=[].obs;
  List value=[].obs;
  static SelectedProductController get to => Get.find();
  Color? _selectedColor;
  SelectedProduct? selectedProduct;

  /* selected color to try on product */
  Color? get selectedColor => _selectedColor;

  /* selected color to try on product */
  bool isSelectedProductLoading = false;

  RxBool loadin = true.obs;
  RxBool isNavBarShow = false.obs;

  // final TryItOnProvider tmo = Get.find();

  ///
  /// Customize the request body
  /// [body] is the request body
  /// [url] is the url of the request
  /// [method] is the method of the request
  /// [token] is the token of the request
  /// [isAuth] is the authentication of the request

  SelectedProductController() {
    getSelectedProduct();
  }
  setSelectedColor(Color color) {
    this._selectedColor = color;
  }

  getSelectedProduct() async {
    selectedProduct = null;
    // final TryItOnProvider tmo = Get.find();
    isSelectedProductLoading = true;
    loadin.value = true;
    // tmo.Lookloading.value=true;

    update();
    try {
      http.Response? response = await NetworkHandler.getMethodCall(
          url: "https://sofiqe.com/rest/V1/customer/getselectedproducts",
          // "http://dev.sofiqe.com/rest/V1/customer/getselectedproducts",
          headers: APIEndPoints.headers(await APITokens.customerSavedToken));
      var tokem=await APITokens.customerSavedToken;
      print("APITokens.customerSavedToken ${tokem}");
      print("after api getselectedproducts  ${response!.statusCode}");
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result['error'] == true) {
          selectedProduct = null;
        } else {
          try {
            //selectedProduct=null;
            print("LENGTH  ITEM 111${selectedProduct?.items?.length}");
            selectedProduct = SelectedProduct.fromJson(result);
            print("LENGTH  ITEM ${selectedProduct?.items?.length}");
          } catch (e) {
            selectedProduct = null;
          }
        }
      } else {
        // var result = json.decode(response.body);
        print("Selected product api result ${response.statusCode}");
      }
      print("Responce of API is ${response.body}");
    } catch (e) {
      selectedProduct = null;
      print("Selected product api error " + e.toString());
      update();
    } finally {
      isSelectedProductLoading = false;
      loadin.value = false;
      update();
    }
  }
  @override
  void onInit() {
   
    getSelectedProduct();
    super.onInit();
  }
}
