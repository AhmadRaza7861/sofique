// ignore_for_file: unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sofiqe/controller/currencyController.dart';
import 'package:sofiqe/model/data_ready_status_enum.dart';
import 'package:sofiqe/model/product_model.dart';
import 'package:sofiqe/provider/account_provider.dart';
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

class H1A extends StatelessWidget {
  H1A({Key? key}) : super(key: key);

  final HomeProvider hp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.028),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //_Greetings(),
          SizedBox(height: size.height * 0.02),
          Expanded(
            child: Obx(
              () {
                if (hp.dealOfTheDayStatus.value == DataReadyStatus.COMPLETED) {
                  return (hp.dealOfTheDayList.isEmpty)
                      ? DealOfTheDayError()
                      : DealOfTheDayItems();
                } else if (hp.dealOfTheDayStatus.value ==
                        DataReadyStatus.FETCHING ||
                    hp.dealOfTheDayStatus.value == DataReadyStatus.INACTIVE) {
                  return DealOfTheDayBuffering();
                } else if (hp.dealOfTheDayStatus.value ==
                    DataReadyStatus.ERROR) {
                  return DealOfTheDayError();
                } else {
                  return DealOfTheDayError();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Greetings extends StatelessWidget {
  const _Greetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dayDate = '';
    String timeOfDayGreetings = '';
    String name = '';
    Size size = MediaQuery.of(context).size;

    DateTime date = DateTime.now();

    dayDate = DateFormat('EEEE d MMMM').format(date);

    int hour = date.hour;
    if (hour > 18) {
      timeOfDayGreetings = 'Good Evening';
    } else if (hour > 12) {
      timeOfDayGreetings = 'Good Afternoon';
    } else if (hour > 6) {
      timeOfDayGreetings = 'Good Morning';
    } else if (hour >= 0) {
      timeOfDayGreetings = 'Good Night';
    }

    if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
      name =
          ', ${Provider.of<AccountProvider>(context, listen: false).user!.firstName}';
    }

    return Container(
      child: Column(
        children: [
          Text(
            '$dayDate',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.016,
                  letterSpacing: 0,
                ),
          ),
          Text(
            '$timeOfDayGreetings$name',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.019,
                  letterSpacing: 1.2,
                ),
          ),
        ],
      ),
    );
  }
}

class DealOfTheDayItems extends StatelessWidget {
  DealOfTheDayItems({Key? key}) : super(key: key);

  final HomeProvider hp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int index = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.01),
        child: Row(
          children: hp.dealOfTheDayList.map<GestureDetector>(
            (Product p) {
              int i = index++;
              return GestureDetector(
                onTap: () {
                  // print(p.);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext c) {
                        return ProductDetail1Screen(sku: p.sku!);
                      },
                    ),
                  );
                },
                child: _OfferOfTheDayCard(
                  index: i,
                  total: hp.bestSellerList.length,
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

class _OfferOfTheDayCard extends StatelessWidget {
  final num index;
  final num total;
  final Product product;
  _OfferOfTheDayCard({
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
            child: _OfferDetails(
              product: product,
            ),
          )
        ],
      ),
    );
  }
}

class _OfferDetails extends StatelessWidget {
  final Product product;
  _OfferDetails({
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.12),
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
                        child: WishList(sku: product.sku!, itemId: product.id!),
                      ),
                    ],
                  ),
                ),
              ]),
          SizedBox(height: size.height * 0.014),
          Text(
            'DEAL OF THE DAY',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.015,
                  letterSpacing: 0,
                ),
          ),
          SizedBox(height: size.height * 0.01),
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
                    print(product.productURL);
                    // share(product.productURL, product.name);
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
                  initialRating: double.parse(product.avgRating),
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
                  product.avgRating != "null"
                      ? product.avgRating.toString()
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
                product.discountedPrice != null
                    ? '${product.discountedPrice!.toString().toProperCurrency()}'
                    : '${product.price!.toString().toProperCurrency()}',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Color.fromARGB(255, 2, 2, 2),
                      fontSize: size.height * 0.025,
                    ),
              ),
              // SizedBox(height: size.height * 0.01),
              Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text(
                    '${product.price!.toString().toProperCurrency()}',
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
                    'Earn ' + product.rewardsPoint,
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
          SizedBox(height: size.height * 0.04),
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
          SizedBox(height: size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: CapsuleButton(
                  backgroundColor: Color(0xFFF2CA8A),
                  height: size.height * 0.07,
                  onPress: () {
                    tiop.received.value = product;
                    tiop.page.value = 2;
                    tiop.directProduct.value = true;
                    tiop.lookProduct.value = false;
                    tiop.currentSelectedProducturl.value = product.productURL;
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
        ],
      ),
    );
  }
}

class DealOfTheDayBuffering extends StatelessWidget {
  const DealOfTheDayBuffering({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double topLeft = 10;
    double bottomLeft = 10;
    double topRight = 10;
    double bottomRight = 10;

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

class DealOfTheDayError extends StatelessWidget {
  const DealOfTheDayError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double topLeft = 10;
    double bottomLeft = 10;
    double topRight = 10;
    double bottomRight = 10;

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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Looks like no deal is available near you...',
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
