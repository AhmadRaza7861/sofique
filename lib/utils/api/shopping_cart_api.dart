import 'dart:convert';
import 'dart:developer';

// =======
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
import 'package:http/http.dart' as http;
// Utils
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';
import 'package:sofiqe/utils/states/local_storage.dart';

import '../../model/my_review_by_sku.dart';
import '../../network_service/network_service.dart';

Future<String> sfAPIInitializeGuestShoppingCart() async {
  Map<String, dynamic> prefResultMap =
      await sfQueryForSharedPrefData(fieldName: 'cart-token', type: PreferencesDataType.STRING);
  if (prefResultMap['found']) {
    return prefResultMap['cart-token'];
  }

  String cartToken = await _sfAPICreateRemoteCart();
  if (cartToken != 'error') {
    sfStoreInSharedPrefData(fieldName: 'cart-token', value: '$cartToken', type: PreferencesDataType.STRING);
    return cartToken;
  }

  return 'error';
}

Future<List<dynamic>> sfAPIGetGuestCartList(String cartToken) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.guestCartList(cartToken)}');
    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APITokens.adminBearerId}',
      },
    );
    // print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> responseMap = json.decode(response.body);
      return responseMap;
    } else {
      return [];
    }
  } catch (err) {
    print('Error sfAPIGetGuestCartList: $err');
    rethrow;
  }
}

Future<Map> sfAPIGetGuestVipCoins() async {
  try {
    var token = APITokens.adminBearerId;
    Uri url = Uri.parse('${APIEndPoints.guestVipToken()}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      //'Bearer ${APITokens.bearerToken}',
    };

    print('${APIEndPoints.guestVipToken()}');
    print('$token');
    http.Request request = http.Request('GET', url);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }

    Map responseBody = json.decode(await response.stream.bytesToString());
    if (!responseBody.containsKey('items')) {
      throw 'Key not found: items';
    }
    // print(responseBody);

    return responseBody;
  } catch (err) {
    rethrow;
  }
}

Future<Map> sfAPIGetTiersList() async {
  try {
    var token = APITokens.adminBearerId;
    Uri url = Uri.parse('${APIEndPoints.getTiersList()}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      //'Bearer ${APITokens.bearerToken}',
    };

    print('${APIEndPoints.getTiersList()}');
    print('$token');
    http.Request request = http.Request('GET', url);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }

    Map responseBody = json.decode(await response.stream.bytesToString());
    if (!responseBody.containsKey('items')) {
      throw 'Key not found: items';
    }
    print(responseBody);

    return responseBody;
  } catch (err) {
    rethrow;
  }
}

Future<Map> sfAPISpendingRules() async {
  try {
    var token = APITokens.adminBearerId;
    Uri url = Uri.parse('${APIEndPoints.spendingRules()}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      //'Bearer ${APITokens.bearerToken}',
    };

    // print('${APIEndPoints.spendingRules()}');
    // print('$token');
    http.Request request = http.Request('GET', url);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }

    Map responseBody = json.decode(await response.stream.bytesToString());
    if (!responseBody.containsKey('items')) {
      throw 'Key not found: items';
    }
    // print(responseBody);

    return responseBody;
  } catch (err) {
    rethrow;
  }
}

Future<int> sfAPIGetCustomerPoints(customerID) async {
  try {
    var token = APITokens.adminBearerId;
    Uri url = Uri.parse('${APIEndPoints.getCustomerPoints(customerID)}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      //'Bearer ${APITokens.bearerToken}',
    };

    print('${APIEndPoints.getCustomerPoints(customerID)}');
    print('$token');
    http.Request request = http.Request('GET', url);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }

    int responseBody = json.decode(await response.stream.bytesToString());
    log("TZS--" + responseBody.toString());

    return responseBody;
  } catch (err) {
    rethrow;
  }
}

Future<List<dynamic>> sfAPIGetUserCartList() async {
  try {
    Uri url = Uri.parse('${APIEndPoints.userCartList}');
    print(url);
    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await APITokens.customerSavedToken}',
      },
    );

    // print(APITokens.customerSavedToken);

    List<dynamic> responseMap = json.decode(response.body);
    // print("SHUBHAM CART");
    // print(responseMap.length);
    return responseMap;
  } catch (err) {
    print('Error sfAPIGetUserCartList: $err');
    rethrow;
  }
}

Future<Map<String, dynamic>> sfAPIGetGuestCartDetails(String cartToken) async {
  Uri url = Uri.parse('${APIEndPoints.guestCartDetails}$cartToken');
  http.Response response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    },
  );

  Map<String, dynamic> responseMap = json.decode(response.body);
  return responseMap;
}

Future<Map<String, dynamic>> sfAPIGetUserCartDetails() async {
  Uri url = Uri.parse('${APIEndPoints.userCartDetails}');
  http.Response response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await APITokens.customerSavedToken}',
    },
  );

  Map<String, dynamic> responseMap = json.decode(response.body);
  return responseMap;
}

Future<String> sfAPIcartIDUser() async {
  Uri url = Uri.parse('${APIEndPoints.userCartDetails}');
  http.Response response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await APITokens.customerSavedToken}',
    },
  );

  Map<String, dynamic> responseMap = json.decode(response.body);
  // print("===========CartId USer===========${responseMap['id']}");
  return responseMap['id'].toString();
}

Future<String> _sfAPICreateRemoteCart() async {
  Uri url = Uri.parse('${APIEndPoints.guestCartNewInstance}');
  http.Response response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    },
  );
  if (response.statusCode == 200) {
    String token = json.decode(response.body);
    // print("==========Gtoken==========$token");
    return token;
  } else {
    return 'error';
  }
}

Future<Map> sfAPIGetUserVipCoins(cartId, customerID) async {
  try {
    // var token = APITokens.adminBearerId;
    Uri url = Uri.parse('${APIEndPoints.userVipToken(cartId: cartId)}');
    // print('${APIEndPoints.userVipToken(cartId: cartId)}');
    // print('$token');

    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APITokens.bearerToken}',
      },
      body: json.encode(
        {
          'cartId': '$cartId',
          'addressInformation': {
            'address': {'customer_id': customerID}
          }
        },
      ),
    );

    if (response.statusCode != 200) {
      throw json.decode(response.body);
    }
    Map responseBody = json.decode(response.body);
    log("TZS-----" + responseBody.toString());
    if (!responseBody.containsKey('total_segments')) {
      throw 'Key not found: total_segments';
    }
    return responseBody;
  } catch (err) {
    rethrow;
  }
}

// Change this to a POST TOKEN
Future<void> sfAPIAddItemToCart(
    String token, int qouteId, String sku, List simpleProductOptions, int type, String userType, String lookName,
    {int quantity = 0}) async {
  Uri url = Uri.parse('');
  if (userType == 'Guest') {
    url = Uri.parse('${APIEndPoints.addToCartGuest(cartId: token)}');
    print('addToCartGuest  ${url.toString()}');
  } else {
    url = Uri.parse('${APIEndPoints.addToCartCustomer(cartId: token)}');
    print('simple addToCartUser  ${url.toString()}');
  }
  List custom_options = [];
  for (int i = 0; i < simpleProductOptions.length; i++) {
    dynamic obj = simpleProductOptions[i];
    List values = obj["values"] ?? [];
    dynamic objValue = {
      "option_id": obj["option_id"] ?? 0,
      "option_value": values.length > 0 ? (values[0]["option_type_id"] ?? 0) : 0
    };
    custom_options.add(objValue);
  }
  print("++++++++++++++++++++++++++++++++++++++++");
  print(simpleProductOptions);
  print(userType);
  print(type);
  print(json.encode(
    type == 0
        ? userType == 'Guest'
            ? simpleProductOptions.isNotEmpty
                ? {
                    'cartItem': {
                      'sku': '$sku',
                      'qty': quantity == 0 ? 1 : quantity,
                      'product_option': {
                        'extension_attributes': {'custom_options': custom_options}
                      }
                    },
                  }
                : {
                    'cartItem': {'sku': '$sku', 'qty': quantity == 0 ? 1 : quantity},
                  }
            : simpleProductOptions.isNotEmpty
                ? {
                    'cartItem': {
                      'sku': '$sku',
                      'qty': quantity == 0 ? 1 : quantity,
                      'product_option': {
                        'extension_attributes': {'custom_options': custom_options}
                      }
                    },
                  }
                : {
                    'cartItem': {
                      'sku': '$sku',
                      'qty': quantity == 0 ? 1 : quantity,
                      'quote_id': '$qouteId',
                    },
                  }
        : lookName == ""
            ? {
                'cartItem': {
                  'sku': '$sku',
                  'qty': quantity == 0 ? 1 : quantity,
                  'quote_id': '$qouteId',
                },
              }
            : {
                'cartItem': {
                  'sku': '$sku',
                  'qty': quantity == 0 ? 1 : quantity,
                  'quote_id': '$qouteId',
                  "extension_attributes": {"look_name": '$lookName'},
                },
              },
  ));


  http.Response response = await http.post(
    url,
    headers: userType == 'Guest'
        ? {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APITokens.bearerToken}',
          }
        : {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await APITokens.customerSavedToken}',
          },
    body: json.encode(
      type == 0
          ? userType == 'Guest'
              ? simpleProductOptions.isNotEmpty
                  ? {
                      'cartItem': {
                        'sku': '$sku',
                        'qty': quantity == 0 ? 1 : quantity,
                        'product_option': {
                          'extension_attributes': {'custom_options': custom_options}
                        }
                      },
                    }
                  : {
                      'cartItem': {'sku': '$sku', 'qty': quantity == 0 ? 1 : quantity},
                    }
              : simpleProductOptions.isNotEmpty
                  ? {
                      'cartItem': {
                        'sku': '$sku',
                        'qty': quantity == 0 ? 1 : quantity,
                        'product_option': {
                          'extension_attributes': {'custom_options': custom_options}
                        }
                      },
                    }
                  : {
                      'cartItem': {
                        'sku': '$sku',
                        'qty': quantity == 0 ? 1 : quantity,
                        'quote_id': '$qouteId',
                      },
                    }
          : lookName == ""
          ? {
        'cartItem': {
          'sku': '$sku',
          'qty': quantity == 0 ? 1 : quantity,
          'quote_id': '$qouteId',
        },
      }
      : {
        'cartItem': {
          'sku': '$sku',
          'qty': quantity == 0 ? 1 : quantity,
          'quote_id': '$qouteId',
          "extension_attributes": {"look_name": '$lookName'},
        },
      },
    ),
  );
  print("ACB==" + response.body);
  print(response.body);
  print("STATUS CODE ${response.statusCode}");
  if (response.statusCode != 200) {
    print("RESPONSE BODY ${response.body}   STATUS ${response.statusCode}");
    throw json.decode(response.body);
  }
  // }
}

// <<<<<<< HEAD

Future<String> sfAPICreateCustomerCart(token) async {
  // Uri url = Uri.parse('${APIEndPoints.userCartDetails}');
  // http.Response response = await http.post(
  //   url,
  //   headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${APITokens.customerSavedToken}',
  //   },
  // );

  var headers = {'Authorization': 'Bearer $token'};
  var request = http.Request('POST', Uri.parse('${APIEndPoints.userCartDetails}'));
  request.body = '''''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String token = await response.stream.bytesToString();
    print(token);
    return token;
  } else {
    print("token genrate error");
    return 'error';
  }
}

//APi to remove Items from cart
Future<void> sfAPIRemoveItemFromCart(String token, String itemId, String userType) async {
  Uri url = Uri.parse('');
  if (userType == 'Guest') {
    url = Uri.parse('${APIEndPoints.removeFromCartGuest(cartId: token, itemId: itemId)}');
    print('DeleteFromCartGuest  ${url.toString()}');
  } else {
    url = Uri.parse('${APIEndPoints.removeFromCartCustomer(itemId: itemId)}');
    print('DeleteFromCartUser  ${url.toString()}');
  }
  http.Response response = await http.delete(
    url,
    headers: userType == "Guest"
        ? APIEndPoints.headers(APITokens.bearerToken)
        : APIEndPoints.headers(await APITokens.customerSavedToken),
  );
  if (response.statusCode != 200) {
    throw "Failed";
  } else {
    print("Deleted User request ${response.request}");
    print("Deleted User response ${response.body}");
  }
}

Future<void> sfAPIRemoveAllItemFromCart(String token, String userType) async {
  Uri url = Uri.parse('');
  if (userType == 'Guest') {
    url = Uri.parse('${APIEndPoints.removeAllFromCartGuest(cartId: token)}');
    print('DeleteAllFromCartGuest  ${url.toString()}');
  } else {
    url = Uri.parse('${APIEndPoints.removeAllFromCartCustomer(cartId: token)}');
    print('DeleteAllFromCartUser  ${url.toString()}');
  }
  http.Response response = await http.post(
    url,
    headers: userType == "Guest"
        ? APIEndPoints.headers(APITokens.bearerToken)
        : APIEndPoints.headers(await APITokens.customerSavedToken),
  );
  print("DAC request ${response.request}");
  print("DAC User response ${response.body}");
  if (response.statusCode != 200) {
    throw "Failed";
  } else {
    print("Deleted User request ${response.request}");
    print("Deleted User response ${response.body}");
  }
}

Future<MyReviewSkuModel?> getOptionsFromSKU(String sku) async {
  var result;
  MyReviewSkuModel? myReviewBySkuModel;
  try {
    http.Response? response = await NetworkHandler.getMethodCall(
        url: "https://sofiqe.com/rest/V1/products/$sku",
        // url: "https://dev.sofiqe.com/rest/V1/products/$sku",
        headers: APIEndPoints.headers(APITokens.adminBearerId));
    print("after api  ${response!.statusCode}");
    print("getSkuData  ${response.body}");
    if (response.statusCode == 200) {
      result = json.decode(response.body);
      myReviewBySkuModel = MyReviewSkuModel.fromJson(result);
      return myReviewBySkuModel;
    } else {
      result = json.decode(response.body);
      return null;
    }
  } catch (e) {
    return null;
  }
}

// ignore: todo
//TODO Change this to a POST TOKEN
Future<void> sfAPIAddItemToCartConfigurable(String token, int qouteId, String sku, List simpleProductOptions,
    List configurableProductOptions, int type, String userType,
    {int quantity = 0}) async {
  Uri url = Uri.parse('');
  if (userType == 'Guest') {
    url = Uri.parse('${APIEndPoints.addToCartGuest(cartId: token)}');
    print('addToCartGuest  ${url.toString()}');
  } else {
    url = Uri.parse('${APIEndPoints.addToCartCustomer(cartId: token)}');
    print('configre addToCartUser  ${url.toString()}');
  }
  http.Response response = await http.post(
    url,
    headers: userType == 'Guest'
        ? {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APITokens.bearerToken}',
          }
        : {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await APITokens.customerSavedToken}',
          },
    body: json.encode(
      type == 0
          ? userType == 'Guest'
              ? {
                  'cartItem': {'sku': '$sku', 'qty': quantity == 0 ? 1 : quantity},
                }
              : {
                  'cartItem': {
                    'sku': '$sku',
                    'qty': quantity == 0 ? 1 : quantity,
                    'quote_id': '$qouteId',
                  },
                }
          : {
              'cartItem': {
                'sku': '$sku',
                'qty': quantity == 0 ? 1 : quantity,
                // 'quote_id': '$qouteId',
                "product_option": {
                  "extension_attributes": {
                    "configurable_item_options": configurableProductOptions,
                    "customOptions": simpleProductOptions,
                  },
                },
              },
            },
    ),
  );

  print(json.encode(
    type == 0
        ? userType == 'Guest'
            ? {
                'cartItem': {'sku': '$sku', 'qty': quantity == 0 ? 1 : quantity},
              }
            : {
                'cartItem': {
                  'sku': '$sku',
                  'qty': quantity == 0 ? 1 : quantity,
                  'quote_id': '$qouteId',
                },
              }
        : {
            'cartItem': {
              'sku': '$sku',
              'qty': quantity == 0 ? 1 : quantity,
              'quote_id': '$qouteId',
              "product_option": {
                "extension_attributes": {
                  "configurable_item_options": configurableProductOptions,
                  "customOptions": simpleProductOptions,
                },
              },
            },
          },
  ));
  print("TZS--WEWAKE");
  print(response.body);
  if (response.statusCode != 200) {
    throw json.decode(response.body);
  }
  // }
}
