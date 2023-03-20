// To parse this JSON data, do
//
//     final configurableItemOption = configurableItemOptionFromJson(jsonString);

import 'dart:convert';

List<ConfigurableItemOption> configurableItemOptionFromJson(String str) => List<ConfigurableItemOption>.from(json.decode(str).map((x) => ConfigurableItemOption.fromJson(x)));

String configurableItemOptionToJson(List<ConfigurableItemOption> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConfigurableItemOption {
  ConfigurableItemOption({
    this.optionId,
    this.optionValue,
  });

  String? optionId;
  int? optionValue;

  factory ConfigurableItemOption.fromJson(Map<String, dynamic> json) => ConfigurableItemOption(
    optionId: json["option_id"],
    optionValue: json["option_value"],
  );

  Map<String, dynamic> toJson() => {
    "option_id": optionId,
    "option_value": optionValue,
  };
}
