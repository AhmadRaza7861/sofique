import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/screens/login_screen.dart';
import 'package:sofiqe/screens/premium_subscription_screen.dart';
import 'package:sofiqe/screens/signup_screen.dart';
import 'package:sofiqe/widgets/capsule_button.dart';

import '../png_icon.dart';

final PageProvider pp = Get.find();

class MakeOverCustomWidget extends StatelessWidget {
  const MakeOverCustomWidget({
    Key? key,
  }) : super(key: key);
  void initState() {
    //  ControlStatusBar.enableStatusBar();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xFF797373),
      decoration: new BoxDecoration(
          image: new DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.8), BlendMode.dstATop),
        image: new AssetImage("assets/images/portrait-of-woman-247206.png"),
        fit: BoxFit.fill,
      )),
      //  color: Colors.black,
      child: Column(
        children: [
          _TopBar(),
          Expanded(child: _Body()),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  _Body({
    Key? key,
  }) : super(key: key);

  final MakeOverProvider mop = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // ProfilePicture(),
          SizedBox(height: size.height * 0.03),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'We are ',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.025,
                      letterSpacing: 1.2,
                    ),
              ),
              TextSpan(
                  text: 'sofiqe. ',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.025,
                        letterSpacing: 1.2,
                      )),
            ]),
          ),

          SizedBox(height: size.height * 0.03),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text:
                    ' To see your shopping bag,\nplease login or register',
                   // ' To see how beautiful you will look, sign \nin or become free',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.016,
                      letterSpacing: 0.7,
                    ),
              ),
              // TextSpan(
              //     text: ' Sofiqe ',
              //     style: Theme.of(context).textTheme.headline2!.copyWith(
              //           color: Colors.black,
              //           fontSize: size.height * 0.016,
              //           letterSpacing: 0.7,
              //         )),
              // TextSpan(
              //   text: 'member.',
              //   style: Theme.of(context).textTheme.headline2!.copyWith(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //         fontSize: size.height * 0.016,
              //         letterSpacing: 0.7,
              //       ),
              // ),
            ]),
          ),

          SizedBox(height: size.height * 0.04),
          CapsuleButton(
            backgroundColor: Color(0xFFF2CA8A),
            onPress: () async {
              profileController.screen.value = 0;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext _) {
                    return SignupScreen();
                  },
                ),
              );
              // if (Provider.of<AccountProvider>(context, listen: false)
              //     .isLoggedIn) {
              //   mop.sendResponse(
              //       Provider.of<AccountProvider>(context, listen: false)
              //           .customerId);
              //   Provider.of<AccountProvider>(context, listen: false)
              //       .saveProfilePicture();
              //   mop.screen.value = 4;
              // }
            },
            child: Text(
              'JOIN SOFIQE FOR FREE',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.017,
                  ),
            ),
          ),
          SizedBox(height: size.height * 0.12),
          CapsuleButton(
            backgroundColor: Colors.black,
            borderColor: Color(0xFF393636),
            onPress: () async {
              profileController.screen.value = 0;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext _) {
                    return LoginScreen();
                  },
                ),
              );
              // AccountProvider acc =
              //     Provider.of<AccountProvider>(context, listen: false);
              // if (acc.isLoggedIn) {
              //   mop.sendResponse(
              //       Provider.of<AccountProvider>(context, listen: false)
              //           .customerId);
              //   Provider.of<AccountProvider>(context, listen: false)
              //       .saveProfilePicture();
              //   mop.screen.value = 4;
              // }
            },
            child: Text(
              'ALREADY A SOFIQE? SIGN IN',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.017,
                  ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }
}

class MakeOvarSingle extends StatelessWidget {
  final String title;
  final String description;

  const MakeOvarSingle({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xFF797373),
      decoration: new BoxDecoration(
          image: new DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.8), BlendMode.dstATop),
        image: new AssetImage("assets/images/portrait-of-woman-247206.png"),
        fit: BoxFit.fill,
      )),
      //  color: Colors.black,
      child: Column(
        children: [
          _TopBar(),
          Expanded(child: Body(title: title, description: description)),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: size.width * 0.18,
            height: size.width * 0.18,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: BackButtonApp(
              flowFromMs: true,
              child: Transform.rotate(
                angle: 3.1439,
                child: PngIcon(
                  color: Colors.black,
                  image: 'assets/icons/arrow-2-white.png',
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    bottom: size.height * 0.01, left: size.width * 0.2),
                child: Text(
                  'sofiqe',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.04,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  final String title;
  final String description;
  final PageProvider pp = Get.find();
  Body({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final MakeOverProvider mop = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ProfilePicture(),
          SizedBox(height: size.height * 0.3),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.025,
                  letterSpacing: 1.2,
                ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            width: size.width * 0.66,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.016,
                    letterSpacing: 0.7,
                  ),
            ),
          ),
          SizedBox(height: size.height * 0.04),
          CapsuleButton(
            backgroundColor: Color(0xFFF2CA8A),
            onPress: () async {
              pp.goToPage(Pages.SHOP);
              profileController.screen.value = 0;
              // await Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (BuildContext _) {
              //         return ScaffoldTemplate(child: MakeOverScreen(),index: 3,);
              //       },
              //     ));
            },
            child: Text(
              'Go to makeover'.toUpperCase(),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.017,
                  ),
            ),
          ),
          SizedBox(height: size.height * 0.12),
        ],
      ),
    );
  }
}
