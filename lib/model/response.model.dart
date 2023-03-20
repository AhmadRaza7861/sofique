// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

List<dynamic> responseFromJson(String str) =>
    List<dynamic>.from(json.decode(str).map((x) => x));

String responseToJson(List<dynamic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));

class ResponseElement {
  ResponseElement({
    this.questionId,
    this.question,
    this.answers,
  });

  String? questionId;
  String? question;
  List<String?>? answers;

  factory ResponseElement.fromJson(Map<String, dynamic> json) =>
      ResponseElement(
        questionId: json["question_id"],
        question: json["question"],
        answers: List<String>.from(json["answers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question": question,
        "answers": List<dynamic>.from(answers!.map((x) => x)),
      };
}
