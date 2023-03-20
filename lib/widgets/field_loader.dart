import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FieldLoader extends StatelessWidget {
  const FieldLoader({super.key, this.height = 40, this.size = 40, this.color = const Color(0xffF2CA8A)});
  final double height;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitThreeInOut(
              color: color,
              size: size,
            )
          ],
        ));
  }
}
