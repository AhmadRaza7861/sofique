// To parse this JSON data, do
//
//     final configurableOption = configurableOptionFromJson(jsonString);

import 'dart:convert';

List<ConfigurableOption> configurableOptionFromJson(String str) => List<ConfigurableOption>.from(json.decode(str).map((x) => ConfigurableOption.fromJson(x)));

String configurableOptionToJson(List<ConfigurableOption> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConfigurableOption {
  ConfigurableOption({
    this.optionId,
    this.optionValue,
  });

  int? optionId;
  int? optionValue;

  factory ConfigurableOption.fromJson(Map<String, dynamic> json) => ConfigurableOption(
    optionId: json["optionId"],
    optionValue: json["optionValue"],
  );

  Map<String, dynamic> toJson() => {
    "optionId": optionId,
    "optionValue": optionValue,
  };
}
