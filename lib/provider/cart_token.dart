import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/states/local_storage.dart';

class CartTokenController extends GetxController {
  static CartTokenController instance = Get.find();

  verifyTokenCall() async {
    Map customerTokenMap = await sfQueryForSharedPrefData(fieldName: 'user-token', type: PreferencesDataType.STRING);
    if (customerTokenMap['found']) {
      this.verifyToken(customerTokenMap['user-token']);
    } else {
      // defaults();
    }
  }

  Future<void> verifyToken(String token) async {
    try {
      Uri url = Uri.parse('${APIEndPoints.getWishlist}');
      http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 401) {
        sfRemoveFromSharedPrefData(fieldName: 'user-token');
      }
    } catch (e) {
      print('Token Verification Failed: $e');
    }
  }
}
