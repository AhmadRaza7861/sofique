import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Widget icon;
  final double size;
  final Color backgroundColor;

  CircleIcon({
    required this.icon,
    this.size = 12,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(size)),
        color: backgroundColor,
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
