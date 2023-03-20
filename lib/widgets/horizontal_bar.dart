import 'package:flutter/material.dart';

class HorizontalBar extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  HorizontalBar({this.height = 1, this.width = 135, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: color),
    );
  }
}
