import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sofiqe/widgets/product_error_image.dart';

class ProductImage extends StatelessWidget {
  final String imageShortPath;
  final double width;
  final double height;
  ProductImage({
    Key? key,
    this.imageShortPath = '',
    this.width = 400,
    this.height = 400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image = imageShortPath;
    if (imageShortPath.startsWith('http')) {
      image = image.replaceAll(
          // RegExp(r'https://dev.sofiqe.com/media/catalog/product'), '');
          RegExp(r'https://sofiqe.com/media/catalog/product'),
          '');
    }

    return Container(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageShortPath == ""
            ? "https://sofiqe.com/media/catalog/product/cache/983707a945d60f44d700277fbf98de57\$image"
            : 'https://sofiqe.com/media/catalog/product/cache/983707a945d60f44d700277fbf98de57$image',
        // fit: BoxFit.cover,
        placeholder: (context, _) => Image.asset(
          'assets/images/sofiqe-font-logo-2.png',
        ),
        errorWidget: (context, url, error) {
          return ProductErrorImage(
            width: width,
            height: height,
          );
        },
      ),
      // FadeInImage.assetNetwork(
      //   placeholder: 'assets/images/sofiqe-font-logo-2.png',
      //   // placeholder: 'assets/images/checkout_product_image.png',
      //   image: imageShortPath == ""
      //       ? "https://sofiqe.com/media/catalog/product/cache/983707a945d60f44d700277fbf98de57\$image"
      //       : 'https://sofiqe.com/media/catalog/product/cache/983707a945d60f44d700277fbf98de57$image',
      //   // 'https://dev.sofiqe.com/media/catalog/product/cache/983707a945d60f44d700277fbf98de57$image',
      //   // errorBuilder: (BuildContext c, Object o, StackTrace? st) {
      //   //   return ProductErrorImage(
      //   //     width: width,
      //   //     height: height,
      //   //   );
      //   // },
      //   //  ),
      // ),
    );
  }
}
