import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/screens/login_screen.dart';
import 'package:sofiqe/screens/signup_screen.dart';
import 'package:sofiqe/widgets/capsule_button.dart';

class MakeOverLoginPrompt extends StatelessWidget {
  const MakeOverLoginPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          image: new DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.8), BlendMode.dstATop),
        image: new AssetImage("assets/images/portrait-of-woman-247206.png"),
        fit: BoxFit.fill,
      )),
      child: Column(
        children: [
          _TopBar(),
          Expanded(child: _Body()),
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: size.height * 0.01),
            child: Text(
              'sofiqe',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.04,
                  ),
            ),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         padding: EdgeInsets.all(size.height * 0.01),
          //         decoration: BoxDecoration(
          //           color: Colors.black,
          //           border: Border(
          //             top: BorderSide(
          //               color: Color(0xFF797373),
          //               width: 0.5,
          //             ),
          //             bottom: BorderSide(
          //               color: Color(0xFF797373),
          //               width: 0.5,
          //             ),
          //             right: BorderSide(
          //               color: Color(0xFF797373),
          //               width: 0.5,
          //             ),
          //           ),
          //         ),
          //         child: Center(
          //           child: Column(
          //             children: [
          //               PngIcon(image: 'assets/icons/check-mark-yellow.png'),
          //               Text(
          //                 'ANALYSIS',
          //                 style:
          //                     Theme.of(context).textTheme.headline2!.copyWith(
          //                           color: Color(0xFFF2CA8A),
          //                           fontSize: size.height * 0.012,
          //                         ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         padding: EdgeInsets.all(size.height * 0.01),
          //         decoration: BoxDecoration(
          //           color: Colors.black,
          //           border: Border(
          //             top: BorderSide(
          //               color: Color(0xFF797373),
          //               width: 0.5,
          //             ),
          //             bottom: BorderSide(
          //               color: Color(0xFF797373),
          //               width: 0.5,
          //             ),
          //           ),
          //         ),
          //         child: Center(
          //           child: Column(
          //             children: [
          //               PngIcon(image: 'assets/icons/check-mark-yellow.png'),
          //               Text(
          //                 'FACE SCAN',
          //                 style:
          //                     Theme.of(context).textTheme.headline2!.copyWith(
          //                           color: Color(0xFFF2CA8A),
          //                           fontSize: size.height * 0.012,
          //                         ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  _Body({Key? key}) : super(key: key);

  final MakeOverProvider mop = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: Color(0xFF797373),

      padding: EdgeInsets.symmetric(vertical: 0, horizontal: size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //  ProfilePicture(),
          SizedBox(height: size.height * 0.03),
          Text(
            'Thank you! Analysis done',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.025,
                  letterSpacing: 1.2,
                ),
          ),
          SizedBox(height: size.height * 0.03),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text:
                    ' To see how beautiful you will look, sign \nin or become free',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.016,
                      letterSpacing: 0.7,
                    ),
              ),
              TextSpan(
                  text: ' Sofiqe ',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        fontSize: size.height * 0.016,
                        letterSpacing: 0.7,
                      )),
              TextSpan(
                text: 'member.',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.016,
                      letterSpacing: 0.7,
                    ),
              ),
            ]),
          ),

          SizedBox(height: size.height * 0.04),
          CapsuleButton(
            backgroundColor: Color(0xFFF2CA8A),
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext _) {
                    return SignupScreen();
                  },
                ),
              );
              if (Provider.of<AccountProvider>(context, listen: false)
                  .isLoggedIn) {
                mop.sendResponse(
                    Provider.of<AccountProvider>(context, listen: false)
                        .customerId);
                Provider.of<AccountProvider>(context, listen: false)
                    .saveProfilePicture();
                mop.screen.value = 4;
              }
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
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext _) {
                    return LoginScreen();
                  },
                ),
              );
              AccountProvider acc =
                  Provider.of<AccountProvider>(context, listen: false);
              if (acc.isLoggedIn) {
                mop.sendResponse(
                    Provider.of<AccountProvider>(context, listen: false)
                        .customerId);
                Provider.of<AccountProvider>(context, listen: false)
                    .saveProfilePicture();
                mop.screen.value = 4;
              }
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
