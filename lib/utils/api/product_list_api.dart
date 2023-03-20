import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/network_service/network_service.dart';
// Utils
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';

import '../../provider/wishlist_provider.dart';

Future<Map> sfAPIGetCatalogUnfilteredItems(int page) async {
  try {
    // add additional parameter to api for show only visible products
    Uri url = Uri.parse(
        '${APIEndPoints.catalogUnfiltereditems}$page&searchCriteria[filterGroups][0][filters][0][field]=visibility&searchCriteria[filterGroups][0][filters][0][value]=4&searchCriteria[filterGroups][0][filters][0][conditionType]=eq');
    //print('APIEndPoints ${APIEndPoints.catalogUnfiltereditems}$page');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer n0y2a0zdfd2xwk24d4c2ucslncm9qovv',
      //'Bearer ${APITokens.bearerToken}',
    });
    if (response.statusCode != 200) {
      throw response.body;
    }
    //print("response.request?.url ${response.request?.url}");
    Map resultMap = json.decode(response.body);
    //print("fetchUnfilteredItems  ${resultMap}");
    return resultMap;
  } catch (err) {
    print(err);
    throw 'Could not fetch item list';
  }
}

Future<Map> sfAPIGetUnfilteredFaceAreaItems(int page, int faceArea) async {
  try {
    Uri url =
        Uri.parse('${APIEndPoints.unfilteredFaceAreaItems(page, faceArea)}');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer n0y2a0zdfd2xwk24d4c2ucslncm9qovv',
      //'Bearer ${APITokens.bearerToken}',
    };

    print('${APIEndPoints.unfilteredFaceAreaItems(page, faceArea)}');

    http.Request request = http.Request('GET', url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }

    Map responseBody = json.decode(await response.stream.bytesToString());

    return responseBody;
  } catch (err) {
    rethrow;
  }
}

Future<Map> sfAPIGetSkinToneItems(String faceArea, String eyeColor,
    String hairColor, String lipcolor, String cheekColor, String token) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.searchedSKinToneItems}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      //'Bearer ${APITokens.bearerToken}',
    };

    print('${APIEndPoints.searchedSKinToneItems}');

    http.Request request = http.Request('POST', url);
    request.body = json.encode(
      {
        'eye_color': '$eyeColor',
        'lip_color': '$lipcolor',
        'face_sub_area': '$faceArea',
        'skin_tone': '$cheekColor',
        'hair_color': '$hairColor',
      },
    );
    print('heloooooooooooooooooooo');
    print(eyeColor);
    print(request.body);
    print(token);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }

    //print(json.decode(await response.stream.bytesToString()));

    Map responseBody = json.decode(await response.stream.bytesToString());
    print(responseBody);
    return responseBody;
  } catch (err) {
    rethrow;
  }
}

Future<Map> sfAPIGetSkinToneProfileItems(
    String faceArea, bool isProfileSearch) async {
  try {
    var token = await APITokens.customerSavedToken;
    Uri url = Uri.parse('${APIEndPoints.searchedSKinToneItems}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      //'Bearer ${APITokens.bearerToken}',
    };

    print('${APIEndPoints.searchedSKinToneItems}');
    print('$token');

    http.Request request = http.Request('POST', url);
    request.body = json.encode(
      {'profile_search': '$isProfileSearch', 'face_sub_area': '$faceArea'},
    );

    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }

    //print(json.decode(await response.stream.bytesToString()));

    Map responseBody = json.decode(await response.stream.bytesToString());
    print(responseBody);
    return responseBody;
  } catch (err) {
    rethrow;
  }
}

Future<Map> sfAPIFetchProductItems(int page, int faceSubArea) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.productItems(page, faceSubArea)}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer n0y2a0zdfd2xwk24d4c2ucslncm9qovv',
      //'Bearer ${APITokens.bearerToken}',
    };

    http.Request request = http.Request('GET', url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }

    Map responseBody = json.decode(await response.stream.bytesToString());

    return responseBody;
  } catch (err) {
    rethrow;
  }
}

Future<List> sfAPIFetchBrandFilteredItems(
    int page, String brand, String faceArea) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.brandFilteredItems}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer n0y2a0zdfd2xwk24d4c2ucslncm9qovv',
      //'Bearer ${APITokens.bearerToken}',
    };

    print('${APIEndPoints.brandFilteredItems}');

    http.Request request = http.Request('POST', url);
    request.body = json.encode(
      {
        'brand': '$brand',
        'face_sub_area': '$faceArea',
        'page': page,
      },
    );

    print(request.body);
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

Future<List> sfAPIGetCatalogPopularItems(int page) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.catalogPopularItems}');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    };
    http.Request request = http.Request('POST', url);
    request.body = json.encode(
      {
        "page": page,
      },
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }
    List resultMap = json.decode(await response.stream.bytesToString());

    return resultMap;
  } catch (err) {
    print(err);
    throw 'Could not fetch item list';
  }
}

Future<List> sfAPIGetCatalogBetweenPriceItems(
    int page, int minPrice, int maxPrice, String faceArea) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.catalogBetweenPriceItems}');

    print('${APIEndPoints.catalogBetweenPriceItems}');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    };
    http.Request request = http.Request('POST', url);
    request.body = json.encode(
      {
        "min_price": minPrice,
        "max_price": maxPrice,
        "page": page,
        "face_area": faceArea,
      },
    );

    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }
    List resultMap = json.decode(await response.stream.bytesToString());

    return resultMap;
  } catch (err) {
    print(err);
    throw 'Request Error $err';
  }
}

Future<Map<String, dynamic>> sfAPIGetBestSellers() async {
  Uri url = Uri.parse('${APIEndPoints.getBestSellersList}');
  print("URL URL ${url}");
  // Uri url = Uri.parse('http://3.109.228.199/rest/V1/custom/bestsellers');
  http.Response response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    // List<dynamic> responseBody = json.decode(response.body);
    print("Come nnjh");
    var data = json.decode(response.body);
    Map<String, dynamic> map = data[0];
    print("Best  -->> first $map");

    // List<dynamic> data = map["bestseller_product"];
    // print(data[0]["name"]);
    //
    // print("Best  -->> second ${data[0]["name"]}");

    return map;
  } else {
    print(response.body);
    throw 'Could not fetch bestsellers';
  }
}

Future<void> sfAPIGetInvoice({required String OrderId}) async {
  Uri url = Uri.parse('${APIEndPoints.InVoices(OrderId: OrderId)}');
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${APITokens.bearerToken}',
  };
  http.Response response = await http.post(url, body: {}, headers: headers);
  // request.body = json.encode({"lat": "$lat", "long": "$long", "time": "$time"});
  //request.body = json.encode({"lat": "$lat", "long": "$long"});

  print(response);
  print("get_deal:>>  ");

  if (response.statusCode == 200) {
    String responseString = await response.body;
    print("get_deal  -->> 1 ${json.decode(responseString)}");

    //List<dynamic> responseBody = json.decode(responseString);
  } else {
    print(response.reasonPhrase);
    print("get_deal  -->> 2");
    throw 'Could not fetch deals';
  }
}

Future<List<dynamic>> sfAPIGetDealOfTheDay(double lat, double long) async {
  Uri url = Uri.parse('${APIEndPoints.getDealOfTheDay}');
  // Uri url = Uri.parse('http://3.109.228.199/rest/V1/custom/getDeals');
  // http.Response response = await http.post(
  //   url,
  //   headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${APITokens.bearerToken}',
  //   },
  //   body: json.encode(
  //     {
  //       'lat': '$lat',
  //       'long': '$long',
  //       'time': '$time',
  //     },
  //   ),
  // );
  // if (response.statusCode == 200) {
  //   List<dynamic> responseBody = json.decode(response.body);
  //   return responseBody;
  // } else {
  //   print(response.body);
  //   throw 'Could not fetch deals';
  // }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${APITokens.bearerToken}',
  };
  http.Request request = http.Request('POST', url);
  // request.body = json.encode({"lat": "$lat", "long": "$long", "time": "$time"});
  request.body = json.encode({"lat": "$lat", "long": "$long"});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  print(response);
  print("get_deal:>>  ");

  if (response.statusCode == 200) {
    String responseString = await response.stream.bytesToString();
    print("get_deal  -->> 1 ${json.decode(responseString)}");

    List<dynamic> responseBody = json.decode(responseString);
    return responseBody;
  } else {
    print(response.reasonPhrase);
    print("get_deal  -->> 2");
    throw 'Could not fetch deals';
  }
}

Future<List<dynamic>> getVendorDealsById(dynamic sellerId) async {
  Uri url = Uri.parse('${APIEndPoints.getVendorDealsById}');
  // Uri url = Uri.parse('http://3.109.228.199/rest/V1/custom/getDeals');
  // http.Response response = await http.post(
  //   url,
  //   headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${APITokens.bearerToken}',
  //   },
  //   body: json.encode(
  //     {
  //       'lat': '$lat',
  //       'long': '$long',
  //       'time': '$time',
  //     },
  //   ),
  // );
  // if (response.statusCode == 200) {
  //   List<dynamic> responseBody = json.decode(response.body);
  //   return responseBody;
  // } else {
  //   print(response.body);
  //   throw 'Could not fetch deals';
  // }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${APITokens.bearerToken}',
  };
  http.Request request = http.Request('POST', url);
  // request.body = json.encode({"lat": "$lat", "long": "$long", "time": "$time"});
  request.body = json.encode({"seller_id": "$sellerId"});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  print(response);
  print("Vendor_deal:>>  ");

  if (response.statusCode == 200) {
    String responseString = await response.stream.bytesToString();
    print("Vendor_deal  -->> 1 ${json.decode(responseString)}");

    List<dynamic> responseBody = json.decode(responseString);
    return responseBody;
  } else {
    print(response.reasonPhrase);
    print("Vendor_deal  -->> 2");
    throw 'Could not fetch deals';
  }
}

Future<Map> sfAPIGetSearchedItems(String query) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.searchedItems(query)}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Get.find<WishListProvider>().userToken}',
    };
    // 'Authorization': 'Bearer ${APITokens.bearerToken}',
    Get.find<WishListProvider>().userToken;
    http.Request request = http.Request('GET', url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }
    Map responseBody = json.decode(await response.stream.bytesToString());
    return responseBody;
  } catch (err) {
    rethrow;
  }
}

Future<Map> sfAPIGetSearchedSkinTone(String query) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.searchedItems(query)}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    };

    http.Request request = http.Request('GET', url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }
    Map responseBody = json.decode(await response.stream.bytesToString());
    return responseBody;
  } catch (err) {
    rethrow;
  }
}

Future<List> sfAPIFetchCentralColorProducts(
  String token,
  String color,
  String undertone,
  String faceSubArea,
  int colorDepth,
) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.centralColorProducts}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    http.Request request = http.Request('POST', url);
    request.body = json.encode(
      {
        'color': '$color',
        'face_sub_area': '$faceSubArea',
        'undertone': '$undertone',
        'color_depth': '$colorDepth',
      },
    );

    print(request.body);
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

Future<List> sfAPIFetchCentralColorProductsForFoundation(
  String token,
  String color,
  String faceSubArea,
  // int customer_id,
) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.alternateColorProducts}');
    // Uri url = Uri.parse('${APIEndPoints.centralColorProducts}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print(token);
    http.Request request = http.Request('POST', url);
    request.body = json.encode(
      {
        // "eye_color": "green",
        // "lip_color": "#ffccaa",
        // "hair_color": "brown",
        // "skin_tone": "#ffccaa",
        // "face_sub_area": "Highligther",
        // "customerId": 160

        'color': '$color',
        'face_sub_area': '$faceSubArea',
        'color_depth': '5',
        //  "customerId": customer_id
      },
    );
    print(',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }

    List responseBody = json.decode(await response.stream.bytesToString());
    print('.......................');
    print(responseBody);
    return responseBody;
  } catch (err) {
    rethrow;
  }
}
/*
* this function will fetch products as per rates
*
* */

Future<List> fetchItemsByReview(int star) async {
  var result;
  String url = '${APIEndPoints.fetchRatedItems(star: star)}';

  print(url);

  try {
    http.Response? response =
        await NetworkHandler.getMethodCall(url: url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    });
    print("after api-----------;;;;;;;;;-  ${response!.statusCode}");

    if (response.statusCode != 200) {
      throw response.body;
    }
    result = json.decode(response.body);
    print(result);
    return result;
  } catch (e) {
    rethrow;
  }
}
