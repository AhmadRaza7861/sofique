import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
// Custom packages
import 'package:sofiqe/widgets/makeover/custom_bottom_sheet.dart';
import 'package:sofiqe/widgets/makeover/warning_for_patients.dart';
import 'package:sofiqe/widgets/makeover/zoom_buttons.dart';
import 'package:sofiqe/widgets/makeover/question_controller.dart';

class MakeOverOverlay extends StatelessWidget {
  final Function zoomIn;
  final Function zoomOut;
  final Function capture;
  MakeOverOverlay(
      {Key? key,
      required this.zoomIn,
      required this.zoomOut,
      required this.capture})
      : super(key: key);

  final MakeOverProvider mop = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: _TopHalf(),
          ),
          Obx(
                () {
                  print("mop.tab.value >= 0 ${mop.tab.value >= 0}");
              if (mop.tab.value >= 0) {
                return _BottomHalf(
                    zoomIn: zoomIn, zoomOut: zoomOut, capture: this.capture);
              }
              else {
                return WarningForPatients();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _TopHalf extends StatelessWidget {
  const _TopHalf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 24),
      child: QuestionController(
        flowfromIngredients: false,
      ),
    );
  }
}

class _BottomHalf extends StatelessWidget {
  final Function zoomIn;
  final Function zoomOut;
  final Function capture;
  _BottomHalf(
      {Key? key,
      required this.zoomIn,
      required this.zoomOut,
      required this.capture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ZoomButtons(zoomIn: zoomIn, zoomOut: zoomOut),
        CustomBottomSheet(capture: capture),
      ],
    );
  }
}
