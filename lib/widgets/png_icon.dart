import 'package:flutter/material.dart';

class PngIcon extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final double scale;
  final Color? color;
  final EdgeInsets padding;
  PngIcon(
      {required this.image,
      this.width = 18.26,
      this.height = 18.26,
      this.scale = 1,
      this.color,
      this.padding = const EdgeInsets.symmetric(vertical: 6)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Center(
        child: Image.asset(
          '$image',
          color: color,
          scale: scale,
          height: height,
          width: width,
        ),
      ),
    );
  }
}
