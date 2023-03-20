import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/model/ingredients_model.dart';
import 'package:sofiqe/network_service/network_service.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';

Future<List<dynamic>> sfAPIFetchQuestionFromRemote() async {
  Uri url = Uri.parse('${APIEndPoints.questionnaireList}');
  http.Response response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${APITokens.adminBearerId}',
  });
  Map<String, dynamic> questionList = json.decode(response.body);

  return questionList['result'];
  // return _questions;
}

//sajdfgyusadf
//sekgfs
Future<void> sfAPISendQuestionnaireResponse(
    String id, String questionnaireResponse) async {
  var body = {
    "customer_id": id,
    "response": questionnaireResponse,
  };
  print(body);
  Uri url = Uri.parse('${APIEndPoints.questionnaireResponse}');
  http.Response response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await APITokens.customerSavedToken}',
    },
    body: json.encode(body),
  );
  if (response.statusCode == 200) {
    print('Success for questions');
    makeOverProvider.tryitOn.value = true;
  } else {
    print('not working mate' + response.statusCode.toString());
  }
  print(json.encode(questionnaireResponse));
  // Map<String, dynamic> questionList = json.decode(response.body);
  // return questionList['result'];
}

sfAPIgetIngredients() async {
  Iterable ingredients;
  List<Ingredients> ingredientslist = [];

  try {
    http.Response? response = await NetworkHandler.getMethodCall(
        // url: 'https://dev.sofiqe.com/rest/V1/ingredients',
        url: 'https://sofiqe.com/rest/V1/ingredients',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${APITokens.bearerToken}',
      },);
    print("after api  ${response!.statusCode}");

    if (response.statusCode == 200) {
      print("SUCCESS");
      print(response.body);
      ingredients = jsonDecode(response.body);
      ingredients.forEach((element) {
        ingredientslist
            .add(Ingredients(ingredient: element.toString(), isSelect: false));
      });
      return ingredientslist;
    } else {
      print("ERROR");
      return ingredientslist;
    }
  } catch (e) {
    debugPrint(e.toString());
    //rethrow;
  }
}

Future<bool> sfApiPostIngredients(String ingredient) async {
  // var url = Uri.parse('https://dev.sofiqe.com/rest/V1/ingredients');
  var url = Uri.parse('https://sofiqe.com/rest/V1/ingredients');

  final _client = http.Client();
  var body = {"ingredient": "$ingredient"};
  try {
    http.Response response =
        await _client.post(url, body: jsonEncode(body), headers: {
      "Authorization": "Bearer ${APITokens.adminBearerId}",
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      print("SUCCESS");
      print(response.body);
      return true;
    } else {
      print("ERROR");
      return false;
    }
  } catch (e) {
    debugPrint(e.toString());

    return false;
  }
}
