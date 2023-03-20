// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

// 3rd party packages
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/model/AddressClass.dart';
// Utils
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';

Future<String> sfAPILogin(String username, String password, BuildContext c) async {
  Uri url = Uri.parse('${APIEndPoints.login}?username=$username&password=$password');
  http.Response response = await http.post(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${APITokens.bearerToken}',
  });
  var result = json.decode(response.body);
  if (result.runtimeType != String) {
    ScaffoldMessenger.of(c).showSnackBar(SnackBar(
      content: Text(result['message']),
    ));
    return 'error';
  } else {
    return result;
  }
}

Future<AddressClass> sfAPIUpdateUserDetails(String token, Map body) async {
  Uri url = Uri.parse('${APIEndPoints.getUser}');
  print("APIEndPoints.getUser" + APIEndPoints.getUser);
  http.Response response = await http.put(
    url,
    body: jsonEncode(body),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode != 200) {
    throw 'token invalid ${response.statusCode}';
  }
  var responseMap = AddressClass.fromJson(json.decode(response.body));
  return responseMap;
}

Future<dynamic> sfAPIGetUserDetails(String token) async {
  Uri url = Uri.parse('${APIEndPoints.getUser}');
  // print("APIEndPoints.getUser" + APIEndPoints.getUser);
  // print("USERLOGIN-Token" + token);

  http.Response response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  // print(response.body);

  if (response.statusCode != 200) {
    throw 'token invalid';
  }
  var responseMap = json.decode(response.body);
  return responseMap;
}

///-----Get User Selfie Url

Future<dynamic> sfAPIGetUserSelfie(var customerId) async {
  Uri url = Uri.parse('${APIEndPoints.getUserSelfie}?customer_id=$customerId');
  print("APIEndPoints.getUserSelfie " + "${APIEndPoints.getUserSelfie}?customer_id=$customerId");
  http.Response response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    },
  );
  if (response.statusCode != 200) {
    throw 'token invalid';
  }
  var responseMap = json.decode(response.body);
  return responseMap;
}

// Future<bool> sfAPIUploadUserSelfie(
//     dynamic customerId, dynamic image, dynamic imageName) async {
//   documentToBase64() async {
//     final bytes = await File(image).readAsBytes();
//     String img64 = base64Encode(bytes);
//     return img64;
//   }
//   try{
//     final base64 = await documentToBase64();
//     final urlEncBase64 = Uri.encodeComponent(base64);
//     Uri url =
//     Uri.parse('${APIEndPoints.uploadUserSelfie}?customer_id=$customerId');
//     http.Response response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${APITokens.bearerToken}',
//       },
//       body: json.encode(
//         {
//           "customer_id": customerId,
//           "file": "$imageName.jpg",
//           "content": {
//             "base64EncodedData": urlEncBase64,
//             "type": "image/jpg",
//             "name": "${DateTime.now().millisecondsSinceEpoch.toString()}"
//             // "name": "helloworlsdsdsd-2.png"
//           }
//         },
//       ),
//     );
//     if (response.statusCode != 200) {
//       throw '=== error on status code ====';
//     }
//     log(' encoded response is :: ${json.decode(response.body)}');
//     return json.decode(response.body);
//   } catch (e) {
//     log ('==== Error while uploading API :: $e')
//   }
// }

Future<bool> sfAPIEmailAvailable(String email) async {
  Uri url = Uri.parse('${APIEndPoints.emailAvailability}');
  http.Response response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    },
    body: json.encode(
      {'customerEmail': '$email'},
    ),
  );
  return json.decode(response.body);
}

Future<bool> sfAPISignup(Map<String, dynamic> newUserInfo) async {
  Uri url = Uri.parse('${APIEndPoints.signup}');
  http.Response response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    },
    body: json.encode(
      {
        'customer': {
          'dob': '${newUserInfo['dob']}',
          'email': '${newUserInfo['email']}',
          'firstname': '${newUserInfo['firstname']}',
          'lastname': '${newUserInfo['lastname']}',
          'middlename': '${newUserInfo['middlename']}',
          'prefix': '',
          'suffix': '',
          'gender': '${newUserInfo['gender']}',
          "custom_attributes": [
            {"attribute_code": "phone_number", "value": '${newUserInfo['phone']}'}
          ]
        },
        'password': '${newUserInfo['password']}'
      },
    ),
  );
  Map<String, dynamic> responseMap = json.decode(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    throw '$responseMap';
  }
}

Future<void> sfAPISaveProfilePicture(File file, int customerId) async {
  Uint8List imageBytes = await file.readAsBytesSync();
  // List<int> imageBytes = await file.readAsBytesSync();
  String base64Image = base64Encode(imageBytes);

  log(' ============  image file path is :: ${file.path}  ========');

  log('======= base 64 encode is :: $base64Image');
  Uri url = Uri.parse('${APIEndPoints.uploadUserSelfie}?customer_id=$customerId');
  // Uri url = Uri.parse('${APIEndPoints.saveProfilePicture}');
  http.Response response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${APITokens.bearerToken}',
    },
    body: json.encode(
      {
        "customer_id": customerId,
        "file": "image.jpeg",
        "content": {
          "base64EncodedData": base64Image,
          "type": "image/jpeg",
          "name": "$customerId${DateTime.now().millisecondsSinceEpoch.toString()}.jpg",
        }
      },
    ),
  );
  log(' ===== response of uploading API :: ${json.decode(response.body)}');
  dynamic responseMap = json.decode(response.body);
  if (response.statusCode != 200) {
    print('failed to save profile picture');
  }
}

Future<bool> sfAPISubscribeCustomerToGold(Map<String, String> cardDetails) async {
  Uri url = Uri.parse('${APIEndPoints.subscribe}');
  try {
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APITokens.bearerToken}',
      },
      body: json.encode(cardDetails),
    );
    print(json.encode(cardDetails));

    if (response.statusCode != 200) {
      print(response.body);
      throw 'Could not complete subsciption';
    } else {
      Map responseBody = json.decode(json.decode(response.body));
      if (!responseBody['success']) {
        throw responseBody;
      }
      return responseBody['success'];
    }
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}

Future<bool> sfAPIResetPassword(String email) async {
  try {
    Uri url = Uri.parse('${APIEndPoints.resetPassword}?email=$email&template=email_reset');
    Map<String, String> headers = {
      'Authorization': 'Bearer 3z17y9umegbw7eis72wjz682phvuvnxg',
      'Content-Type': 'application/json',
    };
    http.Request request = http.Request('PUT', url);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw (await response.stream.bytesToString());
    }
    bool responseBody = json.decode(await response.stream.bytesToString());
    return responseBody;
  } catch (err) {
    print('Error sfAPIResetPassword: $err');
    rethrow;
  }
}
