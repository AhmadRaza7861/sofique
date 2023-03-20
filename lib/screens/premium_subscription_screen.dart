import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/screens/signup_screen.dart';
import 'package:sofiqe/widgets/capsule_button.dart';
import 'package:sofiqe/widgets/png_icon.dart';

class PremiumSubscriptionScreen extends StatelessWidget {
  const PremiumSubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PremiumSubscriptionBody(),
    );
  }
}

class PremiumSubscriptionBody extends StatelessWidget {
  const PremiumSubscriptionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.36,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    AssetImage('assets/images/premium_choice_background.png'),
              ),
            ),
            alignment: Alignment.topLeft,
            child: Container(
              width: size.width * 0.18,
              height: size.width * 0.18,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: BackButtonApp(
                flowFromMs: false,
                child: Transform.rotate(
                  angle: 3.1439,
                  child: PngIcon(
                    image: 'assets/icons/arrow-2-white.png',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ChoiceCarouselBody(),
          ),
        ],
      ),
    );
  }
}

class BackButtonApp extends StatelessWidget {
  final bool flowFromMs;
  final Widget child;
  const BackButtonApp({
    Key? key,
    required this.child,
    required this.flowFromMs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(size.width * 0.18)),
        onTap: () {
          flowFromMs ? profileController.screen.value = 0 : Get.back();
        },
        child: child,
      ),
    );
  }
}

class ChoiceCarouselBody extends StatelessWidget {
  const ChoiceCarouselBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Text(
              'BECOME SOFIQE PREMIUM',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.028,
                    letterSpacing: 0.6,
                  ),
            ),
          ),
          Container(
            width: size.width * 0.7,
            child: Text(
              'Get unlimited access to all the premium features by becoming Premium today',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFF837A7A),
                    fontSize: size.height * 0.014,
                  ),
            ),
          ),
          ChoiceCarousel(),
          SizedBox(height: size.height * 0.01),
        ],
      ),
    );
  }
}

class ChoiceCarousel extends StatelessWidget {
  const ChoiceCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    AccountProvider account = Provider.of<AccountProvider>(context);
    return Container(
      width: size.width,
      // color: Colors.red,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: size.width * 0.1),
            !account.isLoggedIn
                ? Container()
                : Choice(
                    backgroundColor: Colors.white,
                    title: 'PREMIUM',
                    body: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BulletPoint(
                            text: 'UNLIMITED SCAN TRY-ON IN SHOP',
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.008),
                          ),
                          BulletPoint(
                            text: 'EARLY ACCESS TO NEWEST PRODUCTS',
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.008),
                          ),
                          BulletPoint(
                            text: 'ACCESS TO LOOKS',
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.008),
                          ),
                          BulletPoint(
                            text: 'ACCESS TO SKINTONE SEARCH',
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.008),
                          ),
                        ],
                      ),
                    ),
                    buttonBody: Container(
                      child: Text(
                        'SIGNUP FOR FREE',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.white,
                              fontSize: size.height * 0.015,
                              letterSpacing: 0.6,
                            ),
                      ),
                    ),
                    buttonAction: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext c) {
                            return SignupScreen();
                          },
                        ),
                      );
                    },
                  ),
            //add premium subscription

            // Choice(
            //   backgroundColor: Color(0xFFF2CA8A),
            //   title: 'PREMIUM',
            //   body: Container(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Container(
            //           width: size.width * 0.45,
            //           child: Text(
            //             'EXCLUSIVE FREE SHIPPING ON ANY ORDER YOU MAKE',
            //             textAlign: TextAlign.center,
            //             style: Theme.of(context).textTheme.headline2!.copyWith(
            //                   color: Colors.white,
            //                   fontSize: size.width * 0.03,
            //                   letterSpacing: 0.5,
            //                 ),
            //           ),
            //         ),
            //         Column(
            //           children: [
            //             BulletPoint(
            //               text: 'UNLIMITED SCAN TRY-ON IN SHOP',
            //               padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
            //             ),
            //             BulletPoint(
            //               text: 'EARLY ACCESS TO NEWEST PRODUCTS',
            //               padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
            //             ),
            //             BulletPoint(
            //               text: 'ACCESS TO LOOKS',
            //               padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
            //             ),
            //             BulletPoint(
            //               text: 'ACCESS TO SKINTONE SEARCH',
            //               padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            //   buttonBody: Container(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           '€8 / MONTH',
            //           style: Theme.of(context).textTheme.headline2!.copyWith(
            //                 color: Colors.white,
            //                 fontSize: size.width * 0.03,
            //                 letterSpacing: 0.5,
            //               ),
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             PngIcon(
            //               image: 'assets/icons/apple-pay-white-logo.png',
            //               width: size.height * 0.014,
            //               height: size.height * 0.014,
            //               padding: EdgeInsets.zero,
            //             ),
            //             SizedBox(width: size.width * 0.01),
            //             Text(
            //               'PAY',
            //               style: Theme.of(context).textTheme.headline2!.copyWith(
            //                     color: Colors.white,
            //                     fontSize: size.width * 0.03,
            //                     letterSpacing: 0.5,
            //                   ),
            //             ),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            //   buttonAction: () async {
            //     if (!account.isLoggedIn) {
            //       await Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (BuildContext c) {
            //             return SignupScreen();
            //           },
            //         ),
            //       );
            //     }
            //     if (account.isLoggedIn) {
            //       await Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (BuildContext c) {
            //             return PaymentDetailsScreen(
            //               callback: (Map<String, String> card) async {
            //                 await account.subscribe(card);
            //                 if (account.goldPremium) {
            //                   Navigator.pop(context);
            //                 }
            //               },
            //             );
            //           },
            //         ),
            //       );
            //     }
            //   },
            // ),

            SizedBox(width: size.width * 0.1),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final Widget? icon;
  final String text;
  final EdgeInsets? padding;
  const BulletPoint({
    Key? key,
    required this.text,
    this.icon,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: padding != null ? padding : EdgeInsets.all(0),
      child: Row(
        children: [
          icon != null
              ? icon as Widget
              : Icon(
                  Icons.remove_rounded,
                  color: Colors.black,
                  size: size.width * 0.03,
                ),
          SizedBox(width: size.width * 0.01),
          Text(
            '$text',
            softWrap: true,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.width * 0.025,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0,
                ),
          ),
        ],
      ),
    );
  }
}

class Choice extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final Widget body;
  final Widget buttonBody;
  final void Function() buttonAction;
  const Choice({
    Key? key,
    required this.backgroundColor,
    required this.title,
    required this.body,
    required this.buttonBody,
    required this.buttonAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      height: size.height * 0.45,
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.03, horizontal: size.width * 0.08),
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.025),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              'sofiqe',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.grey[800],
                    fontSize: size.height * 0.012,
                  ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Container(
            child: Text(
              '$title',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: body,
          ),
          Container(
            child: CapsuleButton(
              height: size.height * 0.065,
              onTouchBackgroundColor: Colors.black87,
              onTouchBorderColor: Colors.transparent,
              onPress: buttonAction,
              child: buttonBody,
            ),
          ),
        ],
      ),
    );
  }
}
