import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/utils/states/function.dart';

import '../../../controller/controllers.dart';

class GiftCardEarning extends StatefulWidget {
  GiftCardEarning({Key? key}) : super(key: key);

  @override
  State<GiftCardEarning> createState() => _GiftCardEarningState();
}

class _GiftCardEarningState extends State<GiftCardEarning> {
  final giftCrdNumber = TextEditingController();
  final giftAmount = TextEditingController();
  var height, size;
  int giftCardAmount = 0;

  double _bodyHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    giftCardAmount = checkoutController.giftCardAmount;
    size = MediaQuery.of(context).size;
    height = size.height;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.004,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    setState(() {
                      if (_bodyHeight == 0) {
                        _bodyHeight = 80.0;
                      } else {
                        _bodyHeight = 0.0;
                      }
                    });
                  },
                  child: (giftCrdNumber.text.isEmpty ||
                          giftCrdNumber.text.length < 13 ||
                          giftAmount.text.isEmpty)
                      ? Text(
                          'Giftcard or promo code',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Color(0xFF000000),
                                    fontSize: height * 0.014,
                                    fontFamily: "Arial",
                                    letterSpacing: 0.4,
                                  ),
                        )
                      : Text(
                          'Giftcard or promo code ${giftCrdNumber.text.replaceRange(0, 9, "*****")}',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Color(0xFF000000),
                                    fontSize: height * 0.014,
                                    fontFamily: "Arial",
                                    letterSpacing: 0.4,
                                  ),
                        )),
              InkWell(
                onTap: () {
                  setState(() {
                    if (_bodyHeight == 0) {
                      _bodyHeight = 80.0;
                    } else {
                      _bodyHeight = 0.0;
                    }
                  });
                },
                child: _bodyHeight == 0
                    ? Icon(
                        Icons.keyboard_arrow_right,
                        size: height * 0.02,
                      )
                    : Icon(Icons.keyboard_arrow_down, size: height * 0.02),
              ),
              Spacer(),
              Text(
                "${giftCardAmount.toString().toProperCurrency()}",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Color(0xFF000000),
                      fontSize: height * 0.014,
                      fontFamily: "Arial",
                      letterSpacing: 0.4,
                    ),
              )
            ],
          ),
          AnimatedContainer(
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF88847D)),
                              ),
                              child: TextField(
                                controller: giftCrdNumber,
                                style: TextStyle(
                                  fontSize: height * 0.013,
                                ),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: 'Promo or gift card number'),
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF88847D)),
                              ),
                              child: TextField(
                                controller: giftAmount,
                                style: TextStyle(
                                  fontSize: height * 0.013,
                                ),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: 'Amount'),
                              )),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (giftCrdNumber.text.isEmpty ||
                          giftCrdNumber.text.length < 13 ||
                          giftAmount.text.isEmpty) {
                        Get.snackbar('', 'Value can not empty.',
                            isDismissible: true,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.black,
                            colorText: Color(0xFFFFFFFF));
                      } else {
                        giftCardAmount = await checkoutController
                            .sfAPIApplyGiftCard(giftCrdNumber.text);
                        double remaining =
                            giftCardAmount - double.parse(giftAmount.text);
                        if (remaining < 0) {
                          // Giftcard Amount is too big, please revise.
                          Get.snackbar(
                              '', 'Giftcard Amount is too big, please revise.',
                              isDismissible: true,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black,
                              colorText: Color(0xFFFFFFFF));
                        } else if (remaining > 0) {
                          Get.snackbar('',
                              'You will have "${remaining.toString().toProperCurrency()}',
                              isDismissible: true,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black,
                              colorText: Color(0xFFFFFFFF));
                        } else if (remaining == 0) {
                          // This giftcard is now consumed..
                          Get.snackbar('', 'This giftcard is now consumed',
                              isDismissible: true,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black,
                              colorText: Color(0xFFFFFFFF));
                        }

                        setState(() {
                          _bodyHeight = 0.0;
                        });
                      }
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: height * 0.030,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFF2CA8A)),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0xFFF2CA8A),
                      ),
                      child: Center(
                        child: Text(
                          "ADD/CHANGE",
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.013,
                                    letterSpacing: 0.5,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
            height: _bodyHeight,
          ),
        ],
      ),
    );
  }
}
