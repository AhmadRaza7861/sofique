import 'package:flutter/material.dart';
import 'package:sofiqe/widgets/horizontal_bar.dart';
import 'package:sofiqe/widgets/product_image.dart';

class CustomSnackBar extends StatelessWidget {
  final String image;
  final String name;
  final String sku;
  const CustomSnackBar({Key? key, required this.sku, required this.image, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("ENTER 123");
    var size = MediaQuery.of(context).size;
    // var cart = Provider.of<CartProvider>(context).cart;
    String count = '1';
    // cart!.forEach((item) {
    //   if (item['sku'] == sku) {
    //     count = '${item['qty']}';
    //   }
    // });
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.width * 0.03, horizontal: size.height * 0.03),
      height: size.height * 0.25,
      color: Colors.black,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: size.height * 0.03, horizontal: size.width * 0.05),
              height: size.height * 0.05,
              width: size.height * 0.05,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(size.height * 0.05))),
              child: Center(
                child: Text(
                  '$count',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        fontSize: size.height * 0.025,
                        letterSpacing: 1.13,
                      ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProductImage(imageShortPath: '$image', height: size.height * 0.1, width: size.height * 0.1),
                Text(
                  'This has been added to your shopping bag',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.015,
                    letterSpacing: 1.13,
                  ),
                ),
                HorizontalBar(
                  color: Colors.black,
                  height: 2,
                  width: size.width * 0.14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
