import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sofiqe/model/lookms3model.dart';
import 'package:sofiqe/network_service/network_service.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';

class LooksController extends GetxController {
   static LooksController get to => Get.find();

  LooksMs3Model? lookModel;
  bool isLookLoading = false;


  getLookList() async {
    isLookLoading = true;
    update();
    try {
      http.Response? response = await NetworkHandler.getMethodCall(
          // url: "http://dev.sofiqe.com/rest/default/V1/look/getCollection",
          url: "https://sofiqe.com/rest/default/V1/look/getCollection",
          headers: APIEndPoints.headers(await APITokens.customerSavedToken));
      print("Looks Api Status Code :  ${response!.statusCode}");
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        lookModel = LooksMs3Model.fromJson(result[0]);
      } else {
        var result = json.decode(response.body);
        Get.snackbar('Error', '${result[0]["message"]}', isDismissible: true);
      }
      print("Responce of API is ${response.body}");
    } catch (e) {
      lookModel = null;
    } finally {
      isLookLoading = false;
      update();
    }
  }



  Future<void> createReview(String detail, String name, String sku, int generalRating, int priceRating, int qualityRating) async {
    try {
      Uri url = Uri.parse('${APIEndPoints.createReview}');
      print('share wishlist ${url.toString()}');
      http.Response response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${APITokens.bearerToken}',
          },
          body: jsonEncode({
            "review": {
              "title": "User Review",
              "detail": detail,
              "nickname": name,
              "ratings": [
                {
                  "rating_name": "Rating",
                  "value": generalRating
                },
                {
                  "rating_name": "Quality",
                  "value": qualityRating
                },
                {
                  "rating_name": "Price",
                  "value": priceRating
                }
              ],
              "review_entity": "product",
              "review_status": 2,
              "product_sku": int.parse(sku)
            }
          })//json.encode(resBody),
      );
      print(response.body);
      if (response.statusCode == 200) {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Your review is shared successfully',
            duration: Duration(seconds: 2),
            isDismissible: true,
          ),
        );
      }else{
        Get.showSnackbar(
          GetSnackBar(
            message: 'Review is not shared',
            duration: Duration(seconds: 2),
            isDismissible: true,
          ),
        );
      }
    } catch (e) {
      print('Error creating review: $e');
    }
  }
}
