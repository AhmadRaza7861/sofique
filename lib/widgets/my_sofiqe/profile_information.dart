import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/screens/Ms1/sofiqueEditProfile.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/profile_picture.dart';

import '../../provider/page_provider.dart';
import '../makeover/make_over_login_custom_widget.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AccountProvider ap = Provider.of<AccountProvider>(context);
    String? name = "Guest";
    if (ap.isLoggedIn && ap.user != null) {
      name = '${ap.user!.firstName} ${ap.user!.lastName}';
    }
    String membership = "Not Signed Up Yet";

    if (ap.isLoggedIn) {
      membership = 'Premium Member';
    }

    return  Container(
      //padding: EdgeInsets.only(left: 20),
      height: size.height * 0.11,
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      if (profileController.screen.value == 3) {
                        profileController.screen.value = 0;
                      } else {
                        pp.goToPage(Pages.HOME);
                      }
                    },
                    child: SvgPicture.asset(
                      'assets/svg/arrow.svg',
                      width: 12,
                      height: 12,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    !ap.isLoggedIn
                        ? profileController.screen.value = 1
                        : Get.to(() => SofiqueEditProfile());
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      ProfilePicture(),
                      Container(
                        height: 22,
                        width: 22,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFAFA0A0)),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/svg/edit_profile.svg',
                              width: 12,
                              height: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //todo: This need to fixed.
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
                    membership,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Color(0xFFAFA0A0),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      await FlutterShare.share(
                          title: 'a',
                          text: ' ',
                          linkUrl:
                          'https://play.google.com/store/apps/details?id=com.sofiqe.app',
                          chooserTitle: '');
                    },
                    child: Container(
                      // padding:
                      // EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFFF2CA8A),
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PngIcon(
                            image: 'assets/icons/share/send@3x.png',
                            padding: EdgeInsets.only(left: size.width * 0.01),
                            height: 22,
                            width: 22,
                          ),
                          // SizedBox(
                          //   height: 3,
                          // ),
                          Padding(
                            padding: EdgeInsets.only(bottom:  size.width * 0.015, top: size.width * 0.01, right: size.width * 0.015, left: size.width * 0.015),
                            child: Text(
                              'SHARE\nAPP',
                              textAlign: TextAlign.center,
                              style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                color: Colors.black,
                                fontSize: size.height * 0.009,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //
                  // RoundButton(
                  //   size: size.height * 0.075,
                  //   backgroundColor: Color(0xFFF2CA8A),
                  //   onPress: () async {
                  //     await FlutterShare.share(
                  //         title: 'a',
                  //         text: ' ',
                  //         linkUrl:
                  //             'https://play.google.com/store/apps/details?id=com.sofiqe.app',
                  //         chooserTitle: '');
                  //   },
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Expanded(
                  //         child: PngIcon(
                  //           image: 'assets/icons/share/send@3x.png',
                  //           padding: EdgeInsets.only(left: size.width * 0.01),
                  //           height: 25,
                  //           width: 25,
                  //         ),
                  //       ),
                  //       Text(
                  //         'SHARE\nAPP',
                  //         textAlign: TextAlign.center,
                  //         style:
                  //             Theme.of(context).textTheme.headline2!.copyWith(
                  //                   color: Colors.black,
                  //                   fontSize: size.height * 0.01,
                  //                 ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  ap.isLoggedIn
                      ? Container()
                      : GestureDetector(
                    onTap: () {
                      profileController.screen.value = 1;
                    },
                    child: Text(
                      'UPGRADE',
                      style:
                      Theme.of(context).textTheme.headline2!.copyWith(
                        color: Color(0xFFF2CA8A),
                        fontSize: size.height * 0.01,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}