import 'dart:convert';

import 'package:sofiqe/utils/constants/api_tokens.dart';
import 'package:http/http.dart' as http;
import '../constants/api_end_points.dart';

Future<List> sfAPIGetFreeShippingInfo() async {
  try {
    Uri url = Uri.parse('${APIEndPoints.getFreeShippingInfo}');
    print(url);
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
      //'Bearer ${APITokens.bearerToken}',
    });
    if (response.statusCode != 200) {
      throw response.body;
    }
    List resultMap = json.decode(response.body);
    print(resultMap.length);
    return resultMap;
  } catch (err) {
    print(err);
    throw 'Could not fetch item list';
  }
}