import 'package:flutter/material.dart';
import 'package:sofiqe/widgets/round_button.dart';

class AnimatedRoundButton extends StatefulWidget {
  final Widget activeChild;
  final Widget inActiveChild;
  final Color activeBackgroundColor;
  final Color inActiveBackgroundColor;
  final Color activeBorderColor;
  final Color inActiveBorderColor;
  final double width;
  final void Function() onTap;
  const AnimatedRoundButton({
    Key? key,
    required this.activeChild,
    required this.inActiveChild,
    required this.activeBackgroundColor,
    required this.inActiveBackgroundColor,
    required this.activeBorderColor,
    required this.inActiveBorderColor,
    required this.width,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedRoundButtonState createState() => _AnimatedRoundButtonState();
}

class _AnimatedRoundButtonState extends State<AnimatedRoundButton> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails d) {
        active = true;
        setState(() {});
      },
      onTapCancel: () {
        active = false;
        setState(() {});
      },
      child: RoundButton(
        size: widget.width,
        onPress: widget.onTap,
        borderColor: (active ? widget.activeBorderColor : widget.inActiveBorderColor),
        backgroundColor: (active ? widget.activeBackgroundColor : widget.inActiveBackgroundColor),
        child: (active ? widget.activeChild : widget.inActiveChild),
      ),
    );
  }
}
