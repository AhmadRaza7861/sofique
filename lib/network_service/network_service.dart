import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  static Future<http.Response?> patchMethodCall({String? url, Map<String, String>? headers}) async {
    try {
      final response = await http.patch(Uri.tryParse(url!)!, headers: headers);
      return response;
    } on SocketException {
      Get.snackbar('Error', 'Network Error', snackPosition: SnackPosition.BOTTOM, isDismissible: true);
      return null;
    } catch (error) {
      Get.snackbar('Error', '$error', snackPosition: SnackPosition.BOTTOM, isDismissible: true);
      return null;
    }
  }

  static Future<http.Response?> patchMethodWithBodyCall({String? url, Map<String, String>? headers, var body}) async {
    try {
      final response = await http.put(Uri.tryParse(url!)!, headers: headers, body: body);
      return response;
    } on SocketException {
      Get.snackbar('Error', 'Network Error', snackPosition: SnackPosition.BOTTOM, isDismissible: true);
      return null;
    } catch (error) {
      Get.snackbar('Error', '$error', snackPosition: SnackPosition.BOTTOM, isDismissible: true);
      return null;
    }
  }

  static Future<http.Response?> postMethodCall(
      {String? url, Map<String, String>? headers, Map<String, dynamic>? body}) async {
    var encodedBody = json.encode(body);
    try {
      final response = await http.post(Uri.tryParse(url!)!, body: encodedBody, headers: headers);
      return response;
    } on SocketException {
      Get.snackbar('Error', 'Network Error', snackPosition: SnackPosition.BOTTOM, isDismissible: true);
      return null;
    } catch (error) {
      Get.snackbar('Error', '$error', snackPosition: SnackPosition.BOTTOM, isDismissible: true);
      return null;
    }
  }

  static Future<http.Response?> getMethodCall({String? url, Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.tryParse(
          url!,
        )!,
        headers: headers,
      );
      return response;
    } on SocketException {
      Get.snackbar('Error', 'Network Error', snackPosition: SnackPosition.BOTTOM, isDismissible: true);
      return null;
    } catch (error) {
      Get.snackbar('Error', '$error', snackPosition: SnackPosition.BOTTOM, isDismissible: true);
      return null;
    }
  }

  static Future<http.Response?> deleteMethodCall({String? url, Map<String, String>? headers}) async {
    try {
      final response = await http.delete(
        Uri.tryParse(
          url!,
        )!,
        headers: headers,
      );
      return response;
    } on SocketException {
      Get.snackbar('Error', 'Network Error', snackPosition: SnackPosition.BOTTOM, isDismissible: true);
      return null;
    } catch (error) {
      Get.snackbar('Error', '$error', snackPosition: SnackPosition.BOTTOM, isDismissible: true);
      return null;
    }
  }

  static Future<http.Response?> putMethodCall({
    String? url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    // var url = AppConst.baseUrl + "users/change-pin/me";
    var encodedBody = json.encode(body);
    try {
      final response = await http.put(
        Uri.tryParse(url!)!, body: encodedBody, headers: headers,
        //  {
        //   "Accept": "application/json",
        //   "content-type": "application/json",
        //   'Authorization': "Bearer ${AppConst.token}"
        // }
      );
      return response;
    } catch (error) {
      Get.snackbar('Error', '$error', snackPosition: SnackPosition.BOTTOM, isDismissible: true);
      return null;
    }
  }
}
