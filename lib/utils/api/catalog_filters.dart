import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';

import '../../model/CategoryResponse.dart';
import '../../network_service/network_service.dart';

///
/// Api Call Request sfAPIFetchFaceAreasAndParameters
/// [body] is the request body
/// [url] is the url of the request
/// [method] is the method of the request
/// [token] is the token of the request
/// [isAuth] is the authentication of the request

Future<List> sfAPIFetchFaceAreasAndParameters(int faceArea) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.faceAreasAndParameters}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    };

    http.Request request = http.Request('POST', url);
    request.body = json.encode({
      "face_area": faceArea,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }

    List responseBody = json.decode(await response.stream.bytesToString());
    return responseBody;
  } catch (err) {
    rethrow;
  }
}

Future<CategoryResponse> sfAPIFetchFaceCategory() async {
  try {
    /* Uri url = Uri.parse('${APIEndPoints.faceAreaCategory}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    };*/

    http.Response? response = await NetworkHandler.getMethodCall(
        url: '${APIEndPoints.faceAreaCategory}',
        headers: APIEndPoints.headers(APITokens.bearerToken));
    print("after api  ${response!.statusCode}");

    if (response.statusCode != 200) {
      throw json.decode(response.body);
    } else {
      print("category response");
      print(response.statusCode);
      CategoryResponse responseBody =
          CategoryResponse.fromJson(json.decode(response.body));
      return responseBody;
    }
  } catch (err) {
    print(err.toString());
    throw 'Error in category api';
  }
}

///
/// Api Call Request sfAPIGetBrandNames
/// [body] is the request body
/// [url] is the url of the request
/// [method] is the method of the request
/// [token] is the token of the request
/// [isAuth] is the authentication of the request
///
Future<List> sfAPIGetBrandNames(String faceArea) async {
  try {
    /* Uri url = Uri.parse('${APIEndPoints.brandNames}${faceArea.isEmpty ? '' : '?face_area=$faceArea'}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    };*/

    http.Response? response = await NetworkHandler.getMethodCall(
        url:
            '${APIEndPoints.brandNames}${faceArea.isEmpty ? '' : '?face_area=$faceArea'}',
        headers: APIEndPoints.headers(APITokens.bearerToken));

    print(
        "after SHUBHAM---  '${APIEndPoints.brandNames}${faceArea.isEmpty ? '' : '?face_area=$faceArea'}'");
    print("after api  ${response!.statusCode}");

    //print('${APIEndPoints.brandNames}${faceArea.isEmpty ? '' : '?face_area=$faceArea'}');

    // http.Request request = http.Request('GET', url);
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw response.body;
    }
    List responseBody = json.decode(response.body);
    // added by kruti to log response of brands
    print("brand name response :: ${response.body}");
    return responseBody;
  } catch (err) {
    rethrow;
  }
}

///
/// Api Call Request sfAPIGetBrandNames
/// [body] is the request body
/// [url] is the url of the request
/// [method] is the method of the request
/// [token] is the token of the request
/// [isAuth] is the authentication of the request

/// added by kruti call APi 15c2 to get brands based on faceArea and faceSubArea both
Future<List> sfAPIGetFilteredBrandNames(
    String faceArea, String faceSubArea) async {
  try {
    http.Response? response = await NetworkHandler.getMethodCall(
        url:
            '${APIEndPoints.brandNames}${faceArea.isEmpty ? '' : '?face_area=$faceArea'}${faceSubArea.isEmpty ? '' : '&&face_sub_area=$faceSubArea'}',
        headers: APIEndPoints.headers(APITokens.bearerToken));

    print(
        "after SHUBHAM---  '${APIEndPoints.brandNames}${faceArea.isEmpty ? '' : '?face_area=$faceArea'}${faceSubArea.isEmpty ? '' : '&&face_sub_area=$faceSubArea'}'");
    print("after api  ${response!.statusCode}");

    if (response.statusCode != 200) {
      throw response.body;
    }
    List responseBody = json.decode(response.body);
    print(
        "filtered brand name with face_sub_area response :: ${response.body}");
    return responseBody;
  } catch (err) {
    rethrow;
  }
}
