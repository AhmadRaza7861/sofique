import 'package:flutter/material.dart';
import 'package:sofiqe/widgets/round_button.dart';

class MakeOverButtons extends RoundButton {
  final Widget child;
  final Function onPressed;
  final double size;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsets padding;
  MakeOverButtons({
    required this.child,
    required this.onPressed,
    this.size = 51,
    this.padding = const EdgeInsets.all(0),
    this.backgroundColor = const Color(0x80FDFDFD),
    this.borderColor = Colors.black,
  }) : super(
          child: child,
          onPress: onPressed,
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          size: size,
        );
}
