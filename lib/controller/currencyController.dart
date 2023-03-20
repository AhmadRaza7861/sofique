import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/model/currency.dart' as me;
import 'package:sofiqe/network_service/network_service.dart';
import 'package:sofiqe/utils/states/local_storage.dart';

class CurrencyController extends GetxController {
  static CurrencyController get to => Get.find();
  @override
  void onInit() {
    super.onInit();
    getCurrency();
  }

  var currency = [].obs;
  var isCurrencyLoading = false.obs;
  String? defaultCurrency = "\$";
  RxString defaultCurrencySymbol = "\$".obs;

  RxString defaultCurrencyCode = "USD".obs;
  RxDouble exchangeRateinDouble = 1.25.obs;
  List exchangeRate = [].obs;

  Rx<me.Currency> currencyModelNew = me.Currency().obs;

  get availableCurrencyCodes => null;

  getCurrency() async {
    isCurrencyLoading(true);

    ///
    /// await APITokens.customerSavedToken
    ///
    /// Customize the request body
    ///
    // try {
    http.Response? response = await NetworkHandler.getMethodCall(
      // url: "https://dev.sofiqe.com/index.php/rest/V1/directory/currency",
      url: "https://sofiqe.com/index.php/rest/V1/directory/currency",
      // headers: APIEndPoints.headers(await APITokens.customerSavedToken)
    );
    // print("after api  ${(await APITokens.customerSavedToken)}");
    print("after api  ${response!.statusCode}");
    print("after api body  ${response.body}");
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      me.Currency model = me.Currency.fromJson(result);
      currencyModelNew.value = model;
      // defaultCurrency = model.defaultDisplayCurrencySymbol;
      // defaultCurrencySymbol.value = model.defaultDisplayCurrencySymbol ?? "\$";
      // defaultCurrencyCode.value = model.baseCurrencyCode ?? "USD";
      // exchangeRateinDouble.value =
      //     (model.baseCurrencyCode == "GBP") ? 1.0 : 1.25;
      Map userTokenMap = await sfQueryForSharedPrefData(
          fieldName: 'currency-code', type: PreferencesDataType.STRING);
      if (userTokenMap['found']) {
        defaultCurrency = model.defaultDisplayCurrencySymbol;
        defaultCurrencySymbol.value =
            model.defaultDisplayCurrencySymbol ?? "\$";
        defaultCurrencyCode.value = userTokenMap['currency-code'] ?? "USD";
      } else {
        defaultCurrency = model.defaultDisplayCurrencySymbol;
        defaultCurrencySymbol.value =
            model.defaultDisplayCurrencySymbol ?? "\$";
        defaultCurrencyCode.value = model.baseCurrencyCode ?? "USD";
      }
      Map userTokenMapexchangeRate = await sfQueryForSharedPrefData(
          fieldName: 'exchange-rate', type: PreferencesDataType.DOUBLE);
      if (userTokenMapexchangeRate['found']) {
        exchangeRateinDouble.value =
            userTokenMapexchangeRate["exchange-rate"] ?? 0.0;
      } else {
        exchangeRateinDouble.value =
            (model.baseCurrencyCode == "GBP") ? 1.0 : 1.25;
      }
      // exchangeRate = model.exchangeRates;
      //customAttributes1 = json.decode(naturalMeModelNew.value.customAttributes![1].value.toString());
      // var dataSp = naturalMeModelNew.value.customAttributes![1].value!.split(',');
      //  String mapData = '';
      //   dataSp.forEach((element) {
      //     if(element.toString()!='{}'){
      //       var a=element.split(':').last.toString().replaceAll('[', '').replaceAll(']', '').replaceAll('{', '').replaceAll('}', '').replaceAll(',', '');
      //     print("AAAAA---->"+a.length.toString());
      //     if(a.toString()!=" "){
      //       aller.add(a.replaceAll('\"', ''));
      //     }

      //     //  mapData=mapData+ element.split(':')[1];
      //       // mapData[element.split(':')[0]] = element.split(':')[1];
      //     }
      //     print('element---->'+element.toString());

      //   });
      update();

      //   print('naturalMeModelNew---->'+mapData.toString());

      // for (int i = 0; i < result.length; i++) {
      //   NaturalMeModel model = NaturalMeModel.fromJson(result[i]);
      //   naturalMe.add(model);
      // }
      isCurrencyLoading(false);
      print("_____________________________________");
      print(result);
      print("_____________________________________");
    } else {
      var result = json.decode(response.body);
      Get.snackbar('Error', '${result["message"]}', isDismissible: true);
      isCurrencyLoading(false);
    }
    print("Responce of API is--- ${response.body}");
    // } catch (e) {
    //   isCurrencyLoading(false);

    //   print("XXXXXXXXXXXXXXXXXXXXXXXXXXX");
    //   print("Error in get Currency me $e");
    //   print("XXXXXXXXXXXXXXXXXXXXXXXXXXX");
    // } finally {
    //   isCurrencyLoading(false);
    // }
  }
}
