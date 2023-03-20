import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/signup_screen.dart';
import 'package:sofiqe/widgets/animated_round_button.dart';
import 'package:sofiqe/widgets/capsule_button.dart';

import '../../screens/try_it_on_screen.dart';

class H1DE extends StatelessWidget {
  const H1DE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: H1D(),
          ),
          Expanded(
            child: H1E(),
          ),
        ],
      ),
    );
  }
}

class H1D extends StatelessWidget {
  const H1D({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AccountProvider account = Provider.of<AccountProvider>(context);
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.45,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/home_h1d_background.png'),
            ),
          ),
        ),
        Container(
          width: size.width,
          height: size.height * 0.45,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
          decoration: BoxDecoration(
            color: Color(0x4D000000),
          ),
          child: account.isLoggedIn
              ? Center(
                  child: Text(
                    'YOU ARE SOFIQE',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.white,
                          fontSize: size.height * 0.030,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        'Become Unlimited Sofiqe',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.white,
                              fontSize: size.height * 0.032,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.65,
                      child: Text(
                        'Get unlimited access to all the premium features by becoming Premium today',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.white,
                              fontSize: size.height * 0.014,
                              height: 2,
                              letterSpacing: 0.5,
                            ),
                      ),
                    ),
                    CapsuleButton(
                      onPress: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext c) {
                              return SignupScreen();
                            },
                          ),
                        );
                        // if (!account.goldPremium) {
                        //   await Get.toNamed(
                        //     RouteNames.premiumSubscriptionScreen,
                        //   );
                        // }
                      },
                      backgroundColor: Color(0xFFF2CA8A),
                      height: size.height * 0.06,
                      width: size.width * 0.7,
                      child: Text(
                        'SIGNUP FOR FREE',
                        // account.isLoggedIn
                        //     ? (account.goldPremium
                        //         ? 'ALREADY A GOLD'
                        //         : 'PREMIUM GOLD UPGRADE')
                        //     : 'SIGNUP FOR FREE',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.black,
                              fontSize: size.height * 0.016,
                              letterSpacing: 0.8,
                            ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class H1E extends StatelessWidget {
  const H1E({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.4,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              'TRY IT ON',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.012,
                    letterSpacing: 0.9,
                  ),
            ),
          ),
          Container(
            width: size.width * 0.5,
            child: Text(
              'Found a product in a Shop?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.024,
                    height: 1.4,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          TryOnButton(),
        ],
      ),
    );
  }
}

class TryOnButton extends StatefulWidget {
  const TryOnButton({Key? key}) : super(key: key);

  @override
  _TryOnButtonState createState() => _TryOnButtonState();
}

class _TryOnButtonState extends State<TryOnButton> {
  final PageProvider pp = Get.find();
  final TryItOnProvider tiop = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: AnimatedRoundButton(
        activeChild: Text(
          'TRY ON',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.black,
                fontSize: size.height * 0.015,
                letterSpacing: 0,
              ),
        ),
        inActiveChild: Text(
          'TRY ON',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Color(0xFFF2CA8A),
                fontSize: size.height * 0.015,
                letterSpacing: 0,
              ),
        ),
        activeBackgroundColor: Color(0xFFF2CA8A),
        inActiveBackgroundColor: Colors.transparent,
        activeBorderColor: Color(0xFFF2CA8A),
        inActiveBorderColor: Color(0x4DF2CA8A),
        width: size.height * 0.1,
        onTap: () {
          tiop.homeT1T2=true;
          Get.to(() => TryItOnScreen());
          // pp.goToPage(Pages.TRYITON);
        },
      ),
    );
  }
}
