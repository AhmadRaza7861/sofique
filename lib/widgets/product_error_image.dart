import 'package:flutter/material.dart';

class ProductErrorImage extends StatelessWidget {
  final double? width;
  final double? height;
  const ProductErrorImage({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != null ? width : 400,
      height: height != null ? height : 400,
      child: Image.asset(
        'assets/images/product_error_image.png',
        width: width != null ? width : 400,
        height: height != null ? height : 400,
      ),
    );
  }
}
