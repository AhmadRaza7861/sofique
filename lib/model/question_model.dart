// To parse this JSON data, do
//
//     final Question = QuestionFromJson(jsonString);

import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({
    this.status,
    this.message,
    this.code,
    this.result,
  });

  bool? status;
  String? message;
  String? code;
  List<Result>? result;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.entityId,
    this.questionId,
    this.questionType,
    this.questions,
    this.answers,
  });

  int? entityId;
  int? questionId;
  String? questionType;
  String? questions;
  Map<String, dynamic>? answers;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        entityId: json["entity_id"],
        questionId: json["question_id"],
        questionType:
            json["question_type"] == null ? "" : json["question_type"],
        questions: json["questions"],
        answers: json["answers"]// Map<String, dynamic>.from(.map((x) => Result.fromJson(x),
        );

  Map<String, dynamic> toJson() => {
        "entity_id": entityId,
        "question_id": questionId,
        "question_type": questionType,
        "questions": questions,
        "answers": answers,
      };
}

// class Answers {
//   Answers({
//     this.option1,
//     this.option2,
//     this.option3,
//     this.option4,
//     this.option5,
//     this.option6,
//     this.option7,
//   });

//   String? option1;
//   String? option2;
//   String? option3;
//   String? option4;
//   String? option5;
//   String? option6;
//   String? option7;

//   factory Answers.fromJson(Map<String, dynamic> json) => Answers(
//         option1: json["option_1"] == null ? "" : json["option_1"],
//         option2: json["option_2"] == null ? "" : json["option_2"],
//         option3: json["option_3"] == null ? "" : json["option_3"],
//         option4: json["option_4"] == null ? "" : json["option_4"],
//         option5: json["option_5"] == null ? "" : json["option_5"],
//         option6: json["option_6"] == null ? "" : json["option_6"],
//         option7: json["option_7"] == null ? "" : json["option_7"],
//       );

//   Map<String, dynamic> toJson() => {
//         "option_1": option1 == null ? "" : option1,
//         "option_2": option2 == null ? "" : option2,
//         "option_3": option3 == null ? "" : option3,
//         "option_4": option4 == null ? "" : option4,
//         "option_5": option5 == null ? "" : option5,
//         "option_6": option6 == null ? "" : option6,
//         "option_7": option7 == null ? "" : option7,
//       };
// }
