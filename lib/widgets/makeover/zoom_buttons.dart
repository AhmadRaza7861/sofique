import 'package:flutter/material.dart';

import 'package:sofiqe/widgets/makeover/make_over_buttons.dart';

import 'package:get/get.dart';
import 'package:sofiqe/provider/make_over_provider.dart';

class ZoomButtons extends StatelessWidget {
  final Function zoomIn;
  final Function zoomOut;

  ZoomButtons({Key? key, required this.zoomIn, required this.zoomOut})
      : super(key: key);

  final MakeOverProvider mop = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (mop.tab.value == 1) {
          return Container();
        }
        return Container(
          margin: EdgeInsets.symmetric(vertical: 22, horizontal: 12),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                ZoomButton(
                    onPressed: zoomIn,
                    increment: true,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 10,
                          letterSpacing: -1.25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                SizedBox(height: 8),
                ZoomButton(
                    onPressed: zoomOut,
                    increment: false,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 10,
                          letterSpacing: -1.25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ZoomButton extends MakeOverButtons {
  final Function onPressed;
  final TextStyle style;
  final bool increment;
  ZoomButton({
    required this.onPressed,
    required this.increment,
    required this.style,
  }) : super(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ZOOM', style: style),
              Text(increment ? '+' : '-', style: style),
            ],
          ),
          onPressed: onPressed,
        );
}
