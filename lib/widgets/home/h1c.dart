import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sofiqe/controller/currencyController.dart';
import 'package:sofiqe/model/data_ready_status_enum.dart';
import 'package:sofiqe/model/product_model.dart';
import 'package:sofiqe/model/product_model_best_seller.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/provider/home_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/evaluate_screen.dart';
import 'package:sofiqe/screens/product_detail_1_screen.dart';
import 'package:sofiqe/screens/try_it_on_screen.dart';
import 'package:sofiqe/utils/api/product_details_api.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/utils/states/function.dart';
import 'package:sofiqe/widgets/capsule_button.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/product_detail/order_notification.dart';
import 'package:sofiqe/widgets/product_error_image.dart';
import 'package:sofiqe/widgets/wishlist.dart';

class H1C extends StatelessWidget {
  H1C({Key? key}) : super(key: key);

  final HomeProvider hp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/home_h1c_background.png',
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'BESTSELLERS',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.015,
                ),
          ),
          Container(
            width: size.width * 0.7,
            child: Text(
              'PRODUCTS THAT ARE LOVED BY SOFIQERS',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.024,
                    height: 1,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          Obx(
            () {
              if (hp.bestSellerListStatus.value == DataReadyStatus.COMPLETED) {
                return (hp.bestSellerListt.isEmpty)
                    ? BestSellerError()
                    :BestSellerItems();
              } else if (hp.bestSellerListStatus.value ==
                      DataReadyStatus.FETCHING ||
                  hp.bestSellerListStatus.value == DataReadyStatus.INACTIVE) {
                return BestSellerBuffering();
              } else if (hp.bestSellerListStatus.value ==
                  DataReadyStatus.ERROR) {
                return BestSellerError();
              } else {
                return BestSellerError();
              }
            },
          ),
        ],
      ),
    );
  }
}

class BestSellerItems extends StatelessWidget {
  BestSellerItems({Key? key}) : super(key: key);

  final HomeProvider hp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int index = 0;
    if (hp.bestSellerListt.isEmpty) {
      return BestSellerError();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: size.height * 0.70,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Row(
          children: hp.bestSellerListt.map<GestureDetector>(
            (Product1 p) {
              int i = index++;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext c) {
                        return ProductDetail1Screen(sku: p.sku!);
                      },
                    ),
                  );
                },
                child: _BestsellerCard(
                  index: i,
                  total: hp.bestSellerListt.length,
                  product: p,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

// class BestSellerItem extends StatelessWidget {
//   final int index;
//   final int total;
//   final Product1 product;
//    BestSellerItem({
//     Key? key,
//     required this.index,
//     required this.total,
//     required this.product,
//   }) : super(key: key);

//   CurrencyController Currencycntrl = Get.put(CurrencyController());

//   Future<void> share(prodUrl, title) async {
//     await FlutterShare.share(
//         title: title, text: title, linkUrl: prodUrl, chooserTitle: 'Share');
//   }
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double topLeft = 0;
//     double bottomLeft = 0;
//     double topRight = 0;
//     double bottomRight = 0;
//     if (index == 0) {
//       topLeft = 10;
//       bottomLeft = 10;
//     }
//     if (index == total - 1) {
//       topRight = 10;
//       bottomRight = 10;
//     }
//     return Container(
//       width: size.width * 0.9,
//       margin: EdgeInsets.symmetric(horizontal: size.width * 0.005),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(topLeft),
//           bottomLeft: Radius.circular(bottomLeft),
//           topRight: Radius.circular(topRight),
//           bottomRight: Radius.circular(bottomRight),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//                 Container(
//                                             margin: EdgeInsets.only(left: 20),
//                                             child: Stack(
//                                               children: [
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 4.0),
//                                                   child: WishList(
//                                                       sku: product.sku!,
//                                                       itemId:
//                                                           product.id!),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                                     Container(margin: EdgeInsets.only(right: 20),
//                                             child: InkWell(
//                                               onTap: () {
//                                                 // share(product.productURL,
//                                                 //     product.name);
//                                               },
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 8.0),
//                                                 child: Icon(Icons.share,
//                                                     color: Colors.grey,
//                                                     size: 20.0),
//                                               ),
//                                             ),
//                                           ),

//           ],),
//           Image.network(
//             '${product.image}',
//             width: size.width * 0.45,
//             height: size.width * 0.45,
//             errorBuilder: (BuildContext c, Object o, StackTrace? s) {
//               return ProductErrorImage(
//                 width: size.width * 0.45,
//                 height: size.width * 0.45,
//               );
//             },
//           ),
//           // Container(
//           //   width: size.width * 0.6,
//           //   child: Text(
//           //     '${product.faceSubAreaName.capitalizeFirst}',
//           //     textAlign: TextAlign.center,
//           //     style: Theme.of(context).textTheme.headline2!.copyWith(
//           //           color: Colors.black,
//           //           fontSize: size.height * 0.015,
//           //         ),
//           //   ),
//           // ),
//           Container(
//             width: size.width * 0.6,
//             height: size.height * 0.05,
//             child: Text(
//               '${product.name}',
//               textAlign: TextAlign.center,
//               softWrap: true,
//               style: Theme.of(context).textTheme.headline2!.copyWith(
//                     color: Colors.black,
//                     fontSize: size.height * 0.02,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//             Row(children: [
//                     Expanded(flex: 1, child: Container()),
//                               Expanded(flex: 7, child: GestureDetector(
//               onTap: () {
//                 Get.to(() => EvaluateScreen(product.image, product.sku, product.name));
//               },
//               child: Row(
//                 mainAxisAlignment:
//                 MainAxisAlignment.center,
//                 children: [
//                   SizedBox(width: 50,),
//                   RatingBar.builder(
//                     ignoreGestures: true,
//                     itemSize: 18,
//                     initialRating: double.parse(product.avgrating!),
//                         // product.avgRating),
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemPadding: EdgeInsets.symmetric(
//                         horizontal: 0.0,),
//                     itemBuilder: (context, _) => Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) {
//                     },
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     product.avgrating
//                         .toString(),

//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 10),
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     '(${product.review_count.toString()})',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 10,
//                     ),
//                   ),
//                 ],
//               ),
//           ))]),
//           SizedBox(height: 5,),
//           Row(children: [
//                     Expanded(flex: 1, child: Container()),
// Expanded(flex: 4, child:  Row(children: [
//           Container(
//             width: size.width * 0.6,
//             child: Text(
//               " "+Currencycntrl.defaultCurrency!+' '+product.price.toString(),
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.headline2!.copyWith(
//                     color: Colors.black,
//                     fontSize: size.height * 0.020,
//                   ),
//             ),
//           )]))]),
//           SizedBox(height: 5,),

//                   Row(children: [
//                     Expanded(flex: 1, child: Container()),
//                       Expanded(flex: 5, child:  Container(
//               padding: EdgeInsets.symmetric(horizontal: size.width * 0.0),
//               child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                 children: [

//                   Padding(
//                   padding: const EdgeInsets.only(top: 3.0),
//                   child: Text(
//                     'Earn '+product.reward_points.toString()+" ",
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline2!
//                         .copyWith(
//                       color:
//                       SplashScreenPageColors
//                           .earnColor,
//                       fontSize: 10.0,
//                     ),
//                   ),
//                 ),
//                   Container(
//                     width: 10.0,
//                     child: Image.asset(
//                       "assets/images/coin.png",
//                     ),
//                   ),
//                   Text(
//                     // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
//                     ' VIP points',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline2!
//                         .copyWith(
//                       color:
//                       SplashScreenPageColors
//                           .earnColor,
//                       fontSize: 10.0,
//                     ),
//                   )]
//                 ,
//               ),
//             )),
//                   ],)
//           ]),
//           // Container(
//           //   width: size.width * 0.6,
//           //   height: size.height * 0.04,
//           //   child: Text(
//           //     '${product.description}',
//           //     textAlign: TextAlign.center,
//           //     style: Theme.of(context).textTheme.headline2!.copyWith(
//           //           color: Colors.black,
//           //           fontSize: size.height * 0.0165,
//           //         ),
//           //   ),
//           // ),
//           Row(
//             children: [
//               SizedBox(width: size.width * 0.05),
//               Expanded(
//                 child: _TryOnButtonnn(
//                   product1: product,
//                 ),
//               ),
//               SizedBox(width: size.width * 0.05),
//               Expanded(
//                 child: _AddToBagButton(
//                   onPress: () async {
//                         var res= await sfAPIGetProductDetailsFromSKU(sku: product.sku!);
//                          Map<String, dynamic> responseBody = json.decode(res.body);
// print(responseBody['type_id']);
//   String type =  responseBody['type_id'];
//                     if( type == "configurable"){

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (BuildContext c) {
//                             return ProductDetail1Screen(sku: product.sku!);
//                           },
//                         ),
//                       );
//                     }else{
//                     // if(product.options != null && product.options!.isNotEmpty){
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //       builder: (BuildContext c) {
//                     //         return ProductDetail1Screen(sku: product.sku!);
//                     //       },
//                     //     ),
//                     //   );
//                     // }else {
//                       CartProvider cartP = Provider.of<CartProvider>(context, listen: false);
//                       await cartP.addHomeProductsToCartt(context, product);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           padding: EdgeInsets.all(0),
//                           backgroundColor: Colors.black,
//                           duration: Duration(seconds: 1),
//                           content: Container(
//                             child: CustomSnackBar(
//                               sku: product.sku!,
//                               image: product.image.replaceAll(
//                                   RegExp(
//                                       'https://sofiqe.com/media/catalog/product'),
//                                       // 'https://dev.sofiqe.com/media/catalog/product'),
//                                   ''),
//                               name: product.name!,
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(width: size.width * 0.05),
//             ],
//           ),
//           SizedBox(height: size.height * 0.03),
//         ],
//       ),
//     );
//   }
// }

// class _TryOnButton extends StatelessWidget {
//   final Product product;
//   _TryOnButton({
//     Key? key,
//     required this.product,
//   }) : super(key: key);

//   final TryItOnProvider tiop = Get.find();
//   final PageProvider pp = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       child: CapsuleButton(
//         height: size.height * 0.06,
//         backgroundColor: Color(0xFFF2CA8A),
//         onPress: () {
//           tiop.received.value = product;
//           tiop.page.value = 2;
//           tiop.directProduct.value = true;
//           pp.goToPage(Pages.TRYITON);
//         },
//         child: Text(
//           'TRY ON',
//           style: Theme.of(context).textTheme.headline2!.copyWith(
//                 color: Colors.black,
//                 fontSize: size.width * 0.024,
//               ),
//         ),
//       ),
//     );
//   }
// }

// class _TryOnButtonnn extends StatelessWidget {
//   final Product1 product1;
//   _TryOnButtonnn({
//     Key? key,
//     required this.product1,
//   }) : super(key: key);

//   final TryItOnProvider tiop = Get.find();
//   final PageProvider pp = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       child: CapsuleButton(
//         height: size.height * 0.06,
//         backgroundColor: Color(0xFFF2CA8A),
//         onPress: () {
//           var data = Product(id: product1.id, name: product1.name, sku: product1.sku, price: product1.price, image: product1.image, description: "", faceSubArea: 0, avgRating: "0");
//           tiop.received.value = data;
//           tiop.page.value = 2;
//           tiop.directProduct.value = true;
//             pp.goToPage(Pages.TRYITON);
//         },
//         child: Text(
//           'TRY ON',
//           style: Theme.of(context).textTheme.headline2!.copyWith(
//             color: Colors.black,
//             fontSize: size.width * 0.024,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _AddToBagButton extends StatelessWidget {
//   final void Function() onPress;
//   const _AddToBagButton({
//     Key? key,
//     required this.onPress,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       child: CapsuleButton(
//         height: size.height * 0.06,
//         onPress: onPress,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             PngIcon(
//               image: 'assets/icons/add_to_cart_white.png',
//               width: size.width * 0.03,
//             ),
//             Text(
//               'ADD TO BAG',
//               style: Theme.of(context).textTheme.headline2!.copyWith(
//                     color: Colors.white,
//                     fontSize: size.width * 0.024,
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _BestsellerCard extends StatelessWidget {
  final num index;
  final num total;
  final Product1 product;
  _BestsellerCard({
    Key? key,
    required this.index,
    required this.total,
    required this.product,
  }) : super(key: key);

  final HomeProvider hp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double topLeft = 10;
    double bottomLeft = 0;
    double topRight = 10;
    double bottomRight = 0;
    if (index == 0) {
      topLeft = 10;
      bottomLeft = 10;
    }
    if (index == total - 1) {
      topRight = 10;
      bottomRight = 10;
    }
    return Container(
      width: size.width * 0.85,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.025),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          bottomLeft: Radius.circular(bottomLeft),
          topRight: Radius.circular(topRight),
          bottomRight: Radius.circular(bottomRight),
        ),
        image: DecorationImage(
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
          image: AssetImage(
            'assets/images/offer_of_day_background_image.png',
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x15000029),
            // color: Colors.red,
            blurRadius: 4,
            spreadRadius: 1.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: _BestsellerDetails(
              product: product,
            ),
          )
        ],
      ),
    );
  }
}

class _BestsellerDetails extends StatelessWidget {
  final Product1 product;
  _BestsellerDetails({
    Key? key,
    required this.product,
  }) : super(key: key);
  final CurrencyController currencycntrl = Get.put(CurrencyController());

  Future<void> share(prodUrl, title) async {
    await FlutterShare.share(
        title: title, text: title, linkUrl: prodUrl, chooserTitle: 'Share');
  }

  final TryItOnProvider tiop = Get.find();
  final PageProvider pp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: size.width * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.network(
                      '${product.image}',
                      width: 100,
                      height: 100,
                      errorBuilder: (BuildContext c, Object o, StackTrace? st) {
                        return ProductErrorImage(width: 100, height: 100);
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: WishList(
                                sku: product.sku!, itemId: product.id!),
                          ),
                        ],
                      ),
                    ),
                  ]),
              SizedBox(height: size.height * 0.014),
              Text(
                'BEST SELLERS',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: size.height * 0.015,
                      letterSpacing: 0,
                    ),
              ),
              SizedBox(height: size.height * 0.01),
            ],
          ),
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  '${product.name}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                )),
                Container(
                  child: InkWell(
                    onTap: () {
                      share(product.productUrl, product.name);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.share, color: Colors.grey, size: 20.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() =>
                    EvaluateScreen(product.image, product.sku, product.name));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    ignoreGestures: true,
                    itemSize: 18,
                    initialRating: double.parse(product.avgrating!),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(
                      horizontal: 0.0,
                    ),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(width: 10),
                  Text(
                    product.avgrating != null
                        ? product.avgrating.toString()
                        : '0',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '(${product.reviewCount.toString()})',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.price != null
                      ?
                      // currencycntrl.defaultCurrency! +
                      //     "" +
                      product.price!.toString().toProperCurrency()
                      :
                      // currencycntrl.defaultCurrency! +
                      // "" +
                      product.price!.toString().toProperCurrency(),
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Color.fromARGB(255, 2, 2, 2),
                        fontSize: size.height * 0.025,
                      ),
                ),
                // SizedBox(height: size.height * 0.01),
                if(product.discountedPrice!=0.0)
                Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      '${
                      // currencycntrl.defaultCurrency! + "" +
                          product.discountedPrice!.toString().toProperCurrency()}',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.red[400],
                            fontSize: size.height * 0.015,
                            decoration: TextDecoration.lineThrough,
                          ),
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                      'Earn ' + product.rewardPoints!,
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
          ]),
          SizedBox(height: size.height * 0.01),
          Container(
            height: size.height * 0.07,
            child: Text(
              '${product.description}',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.018,
                    letterSpacing: 0,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: CapsuleButton(
                  backgroundColor: Color(0xFFF2CA8A),
                  height: size.height * 0.07,
                  onPress: () {
                    var data = Product(
                      id: product.id,
                      name: product.name,
                      sku: product.sku,
                      price: product.price,
                      color: product.color,
                      image: product.image,
                      description: "",
                      faceSubArea: 0,
                      avgRating: "0",
                      rewardsPoint: product.rewardPoints!,
                    );
                    tiop.received.value = data;
                    tiop.page.value = 2;
                    tiop.directProduct.value = true;
                    tiop.lookProduct.value = false;
                    tiop.currentSelectedProducturl.value = product.productUrl!;
                    tiop.currentSelectedProductname.value = product.name!;
                    Get.to(() => TryItOnScreen());
                  },
                  child: Text(
                    'TRY ON',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.black,
                          fontSize: size.height * 0.014,
                        ),
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.05),
              Flexible(
                flex: 1,
                child: CapsuleButton(
                  height: size.height * 0.07,
                  horizontalPadding: 0,
                  onPress: () async {
                    var res =
                        await sfAPIGetProductDetailsFromSKU(sku: product.sku!);
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
                      // if(product.options != null && product.options!.isNotEmpty){
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (BuildContext c) {
                      //         return ProductDetail1Screen(sku: product.sku!);
                      //       },
                      //     ),
                      //   );
                      // }else {
                      CartProvider cartP =
                          Provider.of<CartProvider>(context, listen: false);
                      await cartP.addHomeProductsToCartt(context, product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          padding: EdgeInsets.all(0),
                          backgroundColor: Colors.black,
                          duration: Duration(seconds: 1),
                          content: Container(
                            child: CustomSnackBar(
                              sku: product.sku!,
                              image: product.image.replaceAll(
                                  RegExp(
                                      'https://sofiqe.com/media/catalog/product'),
                                  // 'https://dev.sofiqe.com/media/catalog/product'),
                                  ''),
                              name: product.name!,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PngIcon(
                        image: 'assets/icons/add_to_cart_white.png',
                        height: size.height * 0.015,
                        width: size.height * 0.02,
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text(
                        'ADD TO BAG',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.white,
                              fontSize: size.height * 0.014,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}

class BestSellerBuffering extends StatelessWidget {
  const BestSellerBuffering({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.65,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 20,
                    width: 180,
                    decoration: const BoxDecoration(color: Colors.grey),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 20,
                width: 200,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 20,
                width: 150,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                        5,
                        (index) => Container(
                              margin: EdgeInsets.only(right: 6),
                              height: 20,
                              width: 20,
                              child: Icon(Icons.star),
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 20,
                    width: 180,
                    decoration: const BoxDecoration(color: Colors.grey),
                  ),
                  Container(
                    height: 10,
                    width: 30,
                    decoration: const BoxDecoration(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 10,
                width: 80,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 15,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 15,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 15,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
              ),

              // Text(
              //   'Loading deal of the day near you!',
              //   style: Theme.of(context).textTheme.headline2!.copyWith(
              //         color: Colors.black,
              //         fontSize: size.height * 0.025,
              //       ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class BestSellerError extends StatelessWidget {
  const BestSellerError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.65,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '"Oops, looks like the best selling products are not available right now..."',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.025,
                ),
          ),
        ),
      ),
    );
  }
}
