import 'dart:convert';
import 'package:http/http.dart' as http;
// Utils
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';

Future<dynamic> sfAPIGetRecommendedProductsByApplicationArea(String color, String faceArea, String faceSubArea) async {
  Uri url = Uri.parse('${APIEndPoints.productRecommendedProductsFilteredByApplicationArea(color.replaceAll('#', ''), faceArea, faceSubArea)}');
  http.Response response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    },
  );

  var result = json.decode(response.body);
  if (response.statusCode != 200) {
    throw 'Could not load data for recommended products: ${result['message']}';
  }
  // print(response.body);
  return result['items'];
}
