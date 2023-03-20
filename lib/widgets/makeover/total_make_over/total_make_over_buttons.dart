import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/total_make_over_provider.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/widgets/makeover/make_over_buttons.dart';
import 'package:sofiqe/widgets/makeover/total_make_over/total_make_over_color_selector.dart';
import 'package:sofiqe/widgets/png_icon.dart';

class TotalMakeOverButtons extends StatelessWidget {
  TotalMakeOverButtons({Key? key}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () {
                  if (tmo.bottomSheetVisible.value) {
                    return Container(
                      width: 63,
                    );
                  } else {
                    return MakeOverButtons(
                      padding: EdgeInsets.all(8),
                      size: 55,
                      backgroundColor: AppColors.primaryColor,
                      borderColor: AppColors.primaryColor,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: PngIcon(
                                image: 'assets/icons/share/send@4x.png',
                                padding: EdgeInsets.zero,
                                height: 20,
                                width: 20,
                              ),
                            ),
                            Text(
                              "Share".toUpperCase(),
                              style: TextStyle(fontSize: 10,color: Colors.black),
                              
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        tmo.shareCallback();
                      },
                    );
                  }
                },
              ),
            ],
          ),
          Obx(
            () {
              if (tmo.colorMenuVisible.value != 0) {
                return TotalMakeOverColorSelector();
                // return Container();
              } else {
                return Container();
              }
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () {
                  return MakeOverButtons(
                    padding: EdgeInsets.all(8),
                    size: 55,
                    backgroundColor: tmo.faceArea.value == FaceArea.CHEEKS ? Colors.white : Colors.transparent,
                    borderColor: tmo.faceArea.value == FaceArea.CHEEKS ? Colors.transparent : AppColors.primaryColor,
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
                                  color: tmo.faceArea.value == FaceArea.CHEEKS ? Colors.black : AppColors.primaryColor,
                                ),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      tmo.getRecommendationsForCheeks();
                    },
                  );
                },
              ),
              Obx(
                () {
                  return MakeOverButtons(
                    padding: EdgeInsets.all(8),
                    size: 55,
                    backgroundColor: tmo.faceArea.value == FaceArea.LIPS ? Colors.white : Colors.transparent,
                    borderColor: tmo.faceArea.value == FaceArea.LIPS ? Colors.transparent : AppColors.primaryColor,
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
                                  color: tmo.faceArea.value == FaceArea.LIPS ? Colors.black : AppColors.primaryColor,
                                ),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      tmo.getRecommendationsForLips();
                    },
                  );
                },
              ),
              Obx(
                () {
                  return MakeOverButtons(
                    padding: EdgeInsets.all(8),
                    size: 55,
                    backgroundColor: tmo.faceArea.value == FaceArea.EYES ? Colors.white : Colors.transparent,
                    borderColor: tmo.faceArea.value == FaceArea.EYES ? Colors.transparent : AppColors.primaryColor,
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
                            style: Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 10,
                                  color: tmo.faceArea.value == FaceArea.EYES ? Colors.black : AppColors.primaryColor,
                                ),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      tmo.getRecommendationsForEyes();
                    },
                  );
                },
              ),
            ],
          ),
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
