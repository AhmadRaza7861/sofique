import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/currencyController.dart';
import 'package:sofiqe/model/product_model.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/api/product_details_api.dart';
import 'package:sofiqe/utils/states/function.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/product_detail/order_notification.dart';
import 'package:sofiqe/widgets/product_image.dart';

import '../provider/try_it_on_provider.dart';
import '../screens/product_detail_1_screen.dart';

class TryOnProduct extends StatelessWidget {
  final Product? product;
  final bool? isDetail;
  final dynamic selectShadeOption;
   TryOnProduct({
    Key? key,
    this.product, this.isDetail, this.selectShadeOption,
  }) : super(key: key);
  final TryItOnProvider tiop = Get.find<TryItOnProvider>();
  @override
  Widget build(BuildContext context) {
    if (product!.sku!.isEmpty) {
      return Container();
    }
    return
      GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext c) {
                  return ProductDetail1Screen(sku: product!.sku!);
                },
              ),
            );
          },
          child: Container(
            height: 97,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300] as Color),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemImage(
                  image: product!.image,
                ),
                ItemInformation(
                  areaName: product!.faceSubAreaName,
                  productName: tiop.directProduct.value.toString(),
                  price: product!.price!,
                  reward: product!.rewardsPoint,
                ),
                ColorSelector(
                  color:isDetail== true? selectShadeOption["extension_attributes"]["value_label"].toString():product!.color,
                ),
                AddToBagButton(
                  product: product!,
                ),
              ],
            ),
          ));
  }
}

class ItemImage extends StatelessWidget {
  final String image;

  ItemImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.height * 0.08,
      child: ProductImage(
        imageShortPath: image,
      ),
    );
  }
}

class ItemInformation extends StatelessWidget {
  final String areaName;
  final String productName;
  final String reward;
  final num price;

  ItemInformation(
      {Key? key,
      required this.areaName,
      required this.productName,
      required this.reward,
      required this.price})
      : super(key: key);
  final CurrencyController currencycntrl = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // width: size.width * 0.34,
      height: size.height * 0.09,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${areaName.toUpperCase()}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: 8,
                  letterSpacing: 0,
                ),
          ),
          Container(
            width: size.width * 0.25,
            child: Text(
              '$productName',
              // 'L\'Oreal Socket',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: 10,
                    letterSpacing: 0,
                  ),
            ),
          ),
          Text(
            currencycntrl.defaultCurrency.toString() +
                ' ' +
                price.toStringAsFixed(2),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.013,
                  letterSpacing: 0,
                ),
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Earn ' + reward,
                        // contrl.ms8model!
                        //     .lookRewardPoints
                        //     .toString(),
                        style: TextStyle(color: Colors.green, fontSize: 13)),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: PngIcon(
                          height: 12,
                          width: 12,
                          image: 'assets/images/goldencoin.png',
                        ),
                      ),
                    ),
                    TextSpan(
                        text: 'VIP points',
                        style: TextStyle(color: Colors.green, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ColorSelector extends StatelessWidget {
  // final int code;
  final String color;

  ColorSelector({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        // Container(
        //   height: size.height * 0.08,
        //   child: Icon(Icons.arrow_left),
        // ),
        GestureDetector(
          onTap: () {
            print("COLOR ${color.toColor()}");
          },
          child: Container(
            height: size.height * 0.06,
            width: size.width * 0.16,
            decoration: BoxDecoration(
              // show selected color from product details screen
              color: color.toColor(),

              border: Border.all(
                color: Color(0XFF707070),
              ),
            ),
          ),
        ),
        // Container(
        //   height: size.height * 0.08,
        //   child: Icon(Icons.arrow_right),
        // ),
      ],
    );
  }
}

class AddToBagButton extends StatelessWidget {
  final Product product;

  AddToBagButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.height * 0.08,
      child: GestureDetector(

        onTap: () async {
          print("object");
          var res = await sfAPIGetProductDetailsFromSKU(sku: product.sku!);
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
            await cartP.addHomeProductsToCart(context, product);
            print("Name  -->> EEE ${product.image}");

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
            // if(product.options != null && product.options!.isNotEmpty){
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (BuildContext c) {
            //         return ProductDetail1Screen(sku: product.sku!);
            //       },
            //     ),
            //   );
            // }else{
            //   CartProvider cartP =
            //   Provider.of<CartProvider>(context, listen: false);

            //   await cartP.addHomeProductsToCart(context, Product(
            //         id: product.id,
            //         name: product.name,
            //         sku: product.sku,
            //         price: product.price!,
            //         image: product.image,
            //         description: product.description,
            //         faceSubArea: product.faceSubArea,
            //         avgRating: product.avgRating));
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       padding: EdgeInsets.all(0),
            //       backgroundColor: Colors.transparent,
            //       duration: Duration(seconds: 1),
            //       content: Container(
            //         child: CustomSnackBar(
            //           sku: product.sku!,
            //           image: product.image,
            //           name: product.name!,
            //         ),
            //       ),
            //     ),
            //   );
            // }
          }
        },
        child: Container(
          height: AppBar().preferredSize.height * 0.7,
          width: AppBar().preferredSize.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
                Radius.circular(AppBar().preferredSize.height * 0.7)),
          ),
          child: PngIcon(
            height: AppBar().preferredSize.height * 0.3,
            width: AppBar().preferredSize.height * 0.3,
            image: 'assets/icons/add_to_cart_white.png',
          ),
        ),
      ),
    );
  }
}
