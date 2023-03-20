class Currency {
  String? baseCurrencyCode;
  String? baseCurrencySymbol;
  String? defaultDisplayCurrencyCode;
  String? defaultDisplayCurrencySymbol;
  List<String>? availableCurrencyCodes;
  List<ExchangeRates>? exchangeRates;

  Currency(
      {this.baseCurrencyCode,
      this.baseCurrencySymbol,
      this.defaultDisplayCurrencyCode,
      this.defaultDisplayCurrencySymbol,
      this.availableCurrencyCodes,
      this.exchangeRates});

  Currency.fromJson(Map<String, dynamic> json) {
    baseCurrencyCode = json['base_currency_code'];
    baseCurrencySymbol = json['base_currency_symbol'];
    defaultDisplayCurrencyCode = json['default_display_currency_code'];
    defaultDisplayCurrencySymbol = json['default_display_currency_symbol'];
    availableCurrencyCodes = json['available_currency_codes'].cast<String>();
    if (json['exchange_rates'] != null) {
      exchangeRates = <ExchangeRates>[];
      json['exchange_rates'].forEach((v) {
        exchangeRates!.add(new ExchangeRates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_currency_code'] = this.baseCurrencyCode;
    data['base_currency_symbol'] = this.baseCurrencySymbol;
    data['default_display_currency_code'] = this.defaultDisplayCurrencyCode;
    data['default_display_currency_symbol'] = this.defaultDisplayCurrencySymbol;
    data['available_currency_codes'] = this.availableCurrencyCodes;
    if (this.exchangeRates != null) {
      data['exchange_rates'] =
          this.exchangeRates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExchangeRates {
  String? currencyTo;
  double? rate;

  ExchangeRates({this.currencyTo, this.rate});

  ExchangeRates.fromJson(Map<String, dynamic> json) {
    currencyTo = json['currency_to'];
    rate = double.parse((json['rate'] ?? "0").toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_to'] = this.currencyTo;
    data['rate'] = this.rate;
    return data;
  }
}
