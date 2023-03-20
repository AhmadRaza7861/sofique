import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';

import '../../../controller/msProfileController.dart';
import '../../../screens/order_confirmation_screen.dart';
import '../../../utils/api/shipping_address_api.dart';
import '../../../utils/states/local_storage.dart';
import '../../../utils/states/user_account_data.dart';

var isLoggedIn;
var size, height, width;

class OrderProcessing extends StatefulWidget {
  OrderProcessing({Key? key, this.cardDetails, required this.payment_method}) : super(key: key);

  final dynamic cardDetails;
  final String payment_method;

  @override
  State<OrderProcessing> createState() => _OrderProcessingState();
}

class _OrderProcessingState extends State<OrderProcessing> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        cartId = Provider.of<CartProvider>(context, listen: false).cartDetails!['id'] ?? 0;
      });
      processOrder();
    });
  }

  String errorMessage = "";
  bool isError = false;
  int cartId = 0;
  String cartIdG = "";
  var billingAddress;
  processOrder() async {
    try {
      await getandsetupaddress();
      cartIdG = (await sfQueryForSharedPrefData(fieldName: 'cart-token', type: PreferencesDataType.STRING)).values.last;

      if (widget.payment_method == "stripe-card") {
        if (!isLoggedIn) {
          await checkoutController.setPaymentInformationStripeForGuest(
              cartIdG, widget.cardDetails["id"].toString(), billingAddress);
          orderPurchaseStripePay(context, widget.cardDetails["id"].toString());
        } else {
          print(jsonEncode({
            "email": "${billingAddress['email']}",
            "method": {
              // "paymentMethod": {
              "method": "stripe_payments",
              "additional_data": {"cc_stripejs_token": widget.cardDetails["id"].toString()}
            },
            "billing_address": billingAddress
          }));
          print(cartId);

          await checkoutController.getSelectedPaymentMethodStripe(
              cartId, widget.cardDetails["id"].toString(), billingAddress);
          orderPurchaseStripePay(context, widget.cardDetails["id"].toString());
        }
      } else if (widget.payment_method == "clearPay") {
        orderPurchaseClearPayPay();
      } else if (widget.payment_method == "gpay") {
        if (!isLoggedIn) {
          await checkoutController.setPaymentInformationStripeForGuest(
              cartIdG, widget.cardDetails["paymentmthodId"].toString(), billingAddress);
        } else {
          await checkoutController.getSelectedPaymentMethodStripe(
              cartId, widget.cardDetails["token"].toString(), billingAddress);
        }
        String orderId = await sfApiPlaceOrder(
            isLoggedIn, cartId, "stripe_payments", {"cc_stripejs_token": widget.cardDetails["paymentmthodId"]});
        orderPurchaseGoogleApplePay(orderId);
      }
    } catch (e) {
      setState(() {
        isError = true;
        errorMessage = e.toString();
      });
    }
  }

  Future<void> orderPurchaseStripePay(BuildContext context, String stripeToken) async {
    try {
      print("Call Purchase on Card pay");
      String orderId =
          await sfApiPlaceOrder(isLoggedIn, cartId, "stripe_payments", {"cc_stripejs_token": "$stripeToken"});
      print("ORDER ID =$orderId");
      orderSuccess(context, orderId);
    } catch (e) {
      setState(() {
        isError = true;
        errorMessage = e.toString();
      });
      Get.showSnackbar(GetSnackBar(
        title: "Order",
        message: e.toString(),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> orderPurchaseClearPayPay() async {
    try {
      String paymentCode = "clearpay";
      if (!isLoggedIn) {
        await checkoutController.setPaymentInformationClearPayForGuest(cartIdG, paymentCode, billingAddress);
        // orderPurchase(context, paymentCode);
      } else {
        // Api 149b set payment methods for customer
        await checkoutController.getSelectedPaymentMethodClearPay(cartId, paymentCode, billingAddress);
        // orderPurchase(context, paymentCode);
      }
      String orderId =
          await sfApiPlaceOrder(isLoggedIn, cartId, paymentCode, checkoutController.getAdditionalDataforClearPay());
      orderSuccess(context, orderId);
    } catch (e) {
      setState(() {
        isError = true;
        errorMessage = e.toString();
      });
      Get.showSnackbar(GetSnackBar(
        title: "Order",
        message: e.toString(),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> orderPurchaseGoogleApplePay(String orderId) async {
    try {
      orderSuccess(context, orderId);
    } catch (e) {
      setState(() {
        isError = true;
        errorMessage = e.toString();
      });
      Get.showSnackbar(GetSnackBar(
        title: "Order",
        message: e.toString(),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> orderSuccess(BuildContext context, String orderId) async {
    try {
      if (orderId == "null") {
        orderId = '1';
        print("ORDER  ID == 1");
      }
      print("ORDER  == Step 1");
      await Provider.of<CartProvider>(context, listen: false).deleteCart();
      print("ORDER  == Step 2");

      Provider.of<CartProvider>(context, listen: false).initializeCart();
      print("ORDER  == Step 3");

      if (isLoggedIn) Provider.of<CartProvider>(context, listen: false).genrateCart();
      print("ORDER  == Step 4");

      if (!isLoggedIn) await sfRemoveAddressInformation();
      print("ORDER  == Step 5");

      if (!isLoggedIn) await MsProfileController.instance.resetControllers();
      print("ORDER  == Step 6");

      String orderno = await getOrderNo(orderId);
      print("ORDER  == Step 7");

      if (isLoggedIn) {
        Get.to(OrderConfirmationScreen(
          orderId: orderno,
        ));
      } else {
        Get.to(OrderConfirmationScreen(
          orderId: orderno,
        ));
      }
    } catch (e) {
      setState(() {
        isError = true;
        errorMessage = e.toString();
      });
      rethrow;
    }
  }

  Future<String> getOrderNo(String orderId) async {
    try {
      dynamic responseData = await getOrderDetailfromOrderId(isLoggedIn, orderId);
      print(responseData);
      String orderNo = "";
      if (responseData != null) {
        List data = responseData;
        if (data.length > 0) {
          dynamic details = data[0];
          orderNo = ((details["data"] ?? {})["order_increment_id"] ?? "").toString();
        }
      }
      print(orderNo);

      return orderNo;
    } catch (e) {
      setState(() {
        isError = true;
        errorMessage = e.toString();
      });
      Get.showSnackbar(GetSnackBar(
        title: "$e",
        message: e.toString(),
        duration: Duration(seconds: 2),
      ));
      return "";
    }
  }

  getandsetupaddress() async {
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

    billingAddress = {
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
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    isLoggedIn = Provider.of<CartProvider>(context).isLoggedIn;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.11,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Column(
          children: [
            Text(
              'sofiqe',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white, fontSize: 25, letterSpacing: 2.5),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Order Processing',
              style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: isError
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 150,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Text(
                    "Failed to Place the Order.",
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.red,
                          fontSize: height * 0.05,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.55,
                        ),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Color(0xFF000000),
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.55,
                        ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.symmetric(horizontal: 11),
                        height: height * 0.055,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 0, 0),
                          // border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          // color: active ? Color(0xFFF2CA8A) : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Go Back and Retry",
                            style: Theme.of(context).textTheme.headline2!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: height * 0.018,
                                  letterSpacing: 0.5,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                        Navigator.popUntil(context, (route) => route.isFirst);
                        // Navigator.pushNamedAndRemoveUntil(context, RouteNames.homeScreen, (route) => false);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.symmetric(horizontal: 11),
                        height: height * 0.055,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFEB7AC1),
                          // border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          // color: active ? Color(0xFFF2CA8A) : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Go Shopping",
                            style: Theme.of(context).textTheme.headline2!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: height * 0.028,
                                  letterSpacing: 0.5,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitPouringHourGlassRefined(
                    color: AppColors.primaryColor,
                    size: 180,
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Text(
                    "Please Wait, We are Making the Payment...",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Color(0xFF000000),
                          fontSize: height * 0.025,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.55,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
