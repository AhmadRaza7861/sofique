import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sofiqe/services/api_base_manager.dart';


class FoundationAndConcelarApiServices {
  NetworkUtil _network = new NetworkUtil();
  static const baseUrl = "https://dev.sofiqe.com/rest/v1/";
  Future<dynamic> foundationApiCall(
      String skinToneColor, String faceSubArea, String token,String hairColor,String lipColor,String eyeColor) async {
    final otherFilterApi = baseUrl + "custom/searchSkinTone";
    Map data = {
  "eye_color": eyeColor,
  "lip_color": lipColor,
  "hair_color":hairColor,
  "skin_tone" : skinToneColor,
  "face_sub_area": faceSubArea
};
    var headers = {"Content-Type": "application/json", "Authorization": token};

    //encode Map to JSON
    var body = json.encode(data);
    // var headers={'Authorization': 'Bearer $resettoken',};
    return _network.post(otherFilterApi, body, headers).then((dynamic res) {
      if (res != null) {
        return res;
      } else {
        print(res['errormsg']);
        throw Exception(res['errormsg']);
      }
    });
  }
}


String getJson(jsonObject, {name}) {
  var encoder = const JsonEncoder.withIndent("     ");
  log(encoder.convert(jsonObject), name: name ?? "");
  return encoder.convert(jsonObject);
}



Future<T?> push<T>({
  required BuildContext context,
  required Widget screen,
  bool pushUntil = false,
}) {
  if (pushUntil) {
    return Navigator.of(context).pushAndRemoveUntil<T>(MaterialPageRoute(builder: (_) => screen), (Route<dynamic> route) => false);
  }
  return Navigator.of(context).push<T>(MaterialPageRoute(builder: (_) => screen));
}