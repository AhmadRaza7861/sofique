import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
// Utils
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';

import '../../model/product_model.dart';

List<StockItem> mStockItem = [];
bool isWarning = false;

class StockItem {
  late int? qty;
  late double? price;

  StockItem({
    required this.qty,
    required this.price,
  });
}

// Change this to a POST TOKEN
Future<http.Response> sfAPIGetProductDetailsFromSKU(
    {required String sku}) async {
  print('sku $sku');
  Uri url = Uri.parse('${APIEndPoints.productBySKU}$sku');
  http.Response response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${APITokens.adminBearerId}',
  });
  print('${APIEndPoints.productBySKU}$sku');
  print(APITokens.adminBearerId);
  // print(response.body.toString());
  Map<String, dynamic> responseBody = json.decode(response.body);
  // Product product = Product.fromDefaultMap(responseBody);

  if (responseBody['type_id'] == 'configurable') {
    try {
      dynamic config = await sfAPIGetConfigurableProductListFromSKU(sku: sku);
      // print("Configurable " + config.toString());
      if (config != null && config.length > 0) {
        mStockItem = [];
        config.forEach((element) {
          if (element.containsKey('extension_attributes')) {
            Product extensionAttribue = Product.fromJson(element);
            // print("Configurable " + extensionAttribue.toString());
            mStockItem.add(StockItem(
                qty: extensionAttribue.qty, price: extensionAttribue.price));
            // print(extensionAttribue.qty.toString());
            // print("TZS Atttiute children responsebody--" +
            // mStockItem.length.toString());
          }
        });
        // print("Configurable " + config.toString());
      } else {
        // print("TZS ELSEEE---");
      }
      return response;
    } catch (e) {
      return response;
    }
  } else {
    return response;
  }
}

// Future<bool> sfAPIGetProductIngredientsWarningFromSKU(
//     {required String sku}) async {
//   Uri url = Uri.parse('${APIEndPoints.productWarning}');
//   var token = await APITokens.customerSavedToken;
//   var headers =  {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization': 'Bearer $token',
//   };
//
//   var request = http.Request('GET', url);
//   request.body = json.encode({
//     "sku": '$sku'
//   });
//   request.headers.addAll(headers);
//
//   print('${APIEndPoints.productWarning}');
//   print(APITokens.customerSavedToken);
//   print(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//
//     String myResponse = await response.stream.bytesToString();
//     print(myResponse);
//     List<dynamic> list = json.decode(myResponse);
//     //isWarning = list[0]['warning'];
//     isWarning = list[0]['warning'];
//     print("Warning---"+isWarning.toString());
//
//     //isWarning = decoded[0]['warning'];
//   }
//   else {
//     print(response.reasonPhrase);
//   }
//   return true;
// }

Future<List<dynamic>> sfAPIGetConfigurableProductListFromSKU(
    {required String sku}) async {
  Uri url = Uri.parse('${APIEndPoints.getConfigurableProductChildren(sku)}');
  http.Response response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${APITokens.adminBearerId}',
  });
  print('${APIEndPoints.getConfigurableProductChildren(sku)}');

  var tagsJson = jsonDecode(response.body);
  List<dynamic> productList = List.from(tagsJson);
  return productList;
}

List<StockItem> getStockItemList() {
  return mStockItem;
}

bool getPoductWarning() {
  return isWarning;
}

Future<dynamic> sfAPIGetProductStatic() async {
  Uri url = Uri.parse('${APIEndPoints.productStatic}');
  try {
    http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${APITokens.bearerToken}',
        },
        body: jsonEncode({
          'value': '1',
        }));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Could not load data:' + response.body;
    }
  } catch (e) {
    print(e);
  }
}

Future sfAPIScanProduct(
    String token,
    // Map<String, String> scanResult,
    dynamic customerId,
    String brandName,
    String ingredients) async {
  // try {

  Uri url = Uri.parse('${APIEndPoints.scanProduct}');

  log('========== customer id is :: $customerId');

  ///-------new
  try {
    ///----------second old
    http.Response response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
        body: {
          "customer_id": "$customerId",
          "name_string": brandName,
          "ingredient_string": ingredients,
          "detected_color": "#B4753E"
          // hard coded until the camera is sending the hex code to us.
        });

    if (response.statusCode == 200) {
      log('======== scan product api response ::  ${jsonDecode(response.body)}  =======');
      List responseBody = jsonDecode(response.body);
      log('======== response body is ::  ${responseBody}  =======');
      return responseBody;
    } else {
      throw 'Could not load data:' + response.body;
    }

    ///-------old
    // Uri url = Uri.parse('${APIEndPoints.scanProduct}');
    // // Uri url = Uri.parse('http://3.109.228.199/rest/V1/custom/scanProduct');
    // print(url.toString());
    // Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $token',
    // };
    // http.Request request = http.Request(
    //   'POST',
    //   url,
    // );
    // request.body = json.encode(scanResult);
    // request.headers.addAll(headers);
    //
    // http.StreamedResponse response = await request.send();
    //
    // if (response.statusCode != 200) {
    //   throw await response.stream.bytesToString();
    // }
    //
    // log('..................   SCAN PRODUCT API RESPONSE :: ${json.decode(await response.stream.bytesToString())}   ...............');
    //
    // List responseBody = json.decode(await response.stream.bytesToString());
    // log('..................   SCAN PRODUCT API RESPONSE :: $responseBody   ...............');
    // return responseBody;
  } catch (err) {
    log('======  error is $err   ======');
    rethrow;
  }
}
