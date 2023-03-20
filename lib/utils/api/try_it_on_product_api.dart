import 'dart:convert';
import 'dart:developer';
import 'package:get/state_manager.dart';
import 'package:get/get.dart' as Gets;

import 'package:http/http.dart' as http;
import 'package:sofiqe/model/UserDetailModel.dart';

// Utils
import 'package:sofiqe/utils/constants/api_end_points.dart';

import '../../model/model_for_color_order.dart';

Future<dynamic> sfAPIGetSearchAlternatecolor(
    String color, String faceSubArea, String colorDepth, String token) async {

  try {
    print("Token ${token}");
    Uri url = Uri.parse('${APIEndPoints.alternateColorProducts}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
print("color  :${color}");
print("face_sub_area  :${faceSubArea}");
print("color_depth  :${colorDepth}");

    http.Request request = http.Request('POST', url);
    request.body = json.encode(
      {
        'color': '$color',
        'face_sub_area': '$faceSubArea',
        'color_depth': '$colorDepth',
      },
    );

    print("Check Color: ${request.body}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }
    var res = jsonDecode(await response.stream.bytesToString());
    var temp = [];
    var temp2=[];
    print(res[0]['product']);
    var check = res[0]['product'].toString();
    if (check != "[]") {
      print("IFFF11 ${res[0]}");
      res[0]['product'].forEach((key, value) {
        var data=ModelForColorOrder(
          distance_variance: double.parse(value['extension_attributes']["distance_variance"].toString()),
          face_color: value['face_color'],
        );




        log('==== DV is :: ${data.distance_variance} ====');


        int checkIfAddedToList(dynamic dv) =>
            temp2.indexWhere((element) => element.distance_variance  == dv);

        ///----- check if its already added then don't add it else add it
        if(checkIfAddedToList(data.distance_variance) == -1) {
          temp2.add(data);
        } else {

        }

        log("====== this is the temp2 list data ${temp2} =========");
         // temp.add(value['face_color']);
         // temp2.add(data);
      });
      temp2.sort((a,b)=>a.distance_variance.compareTo(b.distance_variance));
      for(int i=0;i<temp2.length;i++)
        {
         temp.add(temp2[i].face_color);
        }
      return temp;
    } else {
      print("Elseee");
      return null;
    }
  } catch (err) {
    print("API COLORS ERROR");
    print(err);
    rethrow;
  }
}


Future<dynamic> sfAPIGetSearchCentralcolor(String eyeColor, String faceSubArea, String lipColor, String hairColor,
    String skinTone, String luminance, int customerId, String token) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.centralColorProducts}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    http.Request request = http.Request('POST', url);
    request.body = json.encode(
      {
        "eye_color": eyeColor,
        "lip_color": lipColor,
        "hair_color": hairColor,
        "skin_tone": skinTone,
        "luminance": luminance,
        "face_sub_area": faceSubArea,
        "customerId": customerId
      },
    );

    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }
    var res = jsonDecode(await response.stream.bytesToString());

    print(res);
    print("API COLORS");
    return res;
  } catch (err) {
    print("API Central COLORS ERROR");
    print(err);
    rethrow;
  }
}

Future<UserDetailModel?> sfApiGetUserfaceColor(String token) async {
  UserDetailModel model = UserDetailModel();

  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request('GET', Uri.parse('https://sofiqe.com/index.php/rest/V1/customers/me/colour'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = json.decode(await response.stream.bytesToString());
      return UserDetailModel.fromJson(result);
    } else {
      var result = json.decode(await response.stream.bytesToString());
      print(result);
      return model;
    }
  } catch (err) {
    print("sfApiGetUserfaceColor ERROR");
    print(err);

      return null;
  }

}


Future<List<dynamic>?> sfApiGetCentralColorAndLeftmost(String eyeColor, String depth, String lipColor,
    String hairColor, String skinTone, int customerId, String token) async {
  try {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.Request('POST', Uri.parse('https://sofiqe.com/rest/V1/custom/searchCentralColorAndLeftmost'));
    request.body = json.encode({
      "eye_color": eyeColor,
      "lip_color": "#ffccaa",
      "hair_color": hairColor,
      "skin_tone": "#ffccaa",
      "color_depth": depth,
      "customerId": customerId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = json.decode(await response.stream.bytesToString());
      print(result[0]);
      // model = UserDetailModel.fromJson(result);
      // result
      return result[0];
    } else {
      return null;
    }
  } catch (err) {
    print("sfApiGetCentralColorAndLeftmost ERROR");
    print(err);

     return null;
  }
}

Future<dynamic> sfAPIGetProductWarning(String sku, String token) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.getproductwarning}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    http.Request request = http.Request('GET', url);
    request.body = json.encode({"sku": sku});

    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }

    var responseBody = json.decode(await response.stream.bytesToString());
    print(responseBody);
    return responseBody[0]['warning'];
  } catch (err) {
    rethrow;
  }
}

Future<bool?> sfAPIStoreMySelectedProducts(String token, List data) async {
  try {
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://sofiqe.com/rest/V1/m16'));
    request.body = json.encode({"products": data});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("Save my selected products done");
    print(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.showSnackbar(
        Gets.GetSnackBar(
          message: "Selected Products Saved Successfully",
          duration: Duration(seconds: 2),
          isDismissible: true,
        ),
      );
      return true;
    } else {
      print(response.reasonPhrase);
      Get.showSnackbar(
        Gets.GetSnackBar(
          message: "Selected Products not Saved",
          duration: Duration(seconds: 2),
          isDismissible: true,
        ),
      );
      return false;
    }
  } catch (err) {
    print("save my selected products error");
    print(err);
    return false;
  }
}
