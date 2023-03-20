import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../provider/catalog_provider.dart';
import '../provider/try_it_on_provider.dart';

class RoundButton extends StatelessWidget {
  final double size;
  final Function onPress;
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final String sku;
  const RoundButton({
    Key? key,
    this.size = 24,
    this.sku="",
    required this.onPress,
    required this.child,
    this.padding,
    this.backgroundColor = Colors.black,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TryItOnProvider TIOP=Get.find();
    final CatalogProvider catp = Get.find();
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(size)),
      child: GestureDetector(
        onTap: () {
          TIOP.sku.value=sku;
          catp.sku.value=sku;
          catp.isChangeButtonColor.value=true;
          TIOP.isChangeButtonColor.value=true;
          TIOP.playSound();
          Future.delayed(Duration(milliseconds: 10)).then((value)
          {
            catp.isChangeButtonColor.value=false;
            TIOP.isChangeButtonColor.value=false;
            TIOP.sku.value="";
            onPress();
          });


        },
        child: Container(
          width: size,
          height: size,
          margin: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(size)),
            border: Border.all(color: borderColor != null ? borderColor as Color : backgroundColor as Color),
            color:backgroundColor,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
