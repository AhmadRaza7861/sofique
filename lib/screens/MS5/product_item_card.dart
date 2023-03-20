import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/model/product_model.dart' as pro;
import 'package:sofiqe/model/selectedProductModel.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/evaluate_screen.dart';
import 'package:sofiqe/screens/product_detail_1_screen.dart';
import 'package:sofiqe/screens/try_it_on_screen.dart';
import 'package:sofiqe/utils/api/product_details_api.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/product_detail/order_notification.dart';
import 'package:sofiqe/widgets/product_image.dart';
import 'package:sofiqe/widgets/round_button.dart';

class SelectedProductItemCard extends StatelessWidget {
  final ProductSelected product;
  final String shadecolor;

  SelectedProductItemCard(
      {Key? key, required this.product, required this.shadecolor})
      : super(key: key);

  final PageProvider pp = Get.find();
  final TryItOnProvider tiop = Get.find();

  String firstFewWords(String m, int brk) {
    int startIndex = 0, indexOfSpace = m.length;

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
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
              child: ProductImage(
                imageShortPath: product.image??"",
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    ignoreGestures: true,
                    itemSize: 18,
                    initialRating: double.parse("23"),
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
                  SizedBox(width: 10),
                  Text(
                    2.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  SizedBox(width: 10),
                  Text(
                    // '(${product.review_count.toString()})',
                    "2",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // '${product.discountedPrice != null ? product.discountedPrice!.toProperCurrencyString() : product.price!.toProperCurrencyString()}',
                    double.parse(product.price!).toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.black,
                          fontSize: size.height * 0.015,
                        ),
                  ),
                  Text(
                    // '${product.discountedPrice != null ? '€ ${product.price}' : ''}',
                    double.parse(product.price!).toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.red,
                          fontSize: size.height * 0.015,
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                      // 'Earn '+product.rewardsPoint,
                      "Earn 2",
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: SplashScreenPageColors.earnColor,
                            fontSize: 10.0,
                          ),
                    ),
                  ),
                  Container(
                    width: 10.0,
                    child: Image.asset(
                      "assets/images/coin.png",
                    ),
                  ),
                  Text(
                    // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                    ' VIP points',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: SplashScreenPageColors.earnColor,
                          fontSize: 10.0,
                        ),
                  )
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundButton(
                    backgroundColor: Color(0xFFF2CA8A),
                    size: size.height * 0.068,
                    child: Text(
                      'TRY ON',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: size.height * 0.012,
                          ),
                    ),
                    onPress: () {
                      tiop.received.value = pro.Product(
                          id: int.parse(product.entityId!),
                          name: product.name,
                          sku: product.sku,
                          price: double.parse(product.price!),
                          color: shadecolor,
                          rewardsPoint: product.rewardPoints!,
                          productURL: product.productUrl!,
                          image: product.image!,
                          description: product.description!,
                          faceSubArea: int.parse(product.faceSubArea!),
                          avgRating: product.avgrating!);
                      tiop.page.value = 2;
                      tiop.directProduct.value = true;
                      tiop.lookProduct.value = false;
                      tiop.currentSelectedProducturl.value =
                          product.productUrl!;
                      tiop.currentSelectedProductname.value = product.name!;
                      // pp.goToPage(Pages.TRYITON);
                      Get.to(() => TryItOnScreen(),);
                    },
                  ),
                  RoundButton(
                    size: size.height * 0.068,
                    child: PngIcon(image: 'assets/icons/add_to_cart_white.png'),
                    onPress: () async {
                      print("object");
                      var res = await sfAPIGetProductDetailsFromSKU(
                          sku: product.sku!);
                      Map<String, dynamic> responseBody = json.decode(res.body);
                      print(responseBody['type_id']);
                      String type = responseBody['type_id'];
                      if (type == "configurable") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext c) {
                              return ProductDetail1Screen(sku: product.sku!);
                            },
                          ),
                        );
                      } else {
                        CartProvider cartP =
                            Provider.of<CartProvider>(context, listen: false);
                        print("CartProvider  -->> SSs ${cartP.cartToken}");
                        await cartP.addHomeProductsToCart(
                            context,
                            pro.Product(
                                id: int.parse(product.entityId!),
                                name: product.name,
                                sku: product.sku,
                                price: double.parse(product.price!),
                                image: product.image!,
                                description: product.description!,
                                faceSubArea: int.parse(product.faceSubArea!),
                                avgRating: product.avgrating!));
                        print("Name  -->> EEE ${product.image}");

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            padding: EdgeInsets.all(0),
                            backgroundColor: Colors.black,
                            duration: Duration(seconds: 1),
                            content: Container(
                              child: CustomSnackBar(
                                sku: product.sku!,
                                image: product.image!.replaceAll(RegExp(
                                    // 'https://dev.sofiqe.com/media/catalog/product'),
                                    'https://sofiqe.com/media/catalog/product'), ''),
                                name: product.name!,
                              ),
                            ),
                          ),
                        );
                      }
                      // if((product.options != null && product.options!.isNotEmpty ) || product.hasOption == true){
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (BuildContext c) {
                      //         return ProductDetail1Screen(sku: product.sku!);
                      //       },
                      //     ),
                      //   );
                      // }else{
                      //   await Provider.of<CartProvider>(context, listen: false).addHomeProductsToCart(context, product);
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       padding: EdgeInsets.all(0),
                      //       backgroundColor: Colors.transparent,
                      //       duration: Duration(seconds: 1),
                      //       content: Container(
                      //         child: CustomSnackBar(
                      //           sku: product.sku!,
                      //           image: product.image!,
                      //           name: product.name!,
                      //         ),
                      //       ),
                      //     ),
                      //   );
                      // }
                    },
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
