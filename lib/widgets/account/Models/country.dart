class Country {
  String? id;
  String? twoLetterAbbreviation;
  String? threeLetterAbbreviation;
  String? fullNameLocale;
  String? fullNameEnglish;
  List<AvailableRegions>? availableRegions;

  Country(
      {this.id,
      this.twoLetterAbbreviation,
      this.threeLetterAbbreviation,
      this.fullNameLocale,
      this.fullNameEnglish,
      this.availableRegions});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    twoLetterAbbreviation = json['two_letter_abbreviation'];
    threeLetterAbbreviation = json['three_letter_abbreviation'];
    fullNameLocale = json['full_name_locale'];
    fullNameEnglish = json['full_name_english'];
    if (json['available_regions'] != null) {
      availableRegions = <AvailableRegions>[];
      json['available_regions'].forEach((v) {
        availableRegions!.add(new AvailableRegions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['two_letter_abbreviation'] = this.twoLetterAbbreviation;
    data['three_letter_abbreviation'] = this.threeLetterAbbreviation;
    data['full_name_locale'] = this.fullNameLocale;
    data['full_name_english'] = this.fullNameEnglish;
    if (this.availableRegions != null) {
      data['available_regions'] =
          this.availableRegions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailableRegions {
  String? id;
  String? code;
  String? name;

  AvailableRegions({this.id, this.code, this.name});

  AvailableRegions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}