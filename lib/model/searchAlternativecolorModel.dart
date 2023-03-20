class SearchCentralColorModel {
  bool? success;
  Values? values;

  SearchCentralColorModel({this.success, this.values});

  SearchCentralColorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    values =
        json['values'] != null ? new Values.fromJson(json['values']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.values != null) {
      data['values'] = this.values!.toJson();
    }
    return data;
  }
}

class Values {
  String? undertone;
  List<Colorss>? colors;

  Values({this.undertone, this.colors});

  Values.fromJson(Map<String, dynamic> json) {
    undertone = json['undertone'];
    if (json['colors'] != null) {
      colors = <Colorss>[];
      json['colors'].forEach((v) {
        colors!.add(new Colorss.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['undertone'] = this.undertone;
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Colorss {
  String? colourAltName;
  String? colourAltHEX;

  Colorss({this.colourAltName, this.colourAltHEX});

  Colorss.fromJson(Map<String, dynamic> json) {
    colourAltName = json['ColourAltName'];
    colourAltHEX = json['ColourAltHEX'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ColourAltName'] = this.colourAltName;
    data['ColourAltHEX'] = this.colourAltHEX;
    return data;
  }
}