import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/model/product_model.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/product_detail_1_screen.dart';
import 'package:sofiqe/screens/try_it_on_screen.dart';
import 'package:sofiqe/utils/states/function.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/product_detail/order_notification.dart';
import 'package:sofiqe/widgets/product_image.dart';
import 'package:sofiqe/widgets/round_button.dart';
import 'package:sofiqe/widgets/wishlist.dart';

import '../screens/evaluate_screen.dart';
import '../utils/constants/app_colors.dart';

class ProductItemCard extends StatelessWidget {
  final Product product;
  ProductItemCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final PageProvider pp = Get.find();
  final TryItOnProvider tiop = Get.find();

  String firstFewWords(String m, int brk) {
    int startIndex = 0, indexOfSpace = m.length;
    print("test");
    for (int i = 0; i < brk; i++) {
      indexOfSpace = m.indexOf(' ', startIndex);
      if (indexOfSpace == -1) {
        //-1 is when character is not found
        return m;
      }
      startIndex = indexOfSpace + 1;
    }

    return m.substring(0, indexOfSpace) + '...';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext c) {
              return ProductDetail1Screen(sku: product.sku!);
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WishList(
                      sku: product.sku!,
                      itemId: product.id!,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          pp.share(product.productURL, product.name);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.share,
                              color: Colors.black, size: 20.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
              child: ProductImage(
                imageShortPath: product.image,
                width: double.infinity,
                height: size.height * 0.10,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
              child: Text(
                firstFewWords(product.name.toString(), 26),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() =>
                    EvaluateScreen(product.image, product.sku, product.name));
              },
              child: Padding(
                padding: EdgeInsets.only(left: size.width * .035),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      ignoreGestures: true,
                      itemSize: 14,
                      initialRating: double.parse(product.avgRating),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    SizedBox(width: 5),
                    Text(
                      product.avgRating.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '(${product.reviewCount.toString()})',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                    // SizedBox(width: 5),
                    // Text(
                    //   '(${product.reviewCount.toString()})',
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 10,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${product.discountedPrice != null ? product.discountedPrice!.toString().toProperCurrency() : product.price!.toString().toProperCurrency()}',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.black,
                          fontSize: size.height * 0.015,
                        ),
                  ),
                  // Text(
                  //   '${product.discountedPrice != null ? '${product.price.toString().toProperCurrency()}' : ''}',
                  //   style: Theme.of(context).textTheme.headline2!.copyWith(
                  //         color: Colors.red,
                  //         fontSize: size.height * 0.011,
                  //         decoration: TextDecoration.lineThrough,
                  //       ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * .035, top: 3),
              child: Row(
                children: [
                  Text(
                    // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                    'Earn ' + product.price!.round().toString(),
                    //product.rewardsPoint,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: SplashScreenPageColors.earnColor,
                          fontSize: 11.0,
                        ),
                  ),
                  Image.asset(
                    "assets/images/coin.png",
                    width: 10.0,
                  ),
                  Text(
                    // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                    ' VIP points',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: SplashScreenPageColors.earnColor,
                          fontSize: 10.0,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                    () => RoundButton(
                      sku: product.name.toString(),
                      backgroundColor: tiop.isChangeButtonColor.isTrue &&
                              tiop.sku.value == product.name.toString()
                          ? tiop.ontapColor
                          : Color(0xFFF2CA8A),
                      size: size.height * 0.068,
                      child: Text(
                        'TRY ON',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.black,
                              fontSize: size.height * 0.012,
                            ),
                      ),
                      onPress: () {
                        tiop.received.value = product;
                        tiop.page.value = 2;
                        tiop.directProduct.value = true;
                        tiop.lookProduct.value = false;
                        tiop.currentSelectedProducturl.value =
                            product.productURL;
                        tiop.currentSelectedProductname.value = product.name!;
                        // pp.goToPage(Pages.TRYITON);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => TryItOnScreen()));
                      },
                    ),
                  ),
                  Obx(
                    () => RoundButton(
                        sku: product.sku.toString(),
                        backgroundColor: tiop.isChangeButtonColor.isTrue &&
                                tiop.sku.value == product.sku.toString()
                            ? tiop.ontapColor
                            : Colors.black,
                        size: size.height * 0.068,
                        child: PngIcon(
                            image: 'assets/icons/add_to_cart_white.png'),
                        onPress: () async {
                          print(product.typeid);
                          print("Product Options");
                          print(product.options);
                          print(product.hasOption);
                          try {
                            print("CLICK${product}");
                            if (product.typeid == "configurable") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext c) {
                                    return ProductDetail1Screen(
                                        sku: product.sku!);
                                  },
                                ),
                              );
                            } else if (product.typeid == "simple") {
                              context.loaderOverlay.show();

                              CartProvider cartP = Provider.of<CartProvider>(
                                  context,
                                  listen: false);
                              print(
                                  "CartProvider  -->> SSs ${cartP.cartToken}");
                              await cartP.addHomeProductsToCart(
                                  context, product);
                              print("Name  -->> EEE ${product.image}");
                              context.loaderOverlay.hide();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  padding: EdgeInsets.all(0),
                                  backgroundColor: Colors.black,
                                  duration: Duration(seconds: 1),
                                  content: Container(
                                    child: CustomSnackBar(
                                      sku: product.sku!,
                                      image: product.image.replaceAll(RegExp(
                                          // 'https://dev.sofiqe.com/media/catalog/product'),
                                          'https://sofiqe.com/media/catalog/product'), ''),
                                      name: product.name!,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext c) {
                                    return ProductDetail1Screen(sku: product.sku!);
                                  },
                                ),
                              );
                            }
                          } catch (e) {
                            context.loaderOverlay.hide();
                            print("This is error");
                            String error = "";
                            error = e.toString().length > 150
                                ? e.toString().substring(0, 149)
                                : e.toString();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                padding: EdgeInsets.all(0),
                                backgroundColor: Colors.black,
                                duration: Duration(seconds: 2),
                                content: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                      "Error in adding Product to cart \n" +
                                          error.toString()),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
          ],
        ),
      ),
    );
  }
}
