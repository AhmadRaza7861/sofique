import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/checkoutController.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/screens/my_sofiqe.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/utils/states/function.dart';
import 'package:sofiqe/widgets/cart/cart_item_list.dart';
import 'package:sofiqe/widgets/cart/empty_bag.dart';
import 'package:sofiqe/widgets/cart/shopping_bag_bottom_tab.dart';

import '../provider/account_provider.dart';
import '../widgets/Dialogue/erro_dialogue.dart';
import '../widgets/png_icon.dart';

class ShoppingBagScreen extends StatefulWidget {
  const ShoppingBagScreen({Key? key}) : super(key: key);

  @override
  _ShoppingBagScreenState createState() => _ShoppingBagScreenState();
}

void getAllEvents() async {}

class _ShoppingBagScreenState extends State<ShoppingBagScreen> {
  late Map vipGuestPoint;
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
  final CheckoutController checkoutController = Get.put(CheckoutController());

  @override
  void initState() {
    super.initState();
  }

  deleteCart() async {
    try {
      context.loaderOverlay.show();

      await Provider.of<CartProvider>(context, listen: false)
          .deleteAllFromCart(context);
      context.loaderOverlay.hide();
    } catch (e) {
      print(e.toString());

      context.loaderOverlay.hide();
      Dialogue.showGetError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var cartItems = (Provider.of<CartProvider>(context).cart ?? []).length;
    var cart = Provider.of<CartProvider>(context).cart ?? [];
    var totalCartQty = Provider.of<CartProvider>(context).getTotalQty();
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5

    final args = ModalRoute.of(context)!.settings.arguments;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.08),
          child: AppBar(
            // toolbarHeight: size.height * 0.1,
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
            actions: [
              PopupMenuButton(
                padding: EdgeInsets.all(1.0),
                position: PopupMenuPosition.under,
                color: Colors.black,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      value: 1,
                      height: 20,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Color(0xFFF2CA8A),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('CLEAR CART',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    color: Color(0xFFF2CA8A),
                                    fontSize: 16,
                                    letterSpacing: 1.4,
                                  )),
                        ],
                      ),
                    ),
                  ];
                },
                onSelected: (int value) {
                  if (value == 1) {
                    Get.defaultDialog<bool>(
                        title: '',
                        titleStyle: const TextStyle(fontSize: 1),
                        radius: 10,
                        titlePadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.only(
                            top: 17, left: 16, right: 16, bottom: 5),
                        content: Column(
                          children: [
                            Text(
                              'sofiqe',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: size.height * 0.04,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              'Are You Sure?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "You want to clear your cart?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    // splashColor: kCustomLightGreenColor.withOpacity(.3),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Center(
                                        child: Text(
                                          'NO',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      print("Yes Clear the cart");
                                      Navigator.pop(context);
                                      deleteCart();
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    // splashColor: kCustomLightGreenColor.withOpacity(.3),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'YES',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ));
                  }
                },
              )
            ],
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
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.white,
                      fontSize: size.height * 0.035,
                      letterSpacing: 0.6),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(
                  'SHOPPING BAG (' + totalCartQty.toString() + ")",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
              ],
            ),
            // title:
            // Column(
            //   children: [
            //     Text(
            //       'sofiqe',
            //       textAlign: TextAlign.center,
            //       style: Theme.of(context).textTheme.headline1!.copyWith(
            //           color: Colors.white, fontSize: 25, letterSpacing: 2.5),
            //     ),
            //     SizedBox(
            //       height: 10,
            //     ),
            //     Text(
            //       'SHOPPING BAG (' + totalCartQty.toString() + ")",
            //       style: TextStyle(
            //           color: Colors.white, fontSize: 12, letterSpacing: 1),
            //     ),
            //   ],
            // ),
          ),
        ),
        body: cartItems != 0
            ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getContainerWidget(size),
                    Expanded(
                      child: CartItemList(),
                    ),
                    ShoppingBagBottomTab(),
                  ],
                ),
              )
            : cart.isNotEmpty
                ? Center(child: CircularProgressIndicator())
                : EmptyBagPage(
                    emptyBagButtonText: args != null
                        ? (args as Map)['empty_bag_button_text']
                        : null,
                  ),
      ),
    );
  }

  Container getContainerWidget(Size size) {
    String shippingText = "";
    String freeshipping =
        Provider.of<AccountProvider>(context, listen: false).freeShippingAmount;
    // added by kruti itemCount sometimes returns 0 even if there is items in cart so to solve issue
    // replaced itemcount with Provider.of<CartProvider>(context).cart!.length
    if (Provider.of<CartProvider>(context).cart!.length == 0) {
      shippingText = 'Free shipping above' +
          // ' €' +
          freeshipping.toString().toProperCurrency();

      return Container(
          color: HexColor("#EB7AC1"),
          height: 25,
          width: size.width,
          child: Center(
              child: Text(
            shippingText,
            style: TextStyle(fontSize: 12),
          )));
    } else {
      double minusAmount = 0.0;
      try {
        minusAmount = (double.parse(
                Provider.of<AccountProvider>(context, listen: false)
                    .freeShippingAmount) -
            double.parse(Provider.of<CartProvider>(context)
                .chargesList[0]['amount']
                .toString()));
      } catch (e) {
        minusAmount = 0.0;
      }

      if (minusAmount > 0) {
        shippingText = 'Add ' +
            minusAmount.toStringAsFixed(2).toProperCurrency() +
            " to your cart to get free shipping";

        return Container(
            color: HexColor("#EB7AC1"),
            height: 25,
            width: size.width,
            child: Center(
                child: Text(
              shippingText,
              style: TextStyle(fontSize: 12),
            )));
      } else {
        return Container();
      }
    }
  }
}
