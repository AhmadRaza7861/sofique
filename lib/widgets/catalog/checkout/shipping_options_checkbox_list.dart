import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// 3rd party packages
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/account_provider.dart';

// Provider
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/screens/delivery_details_screen.dart';
import 'package:sofiqe/utils/states/function.dart';

// Custom packages
import 'package:sofiqe/widgets/custom_radio_button.dart';

import '../../../controller/msProfileController.dart';

class ShippingOptionsCheckBoxList extends StatefulWidget {
  const ShippingOptionsCheckBoxList({Key? key}) : super(key: key);

  @override
  ShippingOptionsCheckBoxListState createState() =>
      ShippingOptionsCheckBoxListState();
}

class ShippingOptionsCheckBoxListState
    extends State<ShippingOptionsCheckBoxList> {
  double _bodyHeight = 0.0;
  double shipHeight = 200.0;
  var size, height;
  int currentOption = 1;
  double? sum;
  var address = "Please add your address";

  List<Map<String, dynamic>> shippingOptions = [];

  bool isFreeSheeping = false;
  String shippingText = "";
  String freeshipping = "";
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName);

  bool isLoggedIn = false;

  Future<void> getAddress(BuildContext context) async {
    // if (isLoggedIn) {
    var tempAddress = MsProfileController.instance.shippingAddress.value;
    if (tempAddress.isNotEmpty) {
      address = tempAddress;
    } else {
      address = "Please add your address";
    }
    /*} else {
      address = "Please add your address";
    }*/
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn = Provider.of<CartProvider>(context).isLoggedIn;
    if (isLoggedIn) {
      getAddress(context);
    } else {
      address = "Please add your address";
    }
    freeshipping =
        Provider.of<AccountProvider>(context, listen: false).freeShippingAmount;
    if (Provider.of<CartProvider>(context).cart!.length == 0) {
      shippingText = 'Free shipping above '

          // +'       ${format.currencySymbol}'

          +
          freeshipping.toString().toProperCurrency();
    } else {
      double minusAmount = (double.parse(
              Provider.of<AccountProvider>(context, listen: false)
                  .freeShippingAmount) -
          double.parse(Provider.of<CartProvider>(context)
              .chargesList[0]['amount']
              .toString()));
      if (minusAmount > 0) {

        shippingText = 'Add ' +

            minusAmount.toString().toProperCurrency() +
            " to your cart to get free shipping";
      }
    }

    isFreeSheeping = freeShippingProvider.status;
    if (shippingText.isEmpty) {
      shippingText = "";
    }

    shippingOptions.clear();
    shippingOptions.addAll([
      {
        'id': 0,
        'type': 'Free Shipping',
        'estimated-time': '$shippingText',
        'price': 0.0,
      },
      {
        'id': 1,
        'type': 'Standard Delivery',
        'estimated-time': 'Delivery estimated Wed 11 March',
        'price': 3.95,
      },
      {
        'id': 2,
        'type': 'Express Delivery',
        'estimated-time': 'Delivery estimated before Mon 9 March',
        'price': 6.95,
      }
    ]);

    sum = shippingOptions[currentOption]['price'];
    size = MediaQuery.of(context).size;
    height = size.height;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: height * 0.005,
              bottom: height * 0.005,
              left: height * 0.002,
              right: height * 0.002),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    if (_bodyHeight == 0) {
                      shipHeight = height * 0.2;
                      _bodyHeight = shipHeight;
                    } else {
                      _bodyHeight = 0.0;
                    }
                  });
                },
                child: Text(
                  "DELIVERY",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Color(0xFF000000),
                        fontSize: height * 0.014,
                        fontFamily: "Arial",
                        letterSpacing: 0.4,
                      ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (_bodyHeight == 0) {
                      shipHeight = height * 0.2;
                      _bodyHeight = shipHeight;
                    } else {
                      _bodyHeight = 0.0;
                    }
                  });
                },
                child: _bodyHeight == 0
                    ? Icon(
                        Icons.keyboard_arrow_right,
                        size: height * 0.022,
                      )
                    : Icon(Icons.keyboard_arrow_down, size: height * 0.022),
              ),
              Spacer(),
              Text(
                "${sum.toString().toProperCurrency()}",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Color(0xFF000000),
                      fontSize: height * 0.014,
                      fontFamily: "Arial",
                      letterSpacing: 0.4,
                    ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          padding: EdgeInsets.zero,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                        Text(
                          "Address:",
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Colors.black,
                                    fontSize: height * 0.012,
                                    letterSpacing: 0.55,
                                  ),
                        ),
                        Spacer(),
                        InkWell(
                            onTap: () async {
                              try {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext _) {
                                      return DeliveryDetailsScreen(
                                        "CHANGE",
                                        callback: (Map<String, String>
                                            cardDetails) async {
                                          try {
                                            Navigator.pop(context);
                                          } catch (e) {
                                            Get.showSnackbar(
                                              GetSnackBar(
                                                message:
                                                    'An error occurred while saving the payment details',
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                );
                                getAddress(context);
                              } catch (e) {
                                print(
                                    'Error setting shipping address _NextButton: $e');
                              }
                            },
                            child: Text(
                              "CHANGE",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: height * .012),
                            ))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Obx(
                            () => Text(
                              MsProfileController
                                  .instance.shippingAddress.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    color: Colors.black,
                                    fontSize: height * .012,
                                    letterSpacing: 0.55,
                                  ),
                            ),
                          )),
                    ),
                  ],
                ),
                ...shippingOptions
                    .map<Container>((Map<String, dynamic> option) {
                  return Container(
                    padding: EdgeInsets.all(height * 0.009),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomRadioButton<int>(
                          size: height * 0.023,
                          value: option['id'],
                          selectedChild: Container(
                            color: Colors.black,
                          ),
                          groupValue: currentOption,
                          onChanged: (int value) {
                            if (!isFreeSheeping) {
                              if (value == 0) {
                              } else {
                                currentOption = value;
                              }
                            } else {
                              currentOption = value;
                            }
                            print("CUNREEEE + $currentOption");
                            sum = shippingOptions[currentOption]['price'];
                            Provider.of<CartProvider>(context, listen: false)
                                .setDeliverCharges(option['price']);
                            setState(() {});
                          },
                        ),
                        SizedBox(width: 13.5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (!isFreeSheeping && option['id'] == 0)
                                  ? Text(
                                      '${option['type']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            color: Color(0xFF707070),
                                            fontSize: 13,
                                            letterSpacing: 0.55,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    )
                                  : Text(
                                      '${option['type']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            color: Colors.black,
                                            fontSize: 13,
                                            letterSpacing: 0.55,
                                            fontWeight: (option['id'] ==
                                                    shippingOptions[
                                                        currentOption]['id'])
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                    ),
                              (!isFreeSheeping && option['id'] == 0)
                                  ? Text(
                                      '${option['estimated-time']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            color: Color(0xFFEB7AC1),
                                            fontSize: 10,
                                            letterSpacing: 0.4,
                                          ),
                                    )
                                  : Text(
                                      '${option['estimated-time']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            color: Colors.black,
                                            fontSize: 10,
                                            letterSpacing: 0.4,
                                          ),
                                    ),
                            ],
                          ),
                        ),
                        (!isFreeSheeping && option['id'] == 0)
                            ? Text(
                                '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      color: Color(0xFF000000),
                                      fontSize: height * 0.015,
                                      fontFamily: "Arial",
                                      fontWeight:
                                          currentOption.isEqual(currentOption)
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      letterSpacing: 0.4,
                                    ),
                              )
                            : Text(
                                '${option['price'].toString().toProperCurrency()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      color: Color(0xFF000000),
                                      fontSize: height * 0.015,
                                      fontFamily: "Arial",
                                      fontWeight:
                                          currentOption.isEqual(currentOption)
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      letterSpacing: 0.4,
                                    ),
                              ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 500),
          height: _bodyHeight,
        ),
      ],
    );
  }
}
