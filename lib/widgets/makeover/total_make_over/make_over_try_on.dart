// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sofiqe/provider/make_over_provider.dart';
// import 'package:sofiqe/provider/total_make_over_provider.dart';
// import 'package:sofiqe/widgets/capsule_button.dart';
// import 'package:sofiqe/widgets/makeover/total_make_over/bottom_sheet_body.dart';
// import 'package:sofiqe/widgets/makeover/total_make_over/color_slider.dart';
// import 'package:sofiqe/widgets/makeover/total_make_over/total_make_over_buttons.dart';
// import 'package:sofiqe/widgets/makeover/total_make_over/total_make_over_top_menu.dart';
// import 'package:sofiqe/widgets/png_icon.dart';

// class MakeOverTryOn extends StatefulWidget {
//   const MakeOverTryOn({
//     Key? key
//   }) : super(key: key);

//   @override
//   _MakeOverTryOnState createState() => _MakeOverTryOnState();
// }

// class _MakeOverTryOnState extends State<MakeOverTryOn>
//     with TickerProviderStateMixin {
//   late final AnimationController _controller = AnimationController(
//     duration: const Duration(milliseconds: 200),
//     vsync: this,
//   );
//   late final Animation<double> _animation = CurvedAnimation(
//     parent: _controller,
//     curve: Curves.linear,
//   );

//   final MakeOverProvider makeOverProvider = Get.find<MakeOverProvider>();

//   final MakeOverProvider mop = Get.find();
//   @override
//   void dispose() {
//     _controller.dispose();
//     // if(_unityWidgetController != null ){
//     //   _unityWidgetController!.dispose();
//     // }
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     initMethod();
//   }

//   initMethod() async {
//     tmo.bottomSheetVisible.value = false;
//   }

//   final TotalMakeOverProvider tmo = Get.find();
//   // UnityWidgetController? _unityWidgetController;
//   //
//   // onUnityCreated(controller2) async {
//   //   this._unityWidgetController = controller2;
//   //   await this._unityWidgetController!.pause();
//   //   await this._unityWidgetController!.resume();
//   // }
//   //
//   // onUnityColorReceived(col){
//   //   print(col.toString());
//   // }
//   //
//   // onUnitySceneLoaded(SceneLoaded? sceneInfo) async {
//   //   await this._unityWidgetController!.pause();
//   //   await this._unityWidgetController!.resume();
//   // }
//   //
//   // unityCaptureFacePhoto() async {
//   //   await this._unityWidgetController!.postMessage(
//   //     'Solution',
//   //     'OnCaptureClick',
//   //     "capture",
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height - AppBar().preferredSize.height,
//       child: Stack(
//         children: [
//           // Positioned(
//           //   top: -size.height * 0.087,
//           //   child: Container(
//           //     height: size.height,
//           //     width: size.width,
//           //     child: OverflowBox(
//           //       alignment: Alignment.center,
//           //       child: FittedBox(
//           //         fit: BoxFit.fitWidth,
//           //         child: Container(
//           //             height: size.height - size.height * 0.167,
//           //             width: size.width,
//           //             child: UnityWidget(
//           //               onUnityCreated: onUnityCreated,
//           //               onUnityMessage: onUnityColorReceived,
//           //               onUnitySceneLoaded: onUnitySceneLoaded,
//           //               fullscreen: false,
//           //             )),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Expanded(
//                 child: TotalMakeOverTopMenu(),
//               ),
//               TotalMakeOverButtons(),
//               BottomSheetController(
//                 controller: () async {
//                   if (tmo.bottomSheetVisible.value) {
//                     await _controller.reverse();
//                     tmo.closeBottomSheet();
//                   } else {
//                     tmo.openBottomSheet();
//                     await _controller.forward();
//                   }
//                 },
//               ),
//               // Border color #F4F2F0
//               SizeTransition(
//                 sizeFactor: _animation,
//                 axis: Axis.vertical,
//                 axisAlignment: -1,
//                 child: Container(
//                   height: size.height * 0.28,
//                   color: Color(0xFFF4F2F0),
//                   child: BottomSheetBody(),
//                 ),
//               ),
//             ],
//           ),
//           Obx(
//             () {
//               if (tmo.searchOptionsVisible.value) {
//                 return ColorSlider();
//               } else {
//                 return Container();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BottomSheetController extends StatelessWidget {
//   final void Function() controller;
//   BottomSheetController({Key? key, required this.controller}) : super(key: key);

//   final TotalMakeOverProvider tmo = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       width: size.width,
//       height: size.height * 0.06,
//       decoration: BoxDecoration(
//         color: Color(0xFFF4F2F0),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Obx(
//             () {
//               String text = 'PRODUCTS';
//               String count = '0';
//               int code = tmo.currentSelectedArea.value;
//               if (code == 0) {
//                 count = '';
//                 text = 'RECOMMENDATIONS';
//               }
//               tmo.applicationAreaList.forEach(
//                 (ApplicationArea aa) {
//                   if (aa.code == code) {
//                     count = '${aa.products.length}';
//                     aa.recommendedColors.forEach(
//                       (color) {
//                         // if (tmo.centralColorMap[code] == color[0]) {
//                         if (mapEquals(tmo.centralColorMap[code], color)) {
//                           text = 'RECOMMENDATIONS';
//                         }
//                       },
//                     );
//                   }
//                 },
//               );

//               return Text(
//                 '$count $text',
//                 style: Theme.of(context).textTheme.headline2!.copyWith(
//                       color: Colors.black,
//                       fontSize: size.height * 0.015,
//                       letterSpacing: 0,
//                     ),
//               );
//             },
//           ),
//           CapsuleButton(
//             onPress: () {},
//             height: size.height * 0.04,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 PngIcon(
//                   image: 'assets/icons/add_to_cart_yellow.png',
//                 ),
//                 SizedBox(width: size.width * 0.015),
//                 Text(
//                   'ADD ALL',
//                   style: Theme.of(context).textTheme.headline2!.copyWith(
//                         color: Colors.white,
//                         fontSize: size.height * 0.015,
//                         letterSpacing: 0,
//                       ),
//                 ),
//               ],
//             ),
//           ),
// ignore: todo
//           //TODO Change this uncommit
//           Obx(
//             () {
//               return GestureDetector(
//                 onTap: controller,
//                 child: PngIcon(
//                   image: tmo.bottomSheetVisible.value
//                       ? 'assets/icons/push_down_black.png'
//                       : 'assets/icons/push_up_black.png',
//                 ),
//               );
//             },
//           ),
//           // Obx(
//           //   () {
//           //     return IconButton(
//           //       onPressed: controller,
//           //       icon: PngIcon(
//           //         image: tmo.bottomSheetVisible.value ? 'assets/icons/push_down_black.png' : 'assets/icons/push_up_black.png',
//           //       ),
//           //     );
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/total_make_over_provider.dart';
import 'package:sofiqe/widgets/capsule_button.dart';
import 'package:sofiqe/widgets/makeover/total_make_over/bottom_sheet_body.dart';
import 'package:sofiqe/widgets/makeover/total_make_over/total_make_over_buttons.dart';
import 'package:sofiqe/widgets/makeover/total_make_over/total_make_over_top_menu.dart';
import 'package:sofiqe/widgets/png_icon.dart';

import 'color_slider.dart';

class MakeOverTryOn extends StatefulWidget {
  const MakeOverTryOn({Key? key}) : super(key: key);

  @override
  _MakeOverTryOnState createState() => _MakeOverTryOnState();
}

class _MakeOverTryOnState extends State<MakeOverTryOn>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tmo.bottomSheetVisible.value = false;
  }

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height - AppBar().preferredSize.height,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: TotalMakeOverTopMenu(),
              ),
              TotalMakeOverButtons(),
              BottomSheetController(
                controller: () async {
                  if (tmo.bottomSheetVisible.value) {
                    await _controller.reverse();
                    tmo.closeBottomSheet();
                  } else {
                    tmo.openBottomSheet();
                    await _controller.forward();
                  }
                },
              ),
              // Border color #F4F2F0
              SizeTransition(
                sizeFactor: _animation,
                axis: Axis.vertical,
                axisAlignment: -1,
                child: Container(
                  height: size.height * 0.28,
                  color: Color(0xFFF4F2F0),
                  child: BottomSheetBody(),
                ),
              ),
            ],
          ),
          Obx(
            () {
              if (tmo.searchOptionsVisible.value) {
                return ColorSlider();
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

class BottomSheetController extends StatelessWidget {
  final void Function() controller;
  BottomSheetController({Key? key, required this.controller}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.06,
      decoration: BoxDecoration(
        color: Color(0xFFF4F2F0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(
            () {
              String text = 'PRODUCTS';
              String count = '0';
              int code = tmo.currentSelectedArea.value;
              if (code == 0) {
                count = '';
                text = 'RECOMMENDATIONS';
              }
              tmo.applicationAreaList.forEach(
                (ApplicationArea aa) {
                  if (aa.code == code) {
                    count = '${aa.products.length}';
                    aa.recommendedColors.forEach(
                      (color) {
                        // if (tmo.centralColorMap[code] == color[0]) {
                        if (listEquals(tmo.centralColorMap[code], color)) {
                          text = 'RECOMMENDATIONS';
                        }
                      },
                    );
                  }
                },
              );

              return Text(
                '$count $text',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: size.height * 0.015,
                      letterSpacing: 0,
                    ),
              );
            },
          ),
          CapsuleButton(
            onPress: () {},
            height: size.height * 0.04,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PngIcon(
                  image: 'assets/icons/add_to_cart_yellow.png',
                ),
                SizedBox(width: size.width * 0.015),
                Text(
                  'ADD ALL',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.white,
                        fontSize: size.height * 0.015,
                        letterSpacing: 0,
                      ),
                ),
              ],
            ),
          ),
          Obx(
            () {
              return IconButton(
                onPressed: controller,
                icon: PngIcon(
                  image: tmo.bottomSheetVisible.value
                      ? 'assets/icons/push_down_black.png'
                      : 'assets/icons/push_up_black.png',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
