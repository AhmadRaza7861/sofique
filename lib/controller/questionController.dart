import 'dart:convert';

import 'package:get/get.dart';
import 'package:sofiqe/model/make_over_question_model.dart';
import 'package:sofiqe/model/question_model.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/utils/constants/api_tokens.dart';

class QuestionsController extends GetxController {
   static QuestionsController get to => Get.find();

  static QuestionsController instance = Get.find();
  List<Result>? question;
  List<MakeOverQuestion> makeover = [];
  Result? skinToneQuestion;
  Result? eyeQuestion;
  Result? hairQuestion;

  ///
  /// Customize the request body
  /// [body] is the request body
  /// [url] is the url of the request
  /// [method] is the method of the request
  ///
  Future<List<MakeOverQuestion>> getAnaliticalQuestions() async {
    Uri url = Uri.parse('${APIEndPoints.questionnaireList}');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${APITokens.adminBearerId}',
    });

    try {
      Iterable types = jsonDecode(response.body)['result'];
      print("APIEndPoints.questionnaireList----" +
          APIEndPoints.questionnaireList);
      print("APIEndPoints bodyy----" + APIEndPoints.questionnaireList);
      print("APITokens.adminBearerId bodyy----" + APITokens.adminBearerId);
      question = types.map((e) => Result.fromJson(e)).toList();
      print(question?.length);
      int count = 0;
      //var check = question![0].answers;
      question!.forEach((element) {
        {
          if (element.answers != null) {
            makeover.add(MakeOverQuestion(
                choices: element.answers!,
                exclusive: '',
                index: count,
                multiSelect:
                ((element.answers!.length > 2 && element.questionId != 3) &&
                    (element.answers!.length < 2 &&
                        element.questionId != 10)) ||
                    (element.questionId == 2 || element.questionId == 4)
                    ? true
                    : false,
                id: element.questionId.toString(),
                question: element.questions!,
                answer: []));
            print('questionId ' + element.questionId.toString());
            print('multiSelect ' +
                (((element.answers!.length > 2 && element.questionId != 3) &&
                    (element.answers!.length < 2 &&
                        element.questionId != 10)) ||
                    (element.questionId == 2 || element.questionId == 4))
                    .toString());
            count++;
          }

          // Code for capturing the Question
          if (element.questions
              .toString()
              .toLowerCase()
              .contains("skin tone")) {
            skinToneQuestion = element;
            print("Skin tone question encountered");
          }

          if (element.questions
              .toString()
              .toLowerCase()
              .contains("eyes do you have")) {
            eyeQuestion = element;
            print("Skin tone question encountered");
          }

          if (element.questions
              .toString()
              .toLowerCase()
              .contains("colour to your hair")) {
            hairQuestion = element;
            print("Skin tone question encountered");
          }

        }
      });
      return makeover;
    }catch(e){
      return [];
    }
  }

  @override
  void onInit() async{
    super.onInit();
    await getAnaliticalQuestions();
  }
}
