import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/utils/states/function.dart';

import '../../../controller/controllers.dart';
import '../../../provider/cart_provider.dart';

class VipPointEarn extends StatefulWidget {
  const VipPointEarn({Key? key}) : super(key: key);

  @override
  State<VipPointEarn> createState() => _VipPointEarnState();
}

class _VipPointEarnState extends State<VipPointEarn> {
  final vipPointAmount = TextEditingController();
  double _bodyHeight = 0.0;
  var size, height;
  bool chekBox = false;
  double spendAmount = 0;
  int totalVipAmount = 0;
  int maximumVipSpend = 0;
  int appliedVipPoints = 0;
  int cartId = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    totalVipAmount = Provider.of<CartProvider>(context).customerPoints;

    if (totalVipAmount < 0) {
      totalVipAmount = 0;
    }
    maximumVipSpend = Provider.of<CartProvider>(context).customermaxspendpoints;
    if (maximumVipSpend < 0) {
      maximumVipSpend = 0;
    }
    cartId = Provider.of<CartProvider>(context).cartDetails!['id'];
    Map<String, dynamic> _chargesList =
        Provider.of<CartProvider>(context).chargesList.first;
    var calculatedVipPoint = (Provider.of<CartProvider>(context).lastSpent) *
        Provider.of<CartProvider>(context).vipRatio;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Row(
            children: [
              Text(
                'You earn',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Color(0xFF000000),
                      fontSize: height * 0.014,
                      fontFamily: "Arial",
                      letterSpacing: 0.4,
                    ),
              ),
              Spacer(),
              Image.asset(
                "assets/images/goldencoin.png",
                width: height * 0.011,
                height: height * 0.013,
              ),
              SizedBox(
                width: height * 0.005,
              ),
              Text(
                "${calculatedVipPoint.toPrecision(2)} VIP points",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Color(0xFF000000),
                      fontSize: height * 0.014,
                      fontFamily: "Arial",
                      letterSpacing: 0.4,
                    ),
              ),
              (appliedVipPoints > 0) ? Spacer() : Container(),
              (appliedVipPoints > 0) ? Spacer() : Container(),
              (appliedVipPoints > 0) ? Spacer() : Container(),
              (appliedVipPoints > 0)
                  ? Text(
                      "${spendAmount.toPrecision(2).toString().toProperCurrency()}",
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Color(0xFF000000),
                            fontSize: height * 0.013,
                            fontFamily: "Arial",
                            letterSpacing: 0.4,
                          ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: height * 0.004,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (totalVipAmount <= 0) {
                    Get.snackbar('', "You don't have VIP point.",
                        isDismissible: true,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.black,
                        colorText: Color(0xFFFFFFFF));
                  } else {
                    setState(() {
                      if (_bodyHeight == 0) {
                        _bodyHeight = 135.0;
                      } else {
                        _bodyHeight = 0.0;
                      }
                    });
                  }
                },
                child: Text(
                  "You spend",
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
                  if (totalVipAmount <= 0) {
                    Get.snackbar('', "You don't have VIP point.",
                        isDismissible: true,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.black,
                        colorText: Color(0xFFFFFFFF));
                  } else {
                    setState(() {
                      if (_bodyHeight == 0) {
                        _bodyHeight = 135.0;
                      } else {
                        _bodyHeight = 0.0;
                      }
                    });
                  }
                },
                child: _bodyHeight == 0
                    ? Icon(
                        Icons.keyboard_arrow_right,
                        size: height * 0.02,
                      )
                    : Icon(Icons.keyboard_arrow_down, size: 15),
              ),
              Spacer(),
              Image.asset(
                "assets/images/goldencoin.png",
                width: height * 0.011,
                height: height * 0.013,
              ),
              SizedBox(
                width: height * 0.005,
              ),
              Text(
                "$appliedVipPoints VIP points",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Color(0xFF000000),
                      fontSize: height * 0.014,
                      fontFamily: "Arial",
                      letterSpacing: 0.4,
                    ),
              ),
              (appliedVipPoints > 0) ? Spacer() : Container(),
              (appliedVipPoints > 0) ? Spacer() : Container(),
              (appliedVipPoints > 0) ? Spacer() : Container(),
              (appliedVipPoints > 0) ? Spacer() : Container(),
            ],
          ),
          AnimatedContainer(
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        "You have ",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Color(0xFF000000),
                              fontSize: height * 0.012,
                              fontFamily: "Arial",
                              letterSpacing: 0.4,
                            ),
                      )),
                      Image.asset("assets/images/goldencoin.png",
                          width: height * 0.011, height: height * 0.013),
                      SizedBox(
                        width: 4.5,
                      ),
                      Center(
                          child: Text(
                        "$totalVipAmount",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Color(0xFF000000),
                              fontSize: height * 0.012,
                              fontFamily: "Arial",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4,
                            ),
                      )),
                      Center(
                          child: Text(
                        " available",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.black,
                              fontSize: 11,
                              letterSpacing: 0.5,
                            ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFD3D3D3)),
                      ),
                      child: TextField(
                        controller: vipPointAmount,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: height * 0.014,
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                            hintText: 'Enter amount of points to spend'),
                      )),
                  SizedBox(
                    height: 8.5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              print("CARTID=$cartId");

                              bool isAppliedVipPoints = false;
                              if (vipPointAmount.text.isEmpty) {
                                Get.snackbar('', 'Value can not empty.',
                                    isDismissible: true,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.black,
                                    colorText: Color(0xFFFFFFFF));
                              } else if (int.parse(vipPointAmount.text) >
                                  totalVipAmount) {
                                Get.snackbar('',
                                    'VIP Points are too big, please revise.',
                                    isDismissible: true,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.black,
                                    colorText: Color(0xFFFFFFFF));
                              } else if (vipPointAmount.text.isNotEmpty &&
                                  chekBox == true) {
                                setState(() async {
                                  _bodyHeight = 0.0;
                                  isAppliedVipPoints = await checkoutController
                                      .applyRewardPoints(
                                          cartId, maximumVipSpend);
                                  if (isAppliedVipPoints) {
                                    appliedVipPoints =
                                        int.parse(maximumVipSpend.toString());
                                    spendAmount =
                                        double.parse(_chargesList['display']) /
                                            appliedVipPoints;
                                  }
                                });
                              } else {
                                isAppliedVipPoints =
                                    await checkoutController.applyRewardPoints(
                                        cartId, int.parse(vipPointAmount.text));
                                if (isAppliedVipPoints) {
                                  appliedVipPoints =
                                      int.parse(vipPointAmount.text);
                                  spendAmount =
                                      double.parse(_chargesList['display']) /
                                          appliedVipPoints;
                                }
                                setState(() {
                                  _bodyHeight = 0.0;
                                });
                              }
                              totalVipAmount =
                                  (totalVipAmount - appliedVipPoints);
                            },
                            child: AnimatedContainer(
                              padding: EdgeInsets.all(height * 0.0024),
                              duration: Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFF2CA8A)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: Color(0xFFF2CA8A),
                              ),
                              child: Center(
                                child: Text(
                                  "APPLY POINTS",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: height * 0.013,
                                          letterSpacing: 0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _bodyHeight = 0.0;
                              });
                            },
                            child: AnimatedContainer(
                              padding: EdgeInsets.all(height * 0.0024),
                              duration: Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFF2CA8A)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: Color(0xFFF2CA8A),
                              ),
                              child: Center(
                                child: Text(
                                  "CANCEL POINTS",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: height * 0.013,
                                        letterSpacing: 0.5,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          tristate: true,
                          value: chekBox,
                          activeColor: Colors.black,
                          onChanged: (value) {
                            setState(() {
                              chekBox = !chekBox;
                            });
                          },
                        ),
                        Text(
                          "Use maximum",
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Colors.black,
                                    fontSize: height * 0.013,
                                    letterSpacing: 0.5,
                                  ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Image.asset(
                          "assets/images/goldencoin.png",
                          width: height * 0.011,
                          height: height * 0.013,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "$maximumVipSpend VIP points",
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.013,
                                    letterSpacing: 0.5,
                                  ),
                        ),
                      ],
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
