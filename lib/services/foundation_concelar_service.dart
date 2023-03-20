import 'dart:async';
import 'dart:convert';

import 'package:sofiqe/services/api_base_manager.dart';


class FoundationAndConcelarApiServices {
  NetworkUtil _network = new NetworkUtil();
  static const baseUrl = "https://dev.sofiqe.com/rest/v1/";
  Future<dynamic> otherFilterApiCall(
      String color, String faceSubArea, String token) async {
    final foundationApi = baseUrl + "custom/searchAlternateColor";
    Map data = {
      "color": color,
      "face_sub_area": faceSubArea,
      "color_depth": "5"
    };
    var headers = {"Content-Type": "application/json", "Authorization": token};

    //encode Map to JSON
    var body = json.encode(data);
    // var headers={'Authorization': 'Bearer $resettoken',};
    return _network.post(foundationApi, body, headers).then((dynamic res) {
      if (res != null) {
        return res;
      } else {
        print(res['errormsg']);
        throw Exception(res['errormsg']);
      }
    });
  }
}
