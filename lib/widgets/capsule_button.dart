import 'package:flutter/material.dart';

class CapsuleButton extends StatefulWidget {
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
  CapsuleButton({
    required this.onPress,
    this.width,
    this.height,
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

class _CapsuleButtonState extends State<CapsuleButton> {
  bool down = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightCalculated = 60;
    if (widget.height == null) {
      heightCalculated = size.height * 0.08;
    }
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
          height: widget.height == null ? heightCalculated : widget.height,
          width: widget.width,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: widget.horizontalPadding),

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
          height: widget.height == null ? heightCalculated : widget.height,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: widget.horizontalPadding),
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
