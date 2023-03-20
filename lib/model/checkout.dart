import 'dart:convert';

Checkout checkoutFromJson(String str) => Checkout.fromJson(json.decode(str));

String checkoutToJson(Checkout data) => json.encode(data.toJson());

class Checkout {
  Checkout({
    this.code,
    this.title
  });

  String? code;
  String? title;

  Checkout.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
      };
}

class CheckoutMethods {

  List<Data>? checkoutMethodList;
  CheckoutMethods({this.checkoutMethodList});

  CheckoutMethods.fromJson(List<Map<String, dynamic>> json) {
    if (json.isNotEmpty) {
      checkoutMethodList = <Data>[];
      json.forEach((v) {
        checkoutMethodList!.add(Data.fromJson(v));
      });
    }
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> data =  <Map<String, dynamic>>[];
    if (this.checkoutMethodList != null) {
      data = this.checkoutMethodList!.map((v) => v.toJson()).toList();
      print("Data == $data");
    }
    return data;
  }
}

class Data {
  String? code;
  String? title;

  Data(
      {this.code,
        this.title,
        });

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    return data;
  }
}
