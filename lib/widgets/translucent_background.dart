import 'package:flutter/material.dart';

class TranslucentBackground extends StatelessWidget {
  final double opacity;
  final Color color;
  const TranslucentBackground({Key? key, this.opacity = 0.5, this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
      ),
    );
  }
}
