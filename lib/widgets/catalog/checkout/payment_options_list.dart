// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pay/pay.dart' as pay;
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/controller/msProfileController.dart';
import 'package:sofiqe/controller/orderProcessing.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/clearpay_payment_screen.dart';
import 'package:sofiqe/screens/delivery_details_screen.dart';
import 'package:sofiqe/screens/order_confirmation_screen.dart';
import 'package:sofiqe/screens/payment_details_card_screen.dart';
import 'package:sofiqe/utils/api/shipping_address_api.dart';
import 'package:sofiqe/utils/states/local_storage.dart';
import 'package:sofiqe/widgets/catalog/checkout/giftcard_page.dart';
import 'package:sofiqe/widgets/catalog/checkout/widget_loader_with_text.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/checkout.dart';
import '../../../screens/MS8/looks_package_details.dart';
import '../../../utils/states/user_account_data.dart';
import '../../Dialogue/erro_dialogue.dart';

enum PaymentOptions { ApplePay, CreditCardPay, PayPalPay }
// enum PaymentOptions { ApplePay, CreditCardPay }

//! All the commented code are left for future use just in case
class PaymentOptionsList extends StatefulWidget {
  const PaymentOptionsList({Key? key}) : super(key: key);

  @override
  _PaymentOptionsListState createState() => _PaymentOptionsListState();
}

var cartId;

class _PaymentOptionsListState extends State<PaymentOptionsList> {
  @override
  void initState() {
    super.initState();
    _tryLocal();
  }

  List<Widget> paymentOptions = [
    PayWithCard(),
    PayPalPay(),
    ClearPay(),
  ];

  PaymentOptions selectedOption = PaymentOptions.ApplePay;

  void onTap(PaymentOptions selectedOption) {
    setState(() {
      this.selectedOption = selectedOption;
    });
  }

  Widget paymentButton(String asset, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PngIcon(image: asset, color: Colors.white),
        SizedBox(width: 6.6),
        Text(
          text,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 0.7,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  String country = '';
  String countryName = '';
  String region = '';
  String street = '';
  String zip = '';
  String city = '';
  String name = '';
  String phoneNumber = '';
  String email = '';

  String address = '';
  bool addressAvailable = false;
  CheckoutMethods? checkoutList;
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    cartId = Provider.of<CartProvider>(context).cartDetails!['id'];
    final Uri _url = Uri.parse('https://sofiqe.com/terms-and-conditions');

    Future<void> callTerms() async {
      if (!await launchUrl(_url)) {
        throw 'Could not launch $_url';
      }
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.5, vertical: 0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "By continuing you accept Sofiqe's ",
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Color(0xFF000000),
                            fontSize: height * 0.012,
                            fontFamily: "Arial",
                            letterSpacing: 0.4,
                          ),
                    ),
                    InkWell(
                      onTap: () {
                        callTerms();
                      },
                      child: Text(
                        "terms and conditions",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Color(0xFF5363F6),
                              decoration: TextDecoration.underline,
                              fontSize: height * 0.012,
                              fontFamily: "Arial",
                              letterSpacing: 0.4,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          _OptionsList(
            onTap: onTap,
            paymentOptions: paymentOptions,
            selectedOption: selectedOption,
          ),
          //Module Under Testing
          if (Platform.isAndroid) PayWithGooglePay(Provider.of<CartProvider>(context).isLoggedIn),
          if (Platform.isIOS) PayWithApplePay(Provider.of<CartProvider>(context).isLoggedIn),

          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                calcualteSplit(context),
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Color(0xFF000000),
                      fontSize: height * 0.013,
                      fontFamily: "Arial",
                      letterSpacing: 0.4,
                    ),
              ),
              Container(
                width: height * 0.09,
                child: Image.asset(
                  "assets/images/clearpay_new_latest.png",
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new LearnMoreDialog();
                      },
                      fullscreenDialog: true));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                    width: height * 0.018,
                    child: Image.asset(
                      "assets/images/information_black.png",
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          SecureWithEnciption(),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  String calcualteSplit(BuildContext context) {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName);

    double totalPrice = double.parse(Provider.of<CartProvider>(context).chargesList[3]['amount'].toString());
    double splitAmount = totalPrice / 4;
    return "or 4 interest free installments of ${format.currencySymbol}" + splitAmount.toStringAsFixed(2) + " with ";
  }

  Future<void> _tryLocal() async {
    // shippingModel.totals
    Map<String, dynamic> resultCountryCode =
        await sfQueryForSharedPrefData(fieldName: 'country', type: PreferencesDataType.STRING);
    Map<String, dynamic> resultCountryName =
        await sfQueryForSharedPrefData(fieldName: 'country_name', type: PreferencesDataType.STRING);
    Map<String, dynamic> resultRegionCode =
        await sfQueryForSharedPrefData(fieldName: 'region', type: PreferencesDataType.STRING);
    Map<String, dynamic> resultStreet =
        await sfQueryForSharedPrefData(fieldName: 'street', type: PreferencesDataType.STRING);
    Map<String, dynamic> resultPostcode =
        await sfQueryForSharedPrefData(fieldName: 'postcode', type: PreferencesDataType.STRING);
    Map<String, dynamic> resultCity =
        await sfQueryForSharedPrefData(fieldName: 'city', type: PreferencesDataType.STRING);
    Map<String, dynamic> resultName =
        await sfQueryForSharedPrefData(fieldName: 'name', type: PreferencesDataType.STRING);
    Map<String, dynamic> resultPhoneNumber =
        await sfQueryForSharedPrefData(fieldName: 'telephone', type: PreferencesDataType.STRING);
    Map<String, dynamic> resultEmail =
        await sfQueryForSharedPrefData(fieldName: 'email', type: PreferencesDataType.STRING);

    if (resultCountryCode['found'] &&
        resultRegionCode['found'] &&
        resultStreet['found'] &&
        resultPostcode['found'] &&
        resultCity['found'] &&
        resultName['found'] &&
        resultPhoneNumber['found'] &&
        resultEmail['found']) {
      country = resultCountryCode['country'];
      countryName = resultCountryName['country_name'];
      region = resultRegionCode['region'];
      street = json.decode(resultStreet['street'])[0];
      zip = resultPostcode['postcode'];
      city = resultCity['city'];
      name = resultName['name'];
      phoneNumber = resultPhoneNumber['telephone'];
      email = resultEmail['email'];
      addressAvailable = true;
      address = 'Delivery address: $street, $city, $zip, $countryName';

      setState(() {});
    }
  }
}

class _OptionsList extends StatelessWidget {
  final List<Widget> paymentOptions;
  final PaymentOptions selectedOption;
  final Function(PaymentOptions) onTap;

  const _OptionsList({Key? key, required this.paymentOptions, required this.selectedOption, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: PaymentOptions.values
              .map((e) =>
                  e.index == 1 ? Container() : _PaymentOption(active: e == selectedOption, child: e, onTap: onTap))
              .toList()),
    );
  }

  Widget googlepay() {
    return Container(
      height: 60,
      padding: EdgeInsets.only(bottom: 10, right: 17, left: 17),
      child: pay.GooglePayButton(
        paymentConfigurationAsset: 'google_pay_payment_profile.json',
        paymentItems: [
          pay.PaymentItem(
            label: 'Total',
            amount: '1',
            status: pay.PaymentItemStatus.final_price,
          )
        ],
        type: pay.GooglePayButtonType.pay,
        margin: const EdgeInsets.only(top: 15),
        onPaymentResult: onGooglePayResult,
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
        onPressed: () async {
          // 1. Add your stripe publishable key to assets/google_pay_payment_profile.json
          await debugChangedStripePublishableKey();
        },
        childOnError: Text('Google Pay is not available in this device'),
        onError: (e) {
          print("Google=========$e");
        },
      ),
    );
  }

  Future<void> debugChangedStripePublishableKey() async {
    if (kDebugMode) {
      final profile = await rootBundle.loadString('assets/google_pay_payment_profile.json');
      final isValidKey = profile.contains(
          "pk_test_51Ge2zLHMAWs8sg7x0WJkDfJGFVH3mTbPatdgowjkSKFWn1UL5igV0j7wwv6IbdBGYhoofzGBcAa90CJvj5mlm8jz00BB7dkElF");
      assert(
        isValidKey,
        'No stripe publishable key added to assets/google_pay_payment_profile.json',
      );
    }
  }

  Future<void> onGooglePayResult(paymentResult) async {
    try {
      // 1. Add your stripe publishable key to assets/google_pay_payment_profile.json

      debugPrint(paymentResult.toString());
      // 2. fetch Intent Client Secret from backend
      final clientSecret =
          "sk_test_51Ge2zLHMAWs8sg7xy8iTDJlDUUzLyWAQAWAjxxGUcwhHKmcbupNeqIVSrPCkqxhtcFGznWJuvqXPi0BObdJs1zhO00vWB50uqL";
      final token = paymentResult['paymentMethodData']['tokenizationData']['token'];
      final tokenJson = Map.castFrom(json.decode(token));
      print(tokenJson);

      final params = PaymentMethodParams.cardFromToken(
        paymentMethodData: PaymentMethodDataCardFromToken(
          token: tokenJson['id'],
        ),
      );

      // 3. Confirm Google pay payment method
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: params,
      );
      print("Google============Google Pay payment succesfully completed");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //       content: Text('Google Pay payment succesfully completed')),
      // );
    } catch (e) {
      print("Google============$e");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
      // );
    }
  }
}

// ignore: must_be_immutable
class _PaymentOption extends StatelessWidget {
  final bool active;
  final Function(PaymentOptions) onTap;
  final PaymentOptions child;

  final MsProfileController msProfileController = Get.find<MsProfileController>();

  _PaymentOption({
    Key? key,
    required this.active,
    required this.child,
    required this.onTap,
  }) : super(key: key);
  int count = 0;

  Widget getPaymentOption(PaymentOptions paymentOptions) {
    switch (paymentOptions) {
      case PaymentOptions.ApplePay:
        return PayWithCard();
      case PaymentOptions.CreditCardPay:
        return PayPalPay();
      case PaymentOptions.PayPalPay:
        return ClearPay();
    }
  }

  var size, height, width;
  var paymentMethod;
  String paymentCode = "";

  var isLoggedIn;
  final TryItOnProvider tiop = Get.find();

  @override
  Widget build(BuildContext context) {
    isLoggedIn = Provider.of<CartProvider>(context).isLoggedIn;
    size = MediaQuery.of(context).size;
    height = size.height;
    return InkWell(
      onTap: () async {
        tiop.isChangeButtonColor.value = true;
        tiop.playSound();
        Future.delayed(Duration(milliseconds: 10)).then((value) async {
          tiop.isChangeButtonColor.value = false;
          tiop.sku.value = "";

          // orderPurchase(context, "");
          // context.loaderOverlay.show();

          print("Index + ${child.index}");

          switch (child.index) {
            case 0:
              paymentMethod = "Payment with";
              break;
            case 1:
              paymentMethod = "PayPal Express Checkout";
              break;
            case 2:
              paymentMethod = "Clearpay";
              break;
          }
          //get payment code

          for (int i = 0; i < (checkoutController.checkoutPaymentMethods ?? []).length; i++) {
            if (checkoutController.checkoutPaymentMethods![i]['title'] == paymentMethod) {
              paymentCode = checkoutController.checkoutPaymentMethods![i]['code'];
              print("-------CODE ++ == $paymentCode");
            }
          }
          //get billing address from local storage if available otherwise user need to add

          Map<String, dynamic> resultRegion =
              await sfQueryForSharedPrefData(fieldName: 'region', type: PreferencesDataType.STRING);

          Map<String, dynamic> resultCountryId =
              await sfQueryForSharedPrefData(fieldName: 'country_id', type: PreferencesDataType.STRING);
          Map<String, dynamic> resultStreet =
              await sfQueryForSharedPrefData(fieldName: 'street', type: PreferencesDataType.STRING);
          Map<String, dynamic> resultPhoneNumber =
              await sfQueryForSharedPrefData(fieldName: 'telephone', type: PreferencesDataType.STRING);
          Map<String, dynamic> resultPostcode =
              await sfQueryForSharedPrefData(fieldName: 'postcode', type: PreferencesDataType.STRING);
          Map<String, dynamic> resultCity =
              await sfQueryForSharedPrefData(fieldName: 'city', type: PreferencesDataType.STRING);
          Map<String, dynamic> resultFirstName =
              await sfQueryForSharedPrefData(fieldName: 'firstname', type: PreferencesDataType.STRING);
          Map<String, dynamic> resultLastName =
              await sfQueryForSharedPrefData(fieldName: 'lastname', type: PreferencesDataType.STRING);
          Map<String, dynamic> resultEmail =
              await sfQueryForSharedPrefData(fieldName: 'email', type: PreferencesDataType.STRING);
          Map<String, dynamic> resultRegionCode =
              await sfQueryForSharedPrefData(fieldName: 'region_code', type: PreferencesDataType.STRING);

          if (resultRegion['found'] &&
              resultCountryId['found'] &&
              resultStreet['found'] &&
              resultPhoneNumber['found'] &&
              resultPostcode['found'] &&
              resultCity['found'] &&
              resultFirstName['found'] &&
              resultLastName['found'] &&
              resultEmail['found'] &&
              resultRegionCode['found']) {
            switch (child.index) {
              case 0:
                context.loaderOverlay.show();
                // //make payment via card
                await checkoutController.getSelectedPaymentMethod(
                    cartId, "stripe_payments"); // Api 149a get payment methods
                context.loaderOverlay.hide();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context1) {
                    return PaymentDetailsScreenPage(
                      "",
                      callback: (value) async {
                        try {
                          context.loaderOverlay.show(
                              widget: LoaderWithText(
                            msg: "We are making the payment...",
                          ));

                          await OrderProcessingController.instance.setLoginStatusandContext(context);
                          context.loaderOverlay.hide();
                          context.loaderOverlay.show(
                              widget: LoaderWithText(
                            msg: "We are making the payment...",
                          ));
                          await OrderProcessingController.instance
                              .processOrder(cardDetails: ((value["card"] ?? {})), payment_method: "stripe-card");
                        } catch (e) {
                          context.loaderOverlay.hide();

                          print("Error in Order Placement");
                          print(e);

                          Dialogue.showGetError(e.toString());

                          // Get.showSnackbar(GetSnackBar(
                          //   title: "Error",
                          //   message: errortoShow,
                          //   duration: Duration(seconds: 2),
                          // ));
                        }
                        // Future.delayed(Duration(milliseconds: 3000)).then(
                        //   (value) {
                        //     print(p0.toString());

                        //     context.loaderOverlay.hide();
                        //   },
                        // );
                      },
                    );
                  },
                ));

                break;
              case 1:

                // // make Paypal payment
                // String redirectUrl;

                // if (!isLoggedIn) {
                //   String cartIdG =
                //       (await sfQueryForSharedPrefData(fieldName: 'cart-token', type: PreferencesDataType.STRING))
                //           .values
                //           .last;
                //   redirectUrl = await checkoutController.getPaypalToken(cartIdG);
                //   print("--------------PP-redirectUrl=$redirectUrl");
                // } else {
                //   redirectUrl = await checkoutController.getPaypalToken(cartId);
                // }
                // print("--------------PP-redirectUrl=$redirectUrl");
                // // make a call with redirectUrl get from API 111a

                break;
              case 2:
                // make ClearPay payment
                String redirectUrl;
                if (!isLoggedIn) {
                  String cartIdG =
                      (await sfQueryForSharedPrefData(fieldName: 'cart-token', type: PreferencesDataType.STRING))
                          .values
                          .last;
                  redirectUrl = await checkoutController.getClearPayToken(cartIdG);
                } else {
                  String cartIdG =
                      (await sfQueryForSharedPrefData(fieldName: 'cart-token', type: PreferencesDataType.STRING))
                          .values
                          .last;
                  print("CP-cartToken=$cartId");
                  print("CP-cartToken=$cartIdG");
                  redirectUrl = await checkoutController.getClearPayToken(cartId);
                }
                print("CP-redirectUrl=$redirectUrl");
                // make a call with redirectUrl for clearpay screenflow
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context1) => ClearPayPayment(
                      redirectUrl: '$redirectUrl',
                      callback: ((p0) async {
                        if (p0 == "SUCCESS") {
                          try {
                            context.loaderOverlay.show(
                                widget: LoaderWithText(
                              msg: "We are making the payment...",
                            ));
                            await OrderProcessingController.instance.setLoginStatusandContext(context);
                            await OrderProcessingController.instance
                                .processOrder(cardDetails: {}, payment_method: "clearPay");
                            // context.loaderOverlay.hide();
                          } catch (e) {
                            context.loaderOverlay.hide();

                            print("Error in Order Placement");
                            print(e);

                            Dialogue.showGetError(e.toString());

                            // Get.showSnackbar(GetSnackBar(
                            //   title: "Error",
                            //   message: errortoShow,
                            //   duration: Duration(seconds: 2),
                            // ));
                          }
                        }
                      }),
                    ),
                  ),
                );

                break;
            }
          } else {
            Get.showSnackbar(GetSnackBar(
              title: "Check Out",
              message: "Please Add Address Details",
              duration: Duration(seconds: 2),
            ));
            print("Address is Not Complete");
          }
          // } else {
          //   deliveryDetailsScreen(context);
          // }
          onTap(child);
          context.loaderOverlay.hide();
        });
      },
      child: Column(
        children: [
          AnimatedContainer(
            key: ValueKey(child),
            duration: Duration(milliseconds: 500),
            margin: EdgeInsets.symmetric(horizontal: 11),
            height: height * 0.06,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: (PaymentOptions.ApplePay == child) ? Color(0xFFF2CA8A) : Colors.white,
            ),
            child: Center(
              child: getPaymentOption(child),
            ),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }

  Future<void> orderPurchaseStripePay(BuildContext context, String stripeToken) async {
    try {
      String orderId =
          await sfApiPlaceOrder(isLoggedIn, cartId, "stripe_payments", {"cc_stripejs_token": "$stripeToken"});
      print("ORDER ID =$orderId");
      if (orderId == "null") {
        orderId = '1';
        print("ORDER  ID == 1");
      }
      await Provider.of<CartProvider>(context, listen: false).deleteCart();
      Provider.of<CartProvider>(context, listen: false).initializeCart();
      if (!isLoggedIn) await sfRemoveAddressInformation();
      if (!isLoggedIn) await MsProfileController.instance.resetControllers();

      if (isLoggedIn) {
        Get.to(GiftCardScreen(
          orderId: orderId,
        ));
      } else {
        Get.to(OrderConfirmationScreen(
          orderId: orderId,
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: "Order",
        message: e.toString(),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> orderPurchase(BuildContext context, String paymentCode) async {
    try {
      String orderId =
          await sfApiPlaceOrder(isLoggedIn, cartId, paymentCode, checkoutController.getAdditionalDataforClearPay());
      print("ORDER ID =$orderId");
      await Provider.of<CartProvider>(context, listen: false).deleteCart();
      Provider.of<CartProvider>(context, listen: false).initializeCart();
      if (!isLoggedIn) await sfRemoveAddressInformation();
      if (!isLoggedIn) await MsProfileController.instance.resetControllers();

      if (isLoggedIn) {
        Get.to(GiftCardScreen(
          orderId: orderId,
        ));
      } else {
        Get.to(OrderConfirmationScreen(
          orderId: orderId,
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: "Order",
        message: e.toString(),
        duration: Duration(seconds: 2),
      ));
    }
  }

  navigatetoNext() {}

  void deliveryDetailsScreen(BuildContext context) {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext _) {
            return DeliveryDetailsScreen(
              "$paymentCode",
              callback: (Map<String, String> cardDetails) async {
                orderPurchase(context, paymentCode);
              },
            );
          },
        ),
      );
    } catch (e) {
      print('Error setting shipping address _NextButton: $e');
    }
  }
}

class PayWithCard extends StatelessWidget {
  PayWithCard({Key? key}) : super(key: key);
  // var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'PAY WITH CARD',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Color(0xFF000000),
                  fontSize: height * 0.018,
                  fontFamily: "Arial",
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
          ),
        ],
      ),
    );
  }
}

class PayPalPay extends StatelessWidget {
  PayPalPay({Key? key}) : super(key: key);
  // var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 27),
          Image.asset(
            'assets/images/paypal.png',
            width: height * 0.09,
          ),
        ],
      ),
    );
  }
}

class SecureWithEnciption extends StatelessWidget {
  SecureWithEnciption({Key? key}) : super(key: key);
  // var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/secure.png",
            width: 80,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "Secure with encryption",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

//GooglePay Button
class PayWithGooglePay extends StatefulWidget {
  PayWithGooglePay(this.isLoggedIn, {Key? key}) : super(key: key);
  // var size, height, width;
  final bool isLoggedIn;

  @override
  State<PayWithGooglePay> createState() => _PayWithGooglePayState();
}

class _PayWithGooglePayState extends State<PayWithGooglePay> {
  onPaymentresult(paymentResult) async {
    try {
      debugPrint(paymentResult.toString());
      // 2. fetch Intent Client Secret from backend

      final token = paymentResult['paymentMethodData']['tokenizationData']['token'];
      final tokenJson = Map.castFrom(json.decode(token));
      // print("Google============Google Pay payment succesfully completed");
      print(tokenJson);
      context.loaderOverlay.show(
          widget: LoaderWithText(
        msg: "We are making the payment...",
      ));

      final params = PaymentMethodParams.cardFromToken(
        paymentMethodData: PaymentMethodDataCardFromToken(
          token: tokenJson['id'],
        ),
      );
      final paymentMethod = await Stripe.instance.createPaymentMethod(params: params);
      print("Google============PaymentMethod");

      await OrderProcessingController.instance.setLoginStatusandContext(context);
      await OrderProcessingController.instance.processOrder(
          cardDetails: {"token": tokenJson['id'], "paymentmthodId": paymentMethod.id}, payment_method: "gpay");
      // context.loaderOverlay.hide();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context1) {
      //   return op.OrderProcessing(
      //     cardDetails: {"token": tokenJson['id'], "paymentmthodId": paymentMethod.id},
      //     payment_method: "gpay",
      //   );
      // }));
    } catch (e) {
      context.loaderOverlay.hide();

      // print("GPE============$e");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: pay.GooglePayButton(
                paymentConfigurationAsset: 'payment/gpay.json',
                paymentItems: [],
                type: pay.GooglePayButtonType.pay,
                // margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onPaymentresult,

                onError: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $error')),
                  );
                },
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Apple Button
class PayWithApplePay extends StatefulWidget {
  PayWithApplePay(this.isLoggedIn, {Key? key}) : super(key: key);
  // var size, height, width;
  final bool isLoggedIn;

  @override
  State<PayWithApplePay> createState() => _PayWithApplePayState();
}

class _PayWithApplePayState extends State<PayWithApplePay> {
  onPaymentresult(paymentResult) async {
    try {
      debugPrint(paymentResult.toString());
      // 2. fetch Intent Client Secret from backend

      final token = paymentResult['paymentMethodData']['tokenizationData']['token'];
      final tokenJson = Map.castFrom(json.decode(token));
      // print("Google============Google Pay payment succesfully completed");
      print(tokenJson);

      final params = PaymentMethodParams.cardFromToken(
        paymentMethodData: PaymentMethodDataCardFromToken(
          token: tokenJson['id'],
        ),
      );
      final paymentMethod = await Stripe.instance.createPaymentMethod(params: params);
      print("Apple============PaymentMethod");
//Get Billing Address
      Map<String, dynamic> resultStreet =
          await sfQueryForSharedPrefData(fieldName: 'street', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultPhoneNumber =
          await sfQueryForSharedPrefData(fieldName: 'telephone', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultPostcode =
          await sfQueryForSharedPrefData(fieldName: 'postcode', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultCity =
          await sfQueryForSharedPrefData(fieldName: 'city', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultFirstName =
          await sfQueryForSharedPrefData(fieldName: 'firstname', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultLastName =
          await sfQueryForSharedPrefData(fieldName: 'lastname', type: PreferencesDataType.STRING);
      Map<String, dynamic> resultEmail =
          await sfQueryForSharedPrefData(fieldName: 'email', type: PreferencesDataType.STRING);

      var billingAddress = {
        "email": "${resultEmail['email']}",
        "region": "Weybridge",
        "region_code": "SU",
        "country_id": "GB",
        "street": ["${resultStreet['street']}"],
        "postcode": "${resultPostcode['postcode']}",
        "city": "${resultCity['city']}",
        "telephone": "${resultPhoneNumber['telephone']}",
        "firstname": "${resultFirstName['firstname']}",
        "lastname": "${resultLastName['lastname']}",
      };
//Get Cart Token
      String cartIdG =
          (await sfQueryForSharedPrefData(fieldName: 'cart-token', type: PreferencesDataType.STRING)).values.last;

      await checkoutController.setPaymentInformationStripeForGuest(cartIdG, tokenJson['id'].toString(), billingAddress);
      String orderId =
          await sfApiPlaceOrder(widget.isLoggedIn, cartId, "stripe_payments", {"cc_stripejs_token": paymentMethod.id});
      print("ORDER ID =$orderId");
      if (orderId == "null") {
        orderId = '1';
        print("ORDER  ID == 1");
      }
      //Delete cart
      await Provider.of<CartProvider>(context, listen: false).deleteCart();
      Provider.of<CartProvider>(context, listen: false).initializeCart();
      if (!widget.isLoggedIn) await sfRemoveAddressInformation();
      if (!widget.isLoggedIn) await MsProfileController.instance.resetControllers();

      if (widget.isLoggedIn) {
        Get.to(GiftCardScreen(
          orderId: orderId,
        ));
      } else {
        Get.to(OrderConfirmationScreen(
          orderId: orderId,
        ));
      }

      // print("Google============Order Placed Succesfully succesfully completed");
    } catch (e) {
      print("APE============$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: pay.ApplePayButton(
                paymentConfigurationAsset: 'payment/apay.json',
                paymentItems: [],
                type: pay.ApplePayButtonType.buy,
                // margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onPaymentresult,

                onError: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $error')),
                  );
                },
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClearPay extends StatelessWidget {
  ClearPay({Key? key}) : super(key: key);
  // var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 27),
          Image.asset(
            'assets/images/clearpay-2.png',
            width: height * 0.17,
          ),
        ],
      ),
    );
  }
}
