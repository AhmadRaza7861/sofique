import 'package:flutter/material.dart';

// Utils
import 'package:sofiqe/utils/constants/app_colors.dart';

// Custom packages
import 'package:sofiqe/widgets/png_icon.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Function onChanged;
  final double size;
  final Widget? unselectedChild;
  final Widget? selectedChild;
  final Color borderColor;
  CustomRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.size = 24,
    this.unselectedChild,
    this.selectedChild,
    this.borderColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
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
            child: value == groupValue
                ? (selectedChild != null ? selectedChild : _Selected())
                : (unselectedChild != null ? selectedChild : _UnSelected()),
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
        width: 14,
        height: 14,
      ),
    );
  }
}
