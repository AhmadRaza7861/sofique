import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/freeshiping_provider.dart';
import 'package:sofiqe/widgets/catalog/checkout/checkout_page.dart';
// Custom packages
import 'package:sofiqe/widgets/png_icon.dart';

import '../controller/controllers.dart';
import '../provider/cart_provider.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key}) : super(key: key);

  final FreeShippingProvider freeShippingProvider = Get.put(FreeShippingProvider());
// GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    checkoutController.getCheckoutDetails(
        Provider.of<CartProvider>(context).isLoggedIn, Provider.of<CartProvider>(context).cartDetails!['id']);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF4F2F0),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.08),
        child: AppBar(
          // toolbarHeight: size.height * 0.11,
          leading: IconButton(
            icon: Transform.rotate(
              angle: 3.14159,
              child: PngIcon(
                image: 'assets/icons/arrow-2-white.png',
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'sofiqe',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white, fontSize: 25, letterSpacing: 2.5),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Text(
                'PURCHASE',
                style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
        ),
      ),
      body: CheckOutPage(),
    );
  }
}
