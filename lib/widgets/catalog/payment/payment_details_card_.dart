import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/msProfileController.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/states/local_storage.dart';
import 'package:sofiqe/widgets/custom_white_cards.dart';

import '../../../config.dart';
import '../../capsule_button_checkout.dart';

class PaymentDetailsPageCard extends StatefulWidget {
  final void Function(Map<String, dynamic>) callback;
  final String changeAddress;

  PaymentDetailsPageCard(this.changeAddress, {Key? key, required this.callback}) : super(key: key);

  @override
  State<PaymentDetailsPageCard> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPageCard> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();
  MsProfileController _ = Get.find<MsProfileController>();
  List cardList = [];

  @override
  void initState() {
    super.initState();
    // controller.addListener(update);

    getData();
  }

  void update() => setState(() {});

  @override
  void dispose() {
    // controller.removeListener(update);
    controller.dispose();
    super.dispose();
  }

  getData() async {
    if (!_.isShiping.value) {
      billingInformation = "Off";
    } else {
      billingInformation = "On";
    }

    await _.getUserCardDetailes();
    // for (int i = 0; i < _.atmCards.length; i++) {
    //   try {
    //     cardList.add("${_.atmCards[i].number} ${_.atmCards[i].number!.replaceRange(0, 13, "*****")}");
    //   } catch (e) {}
    // }

    print("cardList = $cardList");
    setState(() {
      for (int i = 0; i < _.atmCards.length; i++) {
        try {
          cardList.add("${_.atmCards[i].number} ${_.atmCards[i].number!.replaceRange(0, 13, "*****")}");
        } catch (e) {}
      }
    });
  }

  // void _storeCard() {
  //   sfStoreCardInformation({
  //     'cardNumber': '${_cardNumberController.value.text}',
  //     'expiration': '${_expirationController.value.text}',
  //   });
  // }

  void autoFillIfAvailable() async {
    // CardNumber
    Map<String, dynamic> cardNumberMap =
        await sfQueryForSharedPrefData(fieldName: 'card-number', type: PreferencesDataType.STRING);
    if (cardNumberMap['found']) {
      _cardNumberController.text = cardNumberMap['card-number'];
    }

    // Expiration
    Map<String, dynamic> expirationMap =
        await sfQueryForSharedPrefData(fieldName: 'expiration', type: PreferencesDataType.STRING);
    if (expirationMap['found']) {
      _expirationController.text = expirationMap['expiration'];
    }
  }

  bool showCard = false;
  bool storeCard = true;
  bool setDefault = true;
  String saveCardInformation = "on";
  String saveCreditInformation = "on";
  String billingInformation = "on";
  var height;
  var isLoggedIn;
  String value = "";
  final controller = CardFormEditController(
      initialDetails:
          CardFieldInputDetails(cvc: "123", complete: true, number: "424242424242", expiryMonth: 12, expiryYear: 24));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    isLoggedIn = Provider.of<CartProvider>(context).isLoggedIn;

    return SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
          child: Column(
            children: [
              CardFormField(
                controller: controller,
                onCardChanged: (details) {
                  setState(() {});
                },
                // style: CardFormStyle(
                //   borderColor: Colors.blueGrey,
                //   textColor: Colors.black,
                //   fontSize: 24,
                //   placeholderColor: Colors.blue,
                // ),
              ),
              CustomWhiteCards(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                child: [
                  CapsuleButtonCheckout(
                    height: 50,
                    onPress: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (controller.details.complete) {
                        context.loaderOverlay.show();
                        _handlePayPress().then((value) {
                          print("Brijesh");
                        });
                      } else {
                        controller.details.printError();
                        print(controller.details.toJson());
                        Fluttertoast.showToast(msg: "Some details in the cart are incorrect/incomplete");
                      }

                      // print("click ${controller.details.complete}");
                      // controller.details.complete == true
                      //     ?
                      //     : Fluttertoast.showToast(msg: "Order Failed ");
                    },
                    child: Text(
                      'PAY',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.white,
                            fontSize: height * 0.02,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'By continuing you accept Sofiqes',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.black,
                              fontSize: 10,
                              letterSpacing: 0.4,
                            ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'terms and condition',
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontSize: 10,
                                letterSpacing: 0.4,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Container(color: Colors.white),
              // ResponseCard(
              //   response: controller.details.toJson().toString(),
              // ),
            ],
          )),
    );
  }

  Future<void> _handlePayPress() async {
    try {
      print('click 3');
      Map<String, dynamic> resultFirstName =
          await sfQueryForSharedPrefData(fieldName: 'firstname', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultEmail =
          await sfQueryForSharedPrefData(fieldName: 'email', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultPhoneNumber =
          await sfQueryForSharedPrefData(fieldName: 'telephone', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultCity =
          await sfQueryForSharedPrefData(fieldName: 'city', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultRegion =
          await sfQueryForSharedPrefData(fieldName: 'region', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultStreet =
          await sfQueryForSharedPrefData(fieldName: 'street', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultPostcode =
          await sfQueryForSharedPrefData(fieldName: 'postcode', type: PreferencesDataType.STRING);

      print("result email ${resultEmail}");

      // 1. Gather customer billing information (ex. email)
      print('click 2');

      final billingDetails = BillingDetails(
        name: resultFirstName.values.last,
        email: resultEmail.values.last,
        phone: resultPhoneNumber.values.last,
        address: Address(
          city: resultCity.values.last,
          country: resultRegion.values.last,
          line1: resultStreet.values.last,
          line2: '',
          state: '',
          postalCode: resultPostcode.values.last,
        ),
      ); // mocked data for tests

      // 2. Create payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: billingDetails,
          ),
        ),
      );
      print("payment =====id===${paymentMethod.id}");
      context.loaderOverlay.hide();
      widget.callback({
        "card": {"id": paymentMethod.id},
        "method": "stripe-card"
      });
      Navigator.pop(context);
      // Navigator.push(context, MaterialPageRoute(builder: (context1) {
      //   return OrderProcessing(
      //     cardDetails: {"id": paymentMethod.id},
      //     payment_method: "stripe-card",
      //   );
      // }));
    } catch (e) {
      context.loaderOverlay.hide();

      Fluttertoast.showToast(msg: "Order Failed $e ");
    }

    // widget.callback.call({"id": paymentMethod.id});
  }

  CardFieldInputDetails? card;

  // bool? _saveCard = false;
  // Future<void> _handlePayPress() async {
  //   // 1. fetch Intent Client Secret from backend
  //   final clientSecret = await fetchPaymentIntentClientSecret();
  //   print("clientSecret ===>" + clientSecret.toString());
  //   Map<String, dynamic> resultFirstName = await sfQueryForSharedPrefData(
  //       fieldName: 'firstname', type: PreferencesDataType.STRING);
  //   Map<String, dynamic> resultEmail = await sfQueryForSharedPrefData(
  //       fieldName: 'email', type: PreferencesDataType.STRING);
  //   Map<String, dynamic> resultPhoneNumber = await sfQueryForSharedPrefData(
  //       fieldName: 'telephone', type: PreferencesDataType.STRING);
  //   Map<String, dynamic> resultCity = await sfQueryForSharedPrefData(
  //       fieldName: 'city', type: PreferencesDataType.STRING);
  //   Map<String, dynamic> resultRegion = await sfQueryForSharedPrefData(
  //       fieldName: 'region', type: PreferencesDataType.STRING);
  //   Map<String, dynamic> resultStreet = await sfQueryForSharedPrefData(
  //       fieldName: 'street', type: PreferencesDataType.STRING);
  //   Map<String, dynamic> resultPostcode = await sfQueryForSharedPrefData(
  //       fieldName: 'postcode', type: PreferencesDataType.STRING);
  //   // 2. Gather customer billing information (ex. email)
  //   final billingDetails = BillingDetails(
  //     name: resultFirstName.values.last,
  //     email: resultEmail.values.last,
  //     phone: resultPhoneNumber.values.last,
  //     address: Address(
  //       city: resultCity.values.last,
  //       country: resultRegion.values.last,
  //       line1: resultStreet.values.last,
  //       line2: '',
  //       state: '',
  //       postalCode: resultPostcode.values.last,
  //     ),
  //   ); // mocked data for tests
  //   // 3. Confirm payment with card details
  //   // The rest will be done automatically using webhooks
  //   // ignore: unused_local_variable
  //   final paymentIntent = await Stripe.instance.confirmPayment(
  //     paymentIntentClientSecret: clientSecret['clientSecret'],
  //     data: PaymentMethodParams.card(
  //       paymentMethodData: PaymentMethodData(
  //         billingDetails: billingDetails,
  //       ),
  //     ),
  //     options: PaymentMethodOptions(
  //       setupFutureUsage: _saveCard == true
  //           ? PaymentIntentsFutureUsage.OffSession
  //           : PaymentIntentsFutureUsage.OnSession,
  //     ),
  //   );
  //
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('Success!: The payment was confirmed successfully!')));
  // }

  // Future<Map<String, dynamic>> fetchPaymentIntentClientSecret() async {
  //   // Stripe.createSourceWithParams(SourceParams(
  //   //   type: 'ideal',
  //   //   amount: 2102,
  //   //   currency: 'eur',
  //   //   returnURL: 'example://stripe-redirect',
  //   // )).then((source) {
  //   //   _scaffoldKey.currentState
  //   //       .showSnackBar(SnackBar(content: Text('Received ${source.sourceId}')));
  //   //   setState(() {
  //   //     _source = source;
  //   //   });
  //   // }).catchError(setError);
  //   final url = Uri.parse('$kApiUrl/create-payment-intent');
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: json.encode({
  //       'currency': 'usd',
  //       'amount': 10,
  //       'payment_method_types': ['card']
  //     }),
  //   );
  //   return json.decode(response.body);
  // }
  //
  Future<void> confirmIntent(String paymentIntentId) async {
    final result = await callNoWebhookPayEndpointIntentId(paymentIntentId: paymentIntentId);
    if (result['error'] != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${result['error']}')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success!: The payment was confirmed successfully!')));
    }
  }

  Future<Map<String, dynamic>> callNoWebhookPayEndpointIntentId({
    required String paymentIntentId,
  }) async {
    final url = Uri.parse('$kApiUrl');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'paymentIntentId': paymentIntentId}),
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> callNoWebhookPayEndpointMethodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    List<String>? items,
  }) async {
    final url = Uri.parse('$kApiUrl');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
          {'useStripeSdk': useStripeSdk, 'paymentMethodId': paymentMethodId, 'currency': currency, 'items': items}),
    );
    return json.decode(response.body);
  }

  bool isUpdate = true;

  final String salesPolicyUrl = 'https://sofiqe.com/terms-and-conditions';

  // void _launchURL() async {
  //   await launchUrl(Uri.parse(salesPolicyUrl));
  // }

  Widget coverWidgetWithPadding({Widget? child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }

  Widget displayGenderContainer({required String image, required String title}) {
    return InkWell(
      onTap: () {
        _.selectedGender = title;
      },
      child: Container(
        height: 65,
        width: 58,
        decoration: BoxDecoration(
          border: (title == _.selectedGender) ? Border(bottom: BorderSide(color: Color(0xffF2CA8A))) : null,
          color: (title == _.selectedGender) ? Color(0xffF4F2F0) : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/$image',
              height: 28,
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 8, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  bool checkEmpty() {
    if (_.isShiping.value) {
      if (_.nameController.value.text.isEmpty ||
          _.countryController.value.text.isEmpty ||
          _.streetController.value.text.isEmpty ||
          _.postCodeController.value.text.isEmpty ||
          _.cityController.value.text.isEmpty ||
          _.phoneController.value.text.isEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      if (_.nameController.value.text.isEmpty ||
          _.countryController.value.text.isEmpty ||
          _.streetController.value.text.isEmpty ||
          _.postCodeController.value.text.isEmpty ||
          _.cityController.value.text.isEmpty ||
          _.phoneController.value.text.isEmpty ||
          _.billingNameController.value.text.isEmpty ||
          _.billingCountryController.value.text.isEmpty ||
          _.billingStreetController.value.text.isEmpty ||
          _.billingPostZipController.value.text.isEmpty ||
          _.billingCityController.value.text.isEmpty ||
          _.billingPhoneController.value.text.isEmpty) {
        return true;
      } else {
        return false;
      }
    }
  }

  displayTextFieldContainer(
      {String? title,
      TextEditingController? controller,
      Color? backgroundColor,
      String? prefix,
      TextInputType? textInputType,
      String? hint}) {
    return Container(
      height: 66,
      color: backgroundColor,
      padding: EdgeInsets.only(top: 5),
      child: coverWidgetWithPadding(
          child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    title!,
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                  Text(
                    ' *',
                    style: TextStyle(fontSize: 11, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
          TextFormField(
            validator: (str) {
              if (str == '' || str == null) {
                isUpdate = false;
              }
              return null;
            },
            keyboardType: textInputType ?? TextInputType.text,
            controller: controller,
            decoration: InputDecoration(hintText: hint, prefixText: prefix, border: InputBorder.none),
          ),
        ],
      )),
    );
  }

  displayTextFieldPhoneContainer(
      {String? title,
      TextEditingController? controller,
      Color? backgroundColor,
      Widget? prefix,
      TextInputType? textInputType,
      String? hint}) {
    return Container(
      height: 66,
      color: backgroundColor,
      padding: EdgeInsets.only(top: 5),
      child: coverWidgetWithPadding(
          child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    title!,
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                  Text(
                    ' *',
                    style: TextStyle(fontSize: 11, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            validator: (str) {
              if (str == '' || str == null) {
                isUpdate = false;
              }
              return null;
            },
            keyboardType: textInputType ?? TextInputType.text,
            controller: controller,
            decoration: InputDecoration(hintText: hint, prefixIcon: prefix, border: InputBorder.none),
          ),
        ],
      )),
    );
  }

  displayColorDivider() {
    return Divider(
      color: Color(0xffF4F2F0),
      thickness: 5,
    );
  }
}

class CustomFormFieldPaymentCard extends StatelessWidget {
  final String icon;
  final String label;
  final TextEditingController controller;
  final double height;
  final double width;
  final Color backgroundColor;
  final Widget? prefix;
  final Widget? backgroundWidget;
  final String placeHolder;
  final bool active;
  final Function? onTap;
  final bool obscure;
  final Function? onChange;
  final double? space;

  const CustomFormFieldPaymentCard(
      {Key? key,
      required this.label,
      required this.icon,
      required this.controller,
      this.height = 45,
      this.width = 200,
      this.backgroundColor = Colors.white,
      this.prefix,
      this.backgroundWidget,
      this.placeHolder = '',
      this.active = true,
      this.onTap,
      this.obscure = false,
      this.onChange,
      this.space})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$label',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
              ),
            ],
          ),
          SizedBox(height: space ?? 10),
          ClipRRect(
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: GestureDetector(
                child: CupertinoTextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberFormatter(),
                  ],
                  maxLength: 19,
                  onChanged: onChange == null ? (val) {} : onChange as Function(String),
                  obscureText: obscure,
                  enabled: active,
                  placeholder: '$placeHolder',
                  placeholderStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Color(0xFFD0C5C5),
                        fontSize: size.height * 0.017,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.bold,
                      ),
                  prefix: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Center(
                      child: prefix,
                    ),
                  ),
                  suffix: (icon == "pay")
                      ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(
                            "assets/images/pay.png",
                            height: 30,
                            width: 30,
                          ),
                        )
                      : Container(),
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        fontSize: size.height * 0.018,
                        letterSpacing: 0.5,
                      ),
                  controller: controller,
                  decoration: BoxDecoration(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFormFieldPaymentCardExpiry extends StatelessWidget {
  final String icon;
  final String label;
  final TextEditingController controller;
  final double height;
  final double width;
  final Color backgroundColor;
  final Widget? prefix;
  final Widget? backgroundWidget;
  final String placeHolder;
  final bool active;
  final Function? onTap;
  final bool obscure;
  final Function? onChange;
  final double? space;

  const CustomFormFieldPaymentCardExpiry(
      {Key? key,
      required this.label,
      required this.icon,
      required this.controller,
      this.height = 45,
      this.width = 200,
      this.backgroundColor = Colors.white,
      this.prefix,
      this.backgroundWidget,
      this.placeHolder = '',
      this.active = true,
      this.onTap,
      this.obscure = false,
      this.onChange,
      this.space})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$label',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
              ),
            ],
          ),
          SizedBox(height: space ?? 10),
          ClipRRect(
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: GestureDetector(
                child: CupertinoTextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardExpiryFormatter(),
                  ],
                  maxLength: 5,
                  onChanged: onChange == null ? (val) {} : onChange as Function(String),
                  obscureText: obscure,
                  enabled: active,
                  placeholder: '$placeHolder',
                  placeholderStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Color(0xFFD0C5C5),
                        fontSize: size.height * 0.017,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.bold,
                      ),
                  prefix: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Center(
                      child: prefix,
                    ),
                  ),
                  suffix: (icon == "pay")
                      ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(
                            "assets/images/pay.png",
                            height: 30,
                            width: 30,
                          ),
                        )
                      : Container(),
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        fontSize: size.height * 0.018,
                        letterSpacing: 0.5,
                      ),
                  controller: controller,
                  decoration: BoxDecoration(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFormFieldPaymentCvc extends StatelessWidget {
  final String icon;
  final String label;
  final TextEditingController controller;
  final double height;
  final double width;
  final Color backgroundColor;
  final Widget? prefix;
  final Widget? backgroundWidget;
  final String placeHolder;
  final bool active;
  final Function? onTap;
  final bool obscure;
  final Function? onChange;
  final double? space;

  const CustomFormFieldPaymentCvc(
      {Key? key,
      required this.label,
      required this.icon,
      required this.controller,
      this.height = 45,
      this.width = 200,
      this.backgroundColor = Colors.white,
      this.prefix,
      this.backgroundWidget,
      this.placeHolder = '',
      this.active = true,
      this.onTap,
      this.obscure = false,
      this.onChange,
      this.space})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$label',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
              ),
            ],
          ),
          SizedBox(height: space ?? 10),
          ClipRRect(
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: GestureDetector(
                child: CupertinoTextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 3,
                  onChanged: onChange == null ? (val) {} : onChange as Function(String),
                  obscureText: obscure,
                  enabled: active,
                  placeholder: '$placeHolder',
                  placeholderStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Color(0xFFD0C5C5),
                        fontSize: size.height * 0.017,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.bold,
                      ),
                  prefix: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Center(
                      child: prefix,
                    ),
                  ),
                  suffix: (icon == "pay")
                      ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(
                            "assets/images/pay.png",
                            height: 30,
                            width: 30,
                          ),
                        )
                      : Container(),
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        fontSize: size.height * 0.018,
                        letterSpacing: 0.5,
                      ),
                  controller: controller,
                  decoration: BoxDecoration(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = new StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: new TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class CardExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = new StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 2 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write('/');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: new TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
