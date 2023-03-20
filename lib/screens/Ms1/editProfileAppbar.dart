import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/screens/premium_subscription_screen.dart';
import 'package:sofiqe/widgets/profile_picture.dart';

import '../../widgets/png_icon.dart';

class EditProfileAppbar extends StatelessWidget {
  // const ProfileInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AccountProvider ap = Provider.of<AccountProvider>(context);
    String? name = "Guest";
    if (ap.isLoggedIn && ap.user != null) {
      name = '${profileController.firstNameController.text} ${profileController.lastNameController.text}';
    }
    return Container(
      height: size.height * 0.11,
      color: Colors.black,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20,right : 10),
            child: BackButtonApp(
              flowFromMs: false,
              child: Transform.rotate(
                angle: 3.1439,
                child: PngIcon(
                  color: Colors.white,
                  image: 'assets/icons/arrow-2-white.png',
                ),
              ),
            ),
          ),
          ProfilePicture(),
          SizedBox(width: size.width*0.09),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'sofiqe',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                Text(
                  '$name',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Premium Member',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFFAFA0A0),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Provider.of<AccountProvider>(context, listen: false).logout();
          //   },
          //   child: Text(
          //     'TEST\nLOGOUT',
          //     style: Theme.of(context).textTheme.headline2!.copyWith(
          //           color: Color(0xFFF2CA8A),
          //           fontSize: size.height * 0.01,
          //         ),
          //   ),
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       // RoundButton(
          //       //   size: size.height * 0.07,
          //       //   backgroundColor: Color(0xFFF2CA8A),
          //       //   onPress: () async {
          //       //     await FlutterShare.share(
          //       //         title: 'a',
          //       //         text: ' ',
          //       //         linkUrl: 'https://play.google.com/store/apps/details?id=com.sofiqe.app',
          //       //         chooserTitle: ''
          //       //     );
          //       //   },
          //       //   child: Column(
          //       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       //     children: [
          //       //       PngIcon(
          //       //         image: 'assets/icons/share/send@3x.png',
          //       //         padding: EdgeInsets.only(left: size.width * 0.01),
          //       //         height: size.height * 0.036,
          //       //         width: size.height * 0.036,
          //       //       ),
          //       //       Text(
          //       //         'SHARE\nAPP',
          //       //         textAlign: TextAlign.center,
          //       //         style: Theme.of(context).textTheme.headline2!.copyWith(
          //       //           color: Colors.black,
          //       //           fontSize: size.height * 0.01,
          //       //         ),
          //       //       ),
          //       //     ],
          //       //   ),
          //       // ),
          //       // Container(
          //       //   height: size.height * 0.07,
          //       // ),
          //       // GestureDetector(
          //       //   onTap: () {},
          //       //   child: Text(
          //       //     'UPGRADE',
          //       //     style: Theme.of(context).textTheme.headline2!.copyWith(
          //       //           color: Color(0xFFF2CA8A),
          //       //           fontSize: size.height * 0.01,
          //       //         ),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}