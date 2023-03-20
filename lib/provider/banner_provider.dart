import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/model/banner_model/banner_model.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';

import '../utils/constants/api_tokens.dart';

class BannerProvider with ChangeNotifier {
  List<BannerListModel>? bannerListModel = [];

  /// Get Banner List API(ENDPOINTS)
  Future<List> getBannerList(context) async {
    // print("URL:${APIEndPoints.getActiveBannerListAPI}");
    try {
      await http.get(Uri.parse(APIEndPoints.getActiveBannerListAPI),
          headers: {"Authorization": "Bearer ${APITokens.adminBearerId}"}).then((response) async {
        // print("Response Body${response.body}");
        // print("Banner LIST");
        final parsedData = jsonDecode(response.body);
        //print("SSS:${parsedData[0]['banners']}");
        List l = parsedData[0]['banners'];
        l.forEach((element) {
          element.forEach((x) {
            bannerListModel!.add(BannerListModel.fromJson(x));
          });
        });
        // print(bannerListModel);
        // bannerListModel = parsedData.map((banner) => new BannerListModel.fromJson(banner)).toList();
        //return parsedData.map((banner) => new BannerListModel.fromJson(banner)).toList();
      });
      notifyListeners();
      return [];
    } on SocketException {
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
