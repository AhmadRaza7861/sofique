import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final String orderId;

  OrderConfirmationScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  _OrderConfirmationScreenState createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  double calculatedVipPoint = 0;

  @override
  void initState() {
    super.initState();
  }

  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    if (Provider.of<CartProvider>(context).isLoggedIn) {
      calculatedVipPoint = (Provider.of<CartProvider>(context).lastSpent) * Provider.of<CartProvider>(context).vipRatio;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: SplashScreenPageColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.08),
          child: AppBar(
            // toolbarHeight: size.height * 0.11,
            centerTitle: true,
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
                  "THANK YOU",
                  style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
              ],
            ),
            backgroundColor: Colors.black,
            // shadowColor: SplashScreenPageColors.textColor,
            // elevation: 2,
            shape: Border(bottom: BorderSide(color: AppColors.secondaryColor, width: 0)),
            elevation: 4,
            automaticallyImplyLeading: false, // Used for removing back buttoon.
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.symmetric(vertical: 8.5, horizontal: 29),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/thankyou_top.png",
                          height: 86,
                          width: 177,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Image.asset(
                            "assets/images/thankyou_bottom.png",
                            height: 189,
                            width: 192,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Column(
                      children: [
                        Text(
                          'Thank you for your order.',
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                                color: Color(0xFF000000),
                                fontSize: height * 0.025,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.55,
                              ),
                        ),
                        SizedBox(
                          height: height * 0.008,
                        ),
                        Text(
                          'Order number ${widget.orderId}',
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                                color: Color(0xFF000000),
                                fontSize: height * 0.016,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.55,
                              ),
                        ),
                        SizedBox(
                          height: height * 0.002,
                        ),
                        Text(
                          'We have sent a confirmation\nto your email also',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                                color: Color(0xFF000000),
                                fontSize: height * 0.016,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.55,
                              ),
                        ),
                        SizedBox(height: height * 0.06),
                        Text(
                          'Get VIP points\nnext time',
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                                color: Color(0xFF000000),
                                fontSize: height * 0.035,
                                shadows: [
                                  Shadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(10, 20),
                                      blurRadius: 10),
                                ],
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.55,
                              ),
                        ),
                        SizedBox(height: height * 0.01),
                        Container(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            'We will add an additional $calculatedVipPoint VIP points to your order for free next time you purchase from us.',
                            style: Theme.of(context).textTheme.headline2!.copyWith(
                                  color: Color(0xFF000000),
                                  fontSize: height * 0.018,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(10, 20),
                                        blurRadius: 10),
                                  ],
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.55,
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
                        SizedBox(height: height * 0.08),
                      ],
                    )),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}