import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainButtons extends StatelessWidget {
  final void Function() onTap;
  final Widget title;
  final Widget? icon;
  const MainButtons({
    Key? key,
    required this.onTap,
    required this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.08,
        width: size.width,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: size.height * 0.02,
                  width: size.height * 0.02,
                  child: icon != null ? icon as Widget : Container(),
                ),
                SizedBox(width: size.width * 0.04),
                title,
              ],
            ),
            SvgPicture.asset('assets/svg/path.svg'),
          ],
        ),
      ),
    );
  }
}
