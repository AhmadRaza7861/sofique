import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/checkoutController.dart';
import 'package:sofiqe/provider/cart_provider.dart';

import '../../../controller/controllers.dart';
import '../../../provider/account_provider.dart';
import '../../../screens/order_confirmation_screen.dart';

var size, height, width;

class GiftCardScreen extends StatefulWidget {

  final String orderId;

  GiftCardScreen({Key? key, required this.orderId}) : super(key: key);

  final CheckoutController checkoutController = Get.put(CheckoutController());

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  TextEditingController myName = TextEditingController();
  TextEditingController myEmail = TextEditingController();
  TextEditingController receiverName = TextEditingController();
  TextEditingController receiverEmail = TextEditingController();
  TextEditingController yourMsg = TextEditingController();

  @override
  void initState() {
    super.initState();
 
  }



  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        toolbarHeight: size.height * 0.11,
        centerTitle: true,
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
              'Giftcard',
              style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Used for removing back buttoon.
      ),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 8.5, horizontal: 29),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'The Gift Card needs some more information so your friend can use it',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Color(0xFF3D4554),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                ),
                SizedBox(height: 30),
                Stack(children: [
                  Image.asset("assets/images/giftcard-1.jpg",

                      // fit: BoxFit.cover,
                      height: 251,
                      width: 401),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 250,
                        width: 275,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 18, left: 52),
                                child: Text(
                                  ' Gift card information',
                                  style: Theme.of(context).textTheme.headline2!.copyWith(
                                        color: Color(0xFF3D4554),
                                        fontSize: height * 0.017,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.55,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.054,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    width: 100,
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xFFD3D3D3)),
                                    ),
                                    child: TextField(
                                      controller: myName,
                                      style: TextStyle(
                                        fontSize: height * 0.014,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(0.8),
                                        hintText: 'Your name',
                                        hintStyle: TextStyle(color: Color(0xFF88847D)),
                                      ),
                                    )),
                                SizedBox(width: 12.5),
                                Container(
                                    width: 100,
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xFFD3D3D3)),
                                    ),
                                    child: TextField(
                                      controller: myEmail,
                                      style: TextStyle(
                                        fontSize: height * 0.014,
                                      ),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          isDense: true,
                                          hintStyle: TextStyle(color: Color(0xFF88847D)),
                                          contentPadding: EdgeInsets.all(0.8),
                                          hintText: 'Your email'),
                                    )),
                                SizedBox(width: 14.5),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // SizedBox(width: 12.5),
                                Container(
                                    padding: EdgeInsets.all(2),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xFFD3D3D3)),
                                    ),
                                    child: TextField(
                                      controller: receiverName,
                                      style: TextStyle(
                                        fontSize: height * 0.014,
                                      ),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(0.8),
                                          hintStyle: TextStyle(color: Color(0xFF88847D)),
                                          hintText: 'Receiver name'),
                                    )),
                                SizedBox(width: 12.5),
                                Container(
                                    width: 100,
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xFFD3D3D3)),
                                    ),
                                    child: TextField(
                                      controller: receiverEmail,
                                      style: TextStyle(
                                        fontSize: height * 0.014,
                                      ),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          isDense: true,
                                          hintStyle: TextStyle(color: Color(0xFF88847D)),
                                          contentPadding: EdgeInsets.all(0.8),
                                          hintText: 'Receiver email'),
                                    )),
                                SizedBox(width: 14.5),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Container(
                                padding: EdgeInsets.all(2),
                                margin: EdgeInsets.symmetric(vertical: 1, horizontal: 13),
                                width: 215,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xFFD3D3D3)),
                                ),
                                child: TextField(
                                  controller: yourMsg,
                                  maxLines: 4,
                                  style: TextStyle(
                                    fontSize: height * 0.014,
                                  ),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(0.8),
                                      hintStyle: TextStyle(color: Color(0xFF88847D)),
                                      hintText: 'Your message to the giftcard receiver'),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
                SizedBox(
                  height: 110,
                ),
                InkWell(
                  onTap: () async {

                    if (myName.text.isEmpty ||
                        myEmail.text.isEmpty ||
                        receiverEmail.text.isEmpty ||
                        receiverName.text.isEmpty ||
                        yourMsg.text.isEmpty) {
                      Get.snackbar('', 'Please fill out all fields',
                          isDismissible: true,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black,
                          colorText: Color(0xFFFFFFFF));
                    } else {
                      Provider.of<CartProvider>(context, listen: false)
                          .fetchVipCoins(Provider.of<AccountProvider>(context,
                                  listen: false)
                              .customerId);
                      await checkoutController.generateGiftCard(
                          myName.text,
                          myEmail.text,
                          receiverName.text,
                          receiverEmail.text,
                          yourMsg.text,
                          widget.orderId,
                          Provider.of<AccountProvider>(context, listen: false)
                              .customerId
                              .toString(),
                          toProperCurrencyString());
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext _) {
                          return OrderConfirmationScreen(
                            orderId: widget.orderId,
                          );
                        }),
                      );
                    

                     } 
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 11),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2CA8A),
                      border: Border.all(color: Color(0xFF707070)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      // color: active ? Color(0xFFF2CA8A) : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "Add gift card information",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: height * 0.018,
                              letterSpacing: 0.55,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  String toProperCurrencyString() {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    return '${format.currencySymbol} $this';
  }
}
