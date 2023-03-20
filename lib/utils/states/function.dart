import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sofiqe/controller/currencyController.dart';

extension StringExtension on String {
  Color toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length != 6 && hexColor.length != 8) {
      return Colors.white;
    }
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return Colors.white;
  }

  String toProperCurrencyString() {
    // double rate = 0;
    // double rateToReturn = 0.0;
    // if (this != "" && this.toLowerCase() != "null") {
    //   rate = double.parse(this);
    // }
    // rateToReturn = rate * CurrencyController.to.exchangeRateinDouble.value;
    // return CurrencyController.to.defaultCurrencyCode.value +
    //     " " +
    //     rateToReturn.toStringAsFixed(1);
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    return '${format.currencyName} $this';
  }

  String toProperCurrency() {
    // print("Value from Extenstion Function");
    // print(CurrencyController.to.exchangeRateinDouble.value);
    double rate = 0;
    double rateToReturn = 0.0;
    if (this != "" && this.toLowerCase() != "null") {
      rate = double.parse(this);
    }
    rateToReturn = rate * CurrencyController.to.exchangeRateinDouble.value;
    return CurrencyController.to.defaultCurrencyCode.value + " " + rateToReturn.toStringAsFixed(2);
    // for (int i = 1; i <= CurrencyController.to.exchangeRate.length; i++) {
    //   if (CurrencyController.to.defaultCurrencyCode.value ==
    //       CurrencyController.to.exchangeRate[i]['currency_to']) {
    //     rate = rate * CurrencyController.to.exchangeRate[i]['rate'];
    //   }
    //   return rate.toString();
    // }
  }
}

extension DoubleExtension on double {
  String toProperCurrencyString() {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    return '${format.currencySymbol} ${this.toStringAsFixed(2)}';
  }
}
