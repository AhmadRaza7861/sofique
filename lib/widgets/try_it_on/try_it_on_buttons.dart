import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/evaluate_screen.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/widgets/makeover/make_over_buttons.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/try_it_on/try_it_on_look_button.dart';

import '../../controller/selectedProductController.dart';

class TryItOnButtons extends StatelessWidget {
  final AnimationController controller;
  TryItOnButtons({Key? key,required this.controller}) : super(key: key);
  final TryItOnProvider tiop = Get.find<TryItOnProvider>();
  final TryItOnProvider tmo = Get.find();
  final SelectedProductController selectedProductController=Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.30,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                    () {
                  if (tmo.currentSelectedProducturl.value != "" && tmo.selectedProduct.value == true && 1 != 1) {
                    return MakeOverButtons(
                      padding: EdgeInsets.only(left: 8, bottom: 8),
                      size: 55,
                      backgroundColor: AppColors.primaryColor,
                      borderColor: AppColors.primaryColor,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SvgPicture.asset('assets/svg/star_filled.svg', color: Colors.black),
                            ),
                            Text(
                              "Review".toUpperCase(),
                              style: TextStyle(fontSize: 10, color: Colors.black, decoration: TextDecoration.none),
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => EvaluateScreen(tmo.currentSelectedProductimage.value,
                            tmo.currentSelectedProductsku.value, tmo.currentSelectedProductname.value));
                      },
                    );
                  } else {
                    return Container(
                      width: 63,
                    );
                  }
                },
              ),
              Obx(
                    () {
                  if (tmo.currentSelectedProducturl.value != "" && tmo.selectedProduct.value == true ||tmo.selectedProduct.value == false) {
                    return MakeOverButtons(
                      padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                      size: 55,
                      // backgroundColor: AppColors.primaryColor,
                      // borderColor: AppColors.primaryColor,
                      backgroundColor: Colors.transparent,
                      borderColor: Colors.transparent,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: PngIcon(
                                image: 'assets/icons/share/send@3x2.png',
                                padding: EdgeInsets.zero,
                                height: 20,
                                width: 20,
                              ),
                            ),
                            Text(
                              "Share".toUpperCase(),
                              style: Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 9,
                                  // color:AppColors.primaryColor,
                                  color: Colors.black),
                              // style: TextStyle(
                              //     fontSize: 10,
                              //     color: Colors.black,
                              //     decoration: TextDecoration.none),
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Share.share(tmo.currentSelectedProducturl.value, subject: tmo.currentSelectedProductname.value);
                      },
                    );
                  } else {
                    return Container(
                      width: 63,
                    );
                  }
                },
              ),
              //---left side filter toggle button
              Obx(
                    () {
                  if (tmo.selectedProduct.isTrue) {
                    // if (tmo.lookProduct.isTrue && tmo.selectedProduct.isTrue) {
                    // return Container();
                    // return TryItOnColorSelector();
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: ()async {
                            tmo.toggleShadesIconSelection(tmo.selectedShades.isTrue ? false : true);
                            if (tiop.bottomSheetVisible.value) {
                              await controller.reverse();
                              // tiop.toggleBottomSheetVisibility();
                              // tiop.toggleShadesIconSelection(true);
                              await tiop.pc.value.close();
                            } else {
                              // tiop.toggleBottomSheetVisibility();
                              // tiop.toggleShadesIconSelection(false);
                              await controller.forward();
                              await tiop.pc.value.open();
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: PngIcon(
                                  image: 'assets/icons/filter-colors.png',
                                  padding: EdgeInsets.zero,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              Text(
                                "SHADES".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 10,
                                    // color: Colors.white,
                                    color: Colors.black,
                                    decoration: TextDecoration.none),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        tmo.selectedShades.isTrue
                            ? Positioned(
                          bottom: 20,
                          left: -4,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                            padding: EdgeInsets.all(4),
                          ),
                        )
                            : Container()
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
          Obx(
                () {
              if (tmo.lookProduct.isTrue && tmo.selectedProduct.isTrue) {
                // return Container();
                // return TryItOnColorSelector();
                return Container();
              } else {
                return Container();
              }
            },
          ),
          Obx(() {
            if (tmo.lookProduct.value == true) {
              return TryItOnLookButton();
            } else {
              return Container();
            }
          }),
          if (tmo.lookProduct.value == true)
            Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                          () {
                        return Stack(alignment: Alignment.centerRight, children: [
                          MakeOverButtons(
                            padding: EdgeInsets.only(bottom: 8, right: 8, top: 8),
                            size: 55,
                            backgroundColor: Colors.transparent,
                            borderColor: Colors.transparent,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  PngIcon(
                                    image: 'assets/icons/eyes/eye@3x.png',
                                    padding: EdgeInsets.zero,
                                    height: 20,
                                    width: 20,
                                  ),
                                  Text(
                                    "Eyes".toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(fontSize: 10, color: Colors.black
                                      // color: AppColors.primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onPressed: () {
                              selectedProductController.isreplace.value=false;
                              selectedProductController.isreplace_1.value=false;
                              selectedProductController.temp1=[];
                              selectedProductController.value=[];
                              tmo.changearea("Eyes");
                            },
                          ),
                          tmo.selectedFaceArea.value == "Eyes"
                              ? Container(
                            margin: EdgeInsets.only(bottom: 5, right: 10),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                            padding: EdgeInsets.all(4),
                          )
                              : Container()
                        ]);
                      },
                    ),
                    Obx(
                          () {
                        return Stack(alignment: Alignment.centerRight, children: [
                          MakeOverButtons(
                            padding: EdgeInsets.only(right: 8, bottom: 8, top: 8),
                            size: 55,
                            backgroundColor: Colors.transparent,
                            borderColor: Colors.transparent,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  PngIcon(
                                    image: 'assets/icons/lips/mouth@3x.png',
                                    padding: EdgeInsets.zero,
                                    height: 20,
                                    width: 20,
                                  ),
                                  Text(
                                    "Lips".toUpperCase(),
                                    style: Theme.of(context).textTheme.headline2!.copyWith(
                                        fontSize: 10,
                                        // color:AppColors.primaryColor,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            onPressed: () {
                              selectedProductController.isreplace.value=false;
                              selectedProductController.isreplace_1.value=false;
                              selectedProductController.temp1=[];
                              selectedProductController.value=[];
                              tmo.changearea("Lips");
                            },
                          ),
                          tmo.selectedFaceArea.value == "Lips"
                              ? Container(
                            margin: EdgeInsets.only(bottom: 5, right: 10),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                            padding: EdgeInsets.all(4),
                          )
                              : Container()
                        ]);
                      },
                    ),
                    Obx(
                          () {
                        return Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            MakeOverButtons(
                              padding: EdgeInsets.only(right: 8, bottom: 8),
                              size: 55,
                              backgroundColor: Colors.transparent,
                              borderColor: Colors.transparent,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomPaint(
                                      painter: _CheeksStrokePainter(size: MediaQuery.of(context).size),
                                    ),
                                    Text(
                                      "Cheeks".toUpperCase(),
                                      style: Theme.of(context).textTheme.headline2!.copyWith(
                                          fontSize: 9,
                                          // color:AppColors.primaryColor,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {
                                selectedProductController.isreplace.value=false;
                                selectedProductController.isreplace_1.value=false;
                                selectedProductController.temp1=[];
                                selectedProductController.value=[];
                                tmo.changearea("Cheeks");
                              },
                            ),
                            tmo.selectedFaceArea.value == "Cheeks"
                                ? Container(
                              margin: EdgeInsets.only(bottom: 5, right: 10),
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              padding: EdgeInsets.all(4),
                            )
                                : Container()
                          ],
                        );
                      },
                    ),
                  ],
                )),
        ],
      ),
    );
  }
}

class _CheeksStrokePainter extends CustomPainter {
  Size size;
  _CheeksStrokePainter({required this.size});
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xFFF2CA8A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    //draw arc
    canvas.drawArc(
      Rect.fromCenter(center: Offset(10, -12), width: 40, height: 44),

      1.6, //radians
      1.4, //radians
      false,
      paint1,
    );
  }

  @override
  bool shouldRepaint(_CheeksStrokePainter old) {
    return true;
  }
}
