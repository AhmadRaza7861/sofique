// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:get/get.dart';
import 'package:sofiqe/model/ms8Model.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/utils/constants/api_tokens.dart';

class Ms8Controller extends GetxController {
  static Ms8Controller get to => Get.find();


  Ms8Model? ms8model;

  // LooksModel? looksModel;

  // List<dynamic> data;
  bool isLookLoading = false;
  RxBool load = false.obs;

  ///
  ///  Get getList api
  ///  @param [String] collectionId
  ///

  getLookList(String look) async {
    ms8model = null;
    final TryItOnProvider tmo = Get.find();

    isLookLoading = true;
    load = true.obs;
    tmo.lookloading.value = true;
    update();
    try {
      var request = http.Request(
          'GET',
          // Uri.parse('http://dev.sofiqe.com/rest/default/V1/look/getList'));
          Uri.parse('https://sofiqe.com/rest/default/V1/look/getList'));
      request.body = json.encode({"look": look});
      request.headers.addAll(APIEndPoints.headers(await APITokens.customerSavedToken));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final result = jsonDecode(response.body);
      print("body");
      print(request.body);

      print("nill Look Result ::: $result");
      print(result);

      if (response.statusCode == 200) {
        if (result[0]["message"] == "success") {

          ms8model = Ms8Model.fromJson(result[0]);
          // looksModel = LooksModel.fromJson(result);
        } else {
          if (result[0]['message'].toString().contains("Deadlock")) {
            print(result[0]["message"]);
          } else {
            Get.showSnackbar(
              GetSnackBar(
                message: '${result[0]["message"]}',
                duration: Duration(seconds: 2),
                isDismissible: true,
              ),
            );
          }
          //Get.snackbar('Error', '${result[0]["message"]}');
        }
      }
    } catch (e) {
      ms8model = null;
      // looksModel = null;
    } finally {
      isLookLoading = false;
      load = false.obs;
      tmo.lookloading.value = false;
      update();
    }
  }
}
