import 'package:flutter/material.dart';

class CustomWhiteCards extends StatelessWidget {
  final List<Widget> child;
  final EdgeInsetsGeometry padding;
  const CustomWhiteCards({
    Key? key,
    required this.child,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: child,
      ),
    );
  }
}
