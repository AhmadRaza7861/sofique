import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/checkoutController.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/api/shipping_address_api.dart';
import 'package:sofiqe/utils/states/user_account_data.dart';

import '../screens/order_confirmation_screen.dart';
import '../utils/states/local_storage.dart';
import '../widgets/Dialogue/erro_dialogue.dart';
import '../widgets/catalog/checkout/widget_loader_with_text.dart';
import 'msProfileController.dart';

class OrderProcessingController extends GetxController {
  static OrderProcessingController get to => Get.find();

  static OrderProcessingController instance = Get.find();
  int cartId = 0;
  String cartIdG = "";
  var billingAddress;
  late BuildContext context;
  var checkoutController;

  var isLoggedIn;
  Future<void> setLoginStatusandContext(BuildContext context1) async {
    isLoggedIn = Provider.of<CartProvider>(context1, listen: false).isLoggedIn;
    checkoutController = CheckoutController.instance;
    context = context1;
  }

  Future<void> processOrder({dynamic cardDetails, required String payment_method}) async {
    try {
      await getandsetupaddress();
      cartIdG = (await sfQueryForSharedPrefData(fieldName: 'cart-token', type: PreferencesDataType.STRING)).values.last;

      if (payment_method == "stripe-card") {
        if (!isLoggedIn) {
          print("Overlay 1");
          print(context.loaderOverlay.visible);
          await checkoutController.setPaymentInformationStripeForGuest(
              cartIdG, cardDetails["id"].toString(), billingAddress);
          print("Overlay 2");
          print(context.loaderOverlay.visible);
          context.loaderOverlay.hide();
          context.loaderOverlay.show(
              widget: LoaderWithText(
            msg: "Placing Order...",
          ));
          orderPurchaseStripePay(context, cardDetails["id"].toString());
        } else {
          print(jsonEncode({
            "email": "${billingAddress['email']}",
            "method": {
              // "paymentMethod": {
              "method": "stripe_payments",
              "additional_data": {"cc_stripejs_token": cardDetails["id"].toString()}
            },
            "billing_address": billingAddress
          }));
          print(cartId);

          await checkoutController.getSelectedPaymentMethodStripe(cartId, cardDetails["id"].toString(), billingAddress);
          orderPurchaseStripePay(context, cardDetails["id"].toString());
        }
      } else if (payment_method == "clearPay") {
        orderPurchaseClearPayPay();
      } else if (payment_method == "gpay") {
        if (!isLoggedIn) {
          await checkoutController.setPaymentInformationStripeForGuest(
              cartIdG, cardDetails["paymentmthodId"].toString(), billingAddress);
        } else {
          await checkoutController.getSelectedPaymentMethodStripe(
              cartId, cardDetails["token"].toString(), billingAddress);
        }
        String orderId = await sfApiPlaceOrder(
            isLoggedIn, cartId, "stripe_payments", {"cc_stripejs_token": cardDetails["paymentmthodId"]});
        orderPurchaseGoogleApplePay(orderId);
      }
    } catch (e) {
      print("This is outer error");
      print(e);
      Dialogue.showGetError(e.toString());
      throw e;
    }
  }

  Future<void> orderSuccess(String orderId) async {
    try {
      context.loaderOverlay.show(
          widget: LoaderWithText(
        msg: "Placing Order...",
      ));
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
      context.loaderOverlay.hide();
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
      context.loaderOverlay.hide();

      Dialogue.showGetError(e.toString());
      throw e;
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
      throw e;
    }
  }

  Future<void> orderPurchaseGoogleApplePay(String orderId) async {
    try {
      orderSuccess(orderId);
    } catch (e) {
      Dialogue.showGetError(e.toString());
      throw e;
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
      orderSuccess(orderId);
    } catch (e) {
      Dialogue.showGetError(e.toString());
      throw e;
    }
  }

  Future<void> orderPurchaseStripePay(BuildContext context, String stripeToken) async {
    context.loaderOverlay.show(
        widget: LoaderWithText(
      msg: "Placing Order...",
    ));
    try {
      print("Call Purchase on Card pay");
      String orderId =
          await sfApiPlaceOrder(isLoggedIn, cartId, "stripe_payments", {"cc_stripejs_token": "$stripeToken"});
      context.loaderOverlay.hide();
      print("ORDER ID =$orderId");
      orderSuccess(orderId);
    } catch (e) {
      print("This is Inner error");
      print(e);
      context.loaderOverlay.hide();

      Dialogue.showGetError(e.toString());
      throw e;
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
}
