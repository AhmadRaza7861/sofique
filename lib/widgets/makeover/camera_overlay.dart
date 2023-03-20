// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/make_over_provider.dart';

import 'blur.dart';

class CameraOverlay extends StatelessWidget {
  final Function zoomIn;
  final Function zoomOut;
  final Function capture;
  CameraOverlay(
      {Key? key,
      required this.zoomIn,
      required this.zoomOut,
      required this.capture})
      : super(key: key);

  final MakeOverProvider mop = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (mop.screen == 1 && mop.tab == 1) {
          //       if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
          //   mop.sendResponse(
          //       Provider.of<AccountProvider>(context, listen: false).customerId);
          // }
          // if (mop.currentPrompt == 0)
          {
            return _FrontProfile();
          }
          // else if (mop.currentPrompt == 1) {
          //   return _HairProfile();
          // } else {
          //   return _LipsProfile();
          // }
        } else if (mop.tab.value < 0) {
          return Blur();
        } else {
          return Container();
        }
      },
    );
  }
}

class _FrontProfile extends StatelessWidget {
  const _FrontProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.1, horizontal: size.height * 0.06),
      child: DottedBorder(
        dashPattern: [5],
        borderType: BorderType.Oval,
        color: Colors.white,
        strokeWidth: 1.5,
        child: Container(
          height: size.height * 0.4,
          width: size.width * 0.8,
        ),
      ),
    );
  }
}

// class _HairProfile extends StatelessWidget {
//   const _HairProfile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Container(
//       margin: EdgeInsets.symmetric(
//           vertical: size.height * 0.1, horizontal: size.width * 0.2),
//       height: size.height * 0.4,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Color(0x66F2CA8A),
//           width: 4,
//         ),
//       ),
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: Text(
//           'Your ear should fit inside this box',
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.headline2!.copyWith(
//                 color: Color(0xFFF2CA8A),
//                 fontSize: size.height * 0.02,
//               ),
//         ),
//       ),
//     );
//   }
// }

// class _LipsProfile extends StatelessWidget {
//   const _LipsProfile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Container(
//       margin: EdgeInsets.symmetric(
//           vertical: size.height * 0.25, horizontal: size.width * 0.03),
//       height: size.height * 0.2,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Color(0x66F2CA8A),
//           width: 4,
//         ),
//       ),
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: Text(
//           'Your lips should fit inside this box',
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.headline2!.copyWith(
//                 color: Color(0xFFF2CA8A),
//                 fontSize: size.height * 0.02,
//               ),
//         ),
//       ),
//     );
//   }
// }
