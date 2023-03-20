import 'package:flutter/material.dart';

class CapsuleButtonCheckout extends StatefulWidget {
  // Widget properties
  final Function onPress;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? onTouchBackgroundColor;
  final Widget child;
  final Color? borderColor;
  final Color? onTouchBorderColor;
  final double horizontalPadding;

  // Constructor
  CapsuleButtonCheckout({
    required this.onPress,
    this.width =  double.infinity,
    required this.height,
    this.horizontalPadding = 25,
    this.backgroundColor = Colors.black,
    this.onTouchBackgroundColor,
    required this.child,
    this.borderColor,
    this.onTouchBorderColor,
  });

  @override
  _CapsuleButtonState createState() => _CapsuleButtonState();
}

class _CapsuleButtonState extends State<CapsuleButtonCheckout> {
  bool down = false;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // double heightCalculated = 60;

    // if (widget.height == null) {
    //   heightCalculated = size.height * 0.08;
    // }
    if (widget.width != null) {
      return GestureDetector(
        onTapDown: (TapDownDetails t) {
          down = true;
          setState(() {});
        },
        onTapUp: (TapUpDetails t) {
          down = false;
          setState(() {});
          widget.onPress();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 11),
          height: widget.height,
          width: double.infinity,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            border: Border.all(
              color: down && (widget.onTouchBorderColor != null)
                  ? widget.onTouchBorderColor as Color
                  : (widget.borderColor != null ? widget.borderColor as Color : widget.backgroundColor as Color),
            ),
            color: down && (widget.onTouchBackgroundColor != null) ? widget.onTouchBackgroundColor : widget.backgroundColor,
          ),
          child: Center(
            child: widget.child,
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTapDown: (TapDownDetails t) {
          down = true;
          setState(() {});
        },
        onTapUp: (TapUpDetails t) {
          down = false;
          setState(() {});
          widget.onPress();
        },
        onTapCancel: () {
          down = false;
          setState(() {});
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 11),

          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            border: Border.all(
              color: down && (widget.onTouchBorderColor != null)
                  ? widget.onTouchBorderColor as Color
                  : (widget.borderColor != null ? widget.borderColor as Color : widget.backgroundColor as Color),
            ),
            color: down && (widget.onTouchBackgroundColor != null) ? widget.onTouchBackgroundColor : widget.backgroundColor,
          ),
          child: Center(
            child: widget.child,
          ),
        ),
      );
    }
  }
}
