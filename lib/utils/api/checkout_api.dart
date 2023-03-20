// ignore_for_file: unused_local_variable

import 'dart:convert';

// 3rd party packages
import 'package:http/http.dart' as http;
// Utils
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';
import 'package:sofiqe/utils/states/local_storage.dart';

//Araj API 148. get payment methods with reward points
Future<List> sfAPIGetPaymentMethods(int cartDetail) async {
  try {
    Uri uri = Uri.parse(APIEndPoints.getPaymentMethods(cartDetail));
    var token = APITokens.adminBearerId;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    http.Request request = http.Request('GET', uri);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode != 200) {
      throw await response.stream.bytesToString();
    }
    List responseBody = json.decode(await response.stream.bytesToString());
    return responseBody;
  } catch (err) {
    print("error");
    rethrow;
  }
}

//Araj API get payment methods: for guest call 160
Future<List> sfAPIGetPaymentMethodsForGuest() async {
  try {
    String cartIdG =
        (await sfQueryForSharedPrefData(fieldName: 'cart-token', type: PreferencesDataType.STRING)).values.last;
    Uri uri = Uri.parse(APIEndPoints.getPaymentMethodsForGuest(cartIdG));
    var token = APITokens.adminBearerId;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      uri,
      headers: headers,
    );
    print(response.body);
    var result = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw result;
    }
    print("PMG=$result");
    List responseBody = result['payment_methods'];
    return responseBody;
  } catch (err) {
    print("error");
    rethrow;
  }
}

//Araj API 113.a. Generate giftcard
Future<String> sfAPIGenerateGiftCard(String myName, String myEmail, String receiverName, String receiverEmail,
    String yourMsg, String orderId, String customerId, String currency) async {
  try {
    Uri uri = Uri.parse(APIEndPoints.generateGiftCard());
    var token = APITokens.adminBearerId;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(uri,
        headers: headers,
        body: jsonEncode({
          "customerID": customerId,
          "sender_email": myEmail,
          "sender_name": myName,
          "order_number": orderId,
          "receiver_email": receiverEmail,
          "receiver_name": receiverName,
          "currency": currency,
          "message": yourMsg,
        }));

    print(response.body);
    var result = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw result;
    }
    return result;
  } catch (err) {
    print("error =$err");
    rethrow;
  }
}
