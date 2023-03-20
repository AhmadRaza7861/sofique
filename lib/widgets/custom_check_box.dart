import 'package:flutter/material.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/widgets/png_icon.dart';

class CustomCheckBox extends StatelessWidget {
  final Function onChanged;
  final bool value;
  final double size;
  final Widget? unselectedChild;
  final Widget? selectedChild;
  final Color borderColor;
  const CustomCheckBox({
    Key? key,
    required this.onChanged,
    required this.value,
    this.size = 20,
    this.unselectedChild,
    this.selectedChild,
    this.borderColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(size)),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(size)),
            border: Border.all(color: borderColor),
          ),
          child: Center(
            child: value ? (selectedChild != null ? selectedChild : _Selected()) : (unselectedChild != null ? selectedChild : _UnSelected()),
          ),
        ),
      ),
    );
  }
}

class _UnSelected extends StatelessWidget {
  const _UnSelected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.transparent,
      ),
    );
  }
}

class _Selected extends StatelessWidget {
  const _Selected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: PngIcon(
        image: 'assets/icons/check-mark-white.png',
        width: 18,
        height: 18,
      ),
    );
  }
}
