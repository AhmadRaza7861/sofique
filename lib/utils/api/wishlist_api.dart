// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';

Future<bool> sfAPIAddItemToWishList(int itemId, int customerId) async {
  Uri url = Uri.parse('${APIEndPoints.addItemToWishList}$itemId');

  // ignore: todo
  ///TODO need to check and verify
  http.Response response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    },
    body: json.encode(
      {'customer_id': customerId},
    ),
  );
  return true;
}

Future<bool> sfAPRemoveItemToWishList(String itemId) async {
  Uri url = Uri.parse('${APIEndPoints.removeItemToWishList}$itemId');
  http.Response response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await APITokens.customerSavedToken}',
    },
    // body: json.encode(
    //   {'wishlistItemId': itemId},
    // ),
  );
  print(response.body);
  return true;
}

Future<dynamic> sfAPIFetchWishList(String customerToken) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.getWishlist}');
    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $customerToken',
      },
    );
    if (response.statusCode != 200) {
      throw 'WISHLIST== Could not fetch resource, error code ${response.statusCode}';
    }
    var resultMap = json.decode(response.body);
    return resultMap;
  } catch (err) {
    rethrow;
  }
}
