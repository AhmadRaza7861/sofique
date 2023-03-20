//Code corrected by Ashwani on 14-04-2022, reviews were not properly synced

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sofiqe/controller/reviewController.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/wishlist_provider.dart';
import 'package:sofiqe/utils/api/product_details_api.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/widgets/cart/empty_bag.dart';

import '../../provider/cart_provider.dart';
import '../../utils/constants/route_names.dart';
import '../../widgets/capsule_button.dart';
import '../../widgets/product_detail/order_notification.dart';
import '../my_sofiqe.dart';
import '../product_detail_1_screen.dart';

class ReviewsMS6 extends StatefulWidget {
  const ReviewsMS6({Key? key}) : super(key: key);

  @override
  _ReviewsMS6State createState() => _ReviewsMS6State();
}

class _ReviewsMS6State extends State<ReviewsMS6> {
  PageProvider pp = Get.find();
  int selectedReview = 0;

  changeReview(int i) {
    setState(() {
      selectedReview = i;
    });
  }

 // ReviewController reviewController = Get.put(ReviewController());
  ReviewController reviewController = Get.find();
  final WishListProvider wp = Get.find();

  @override
  void initState() {
    // reviewController.getMyRiviewsData();
    // reviewController.getGloableReviews();
    // reviewController.getWishListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    var cartItems = Provider.of<CartProvider>(context).cart!.length;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: Get.height * 0.15,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/myReviews.png',
                        ),
                        fit: BoxFit.cover)),
                child: Stack(
                  alignment: Alignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            "sofiqe",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: AppBar().preferredSize.height * 0.5,
                                ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.cartScreen);
                          },
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: Get.width * 0.10,
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.white,
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/Path_6.png",
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              cartItems == 0
                                  ? SizedBox()
                                  : Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    cartItems.toString(),
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                      ],
                    ),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child:
                    // )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        changeReview(0);
                      },
                      child: IntrinsicWidth(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "MY REVIEWS",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            selectedReview == 0
                                ? Container(
                                    // width: 65.w,
                                    height: 2,
                                    color: Color(0xffF2CA8A),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        changeReview(1);
                      },
                      child: IntrinsicWidth(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "SOFIQE REVIEWS",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            selectedReview == 1
                                ? Container(
                                    //  width: 85.w,
                                    height: 2,
                                    color: Color(0xffF2CA8A),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        changeReview(2);
                      },
                      child: IntrinsicWidth(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "WISHLIST",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            selectedReview == 2
                                ? Container(
                                    // width: 50.w,
                                    height: 2,
                                    color: Color(0xffF2CA8A),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  child: Expanded(
                      child: selectedReview == 2
                          ? GetBuilder<ReviewController>(builder: (wshCntrl) {
                              return wshCntrl.isWishListLoading
                                  ? Container(
                                      height: Get.height * 0.5,
                                      width: Get.width,
                                      alignment: Alignment.center,
                                      child: SpinKitDoubleBounce(
                                        color: Color(0xffF2CA8A),
                                        size: 50.0,
                                      ),
                                    )
                                  : wshCntrl.wishlistModel != null ||
                                          wshCntrl.wishlistModel!.result!
                                                  .length >
                                              0
                                      ? Column(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: Get.width * 0.10,
                                              color: Colors.grey,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        'YOU ARE SAVVY! ${wshCntrl.wishlistModel!.result!.length} DIFFERENT MAKEUPS',
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20),
                                                    child: GestureDetector(
                                                      child: Icon(Icons.share,
                                                          color:
                                                              Colors.blueGrey),
                                                      onTap: () {
                                                        if (wshCntrl
                                                            .wishlistModel!
                                                            .result!
                                                            .isNotEmpty) {
                                                          showShareDialog(
                                                              context);
                                                        } else {
                                                          Get.showSnackbar(
                                                            GetSnackBar(
                                                              message:
                                                                  'No wishlist to share.',
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                              isDismissible:
                                                                  true,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: ListView.builder(
                                              itemCount: wshCntrl.wishlistModel!
                                                  .result!.length,
                                              shrinkWrap: true,
                                              physics:
                                                  AlwaysScrollableScrollPhysics(),
                                              itemBuilder: (ctx, i) {
                                                try {
                                                  wshCntrl.wishlistModel!
                                                      .result![i].review!
                                                      .forEach((element) {});
                                                } catch (e) {}
                                                return Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        height: 88,
                                                        width: double.infinity,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                // width: Get.width,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Text(
                                                                      "${wshCntrl.wishlistModel!.result![i].product!.name}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    // Row(
                                                                    //   children: [
                                                                    //     Icon(
                                                                    //       Icons
                                                                    //           .star,
                                                                    //       color: Color(
                                                                    //           0xffF2CA8A),
                                                                    //     ),
                                                                    //     SizedBox(
                                                                    //       width:
                                                                    //           5,
                                                                    //     ),
                                                                    //     Text(rate
                                                                    //         .toString())
                                                                    //   ],
                                                                    // )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              behavior:
                                                                  HitTestBehavior
                                                                      .translucent,
                                                              onTap: () async {
                                                                print(
                                                                    "USER MISSING??");
                                                                try {
                                                                  if (Provider.of<
                                                                              AccountProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isLoggedIn) {
                                                                    if (await wp.removeItemToWishList(wshCntrl
                                                                        .wishlistModel!
                                                                        .result![
                                                                            i]
                                                                        .product!
                                                                        .sku!)) {
                                                                      wshCntrl
                                                                          .wishlistModel!
                                                                          .result!
                                                                          .removeWhere((element) =>
                                                                              element.wishlistItemId ==
                                                                              wshCntrl.wishlistModel!.result![i].wishlistItemId!);
                                                                      await reviewController
                                                                          .getWishListData();
                                                                    } else {
                                                                      print(
                                                                          "UPDATE FAILED");
                                                                    }
                                                                  } else {
                                                                    print(
                                                                        "USER MISSING");
                                                                  }
                                                                } on Exception catch (e) {
                                                                  print(e
                                                                      .toString());
                                                                }
                                                              },
                                                              child: Container(
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              20),
                                                                  width:
                                                                      Get.width *
                                                                          0.020,
                                                                  // color: Colors.orange,
                                                                  child: Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .red,
                                                                  )),
                                                            ),
                                                            GestureDetector(
                                                              child: Icon(
                                                                  Icons.share,
                                                                  color: Colors
                                                                      .grey),
                                                              onTap: () {
                                                                Share.share(
                                                                    APIEndPoints
                                                                            .shareBaseUrl +
                                                                        wshCntrl
                                                                            .wishlistModel!
                                                                            .result![
                                                                                i]
                                                                            .product!
                                                                            .requestPath
                                                                            .toString(),
                                                                    subject: wshCntrl
                                                                        .wishlistModel!
                                                                        .result![
                                                                            i]
                                                                        .product!
                                                                        .name);
                                                              },
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (BuildContext
                                                                            c) {
                                                                      return ProductDetail1Screen(
                                                                          sku: wshCntrl
                                                                              .wishlistModel!
                                                                              .result![i]
                                                                              .product!
                                                                              .sku!);
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.18,
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              20),
                                                                  // color: Colors.green,
                                                                  child: Image
                                                                      .network(
                                                                    // 'assets/images/product.png',
                                                                    APIEndPoints
                                                                            .mediaBaseUrl +
                                                                        "${wshCntrl.wishlistModel!.result![i].product!.image}",
                                                                    width: 72,
                                                                    height: 72,
                                                                  )),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                // if (wshCntrl
                                                                //             .wishlistModel!
                                                                //             .result![
                                                                //                 i]
                                                                //             .product!
                                                                //             .options !=
                                                                //         null &&
                                                                //     wshCntrl
                                                                //         .wishlistModel!
                                                                //         .result![
                                                                //             i]
                                                                //         .product!
                                                                //         .options!
                                                                //         .isNotEmpty) {
                                                                //   Navigator.push(
                                                                //     context,
                                                                //     MaterialPageRoute(
                                                                //       builder:
                                                                //           (BuildContext
                                                                //               c) {
                                                                //         return ProductDetail1Screen(
                                                                //             sku: wshCntrl
                                                                //                 .wishlistModel!
                                                                //                 .result![i]
                                                                //                 .product!
                                                                //                 .sku!);
                                                                //       },
                                                                //     ),
                                                                //   );
                                                                // } else {
                                                                var res = await sfAPIGetProductDetailsFromSKU(
                                                                    sku: wshCntrl
                                                                        .wishlistModel!
                                                                        .result![
                                                                            i]
                                                                        .product!
                                                                        .sku!);
                                                                Map<String,
                                                                        dynamic>
                                                                    responseBody =
                                                                    json.decode(
                                                                        res.body);
                                                                print(responseBody[
                                                                    'type_id']);
                                                                String type =
                                                                    responseBody[
                                                                        'type_id'];
                                                                if (type ==
                                                                    "configurable") {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (BuildContext
                                                                              c) {
                                                                        return ProductDetail1Screen(
                                                                            sku:
                                                                                wshCntrl.wishlistModel!.result![i].product!.sku!);
                                                                      },
                                                                    ),
                                                                  );
                                                                } else {
                                                                  CartProvider
                                                                      cartP =
                                                                      Provider.of<
                                                                              CartProvider>(
                                                                          context,
                                                                          listen:
                                                                              false);
                                                                  //   print("CartProvider  -->> SSs ${cartP.cartToken}");
                                                                  await cartP.addToCart(
                                                                      context,
                                                                      wshCntrl
                                                                          .wishlistModel!
                                                                          .result![
                                                                              i]
                                                                          .product!
                                                                          .sku!,
                                                                      wshCntrl.wishlistModel!.result![i].product!.typeId ==
                                                                              'simple'
                                                                          ? []
                                                                          : wshCntrl
                                                                              .wishlistModel!
                                                                              .result![
                                                                                  i]
                                                                              .product!
                                                                              .options,
                                                                      wshCntrl.wishlistModel!.result![i].product!.typeId ==
                                                                              'simple'
                                                                          ? 0
                                                                          : 1,
                                                                      "");
                                                                  print(
                                                                      "Name  -->> EEE ${wshCntrl.wishlistModel!.result![i].product!.image}");

                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              0),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .black,
                                                                      duration: Duration(
                                                                          seconds:
                                                                              1),
                                                                      content:
                                                                          Container(
                                                                        child:
                                                                            CustomSnackBar(
                                                                          sku: wshCntrl
                                                                              .wishlistModel!
                                                                              .result![i]
                                                                              .product!
                                                                              .sku!,
                                                                          image: wshCntrl.wishlistModel!.result![i].product!.image!.replaceAll(
                                                                              RegExp('https://sofiqe.com/media/catalog/product'),
                                                                              // 'https://dev.sofiqe.com/media/catalog/product'),
                                                                              ''),
                                                                          name: wshCntrl
                                                                              .wishlistModel!
                                                                              .result![i]
                                                                              .product!
                                                                              .name!,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                  // }
                                                                  // reviewController
                                                                  //     .productAddtoBag(wshCntrl
                                                                  //         .wishlistModel!
                                                                  //         .result![i].product.shadeColor,wshCntrl
                                                                  //         .wishlistModel!
                                                                  //         .result![i].productId,wshCntrl
                                                                  //         .wishlistModel!
                                                                  //         .result![i].product.price.toString());
                                                                }
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20),
                                                                width:
                                                                    Get.width *
                                                                        0.16,
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 28,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  child: Center(
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/images/Path_6.png",
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(),
                                                    ],
                                                  ),
                                                );
                                              },
                                            )),
                                          ],
                                        )
                                      : CustomEmptyBagPage(
                                          title:
                                              'Oops we cannot find what your wish list is',
                                          ontap: () async {
                                            Navigator.of(context).pop();
                                          },
                                          emptyBagButtonText: 'Go TO SHOPPING',
                                        );
                            })
                          : (selectedReview == 0)
                              ? GetBuilder<ReviewController>(
                                  builder: (revContrl) {
                                  return Container(
                                      alignment: Alignment.center,
                                      child: (reviewController.isReviewLoading)
                                          ? Container(
                                              height: Get.height * 0.5,
                                              width: Get.width,
                                              alignment: Alignment.center,
                                              child: SpinKitDoubleBounce(
                                                color: Color(0xffF2CA8A),
                                                size: 50.0,
                                              ),
                                            )
                                          : reviewController.myReviewModel!
                                                      .items!.length >
                                                  0
                                              ? Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: Get.width * 0.10,
                                                      color: Colors.grey,
                                                      child: Center(
                                                        child: Text(
                                                          'YOU ARE SAVVY! ${reviewController.myReviewModel!.items!.length} DIFFERENT MAKEUPS',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: ListView.builder(
                                                            itemCount:
                                                                reviewController
                                                                    .myReviewModel!
                                                                    .items!
                                                                    .length,
                                                            shrinkWrap: true,
                                                            physics:
                                                                AlwaysScrollableScrollPhysics(),
                                                            itemBuilder:
                                                                (ctx, index1) {
                                                              return Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          88,
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Row(
                                                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                Get.width * 0.4,
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: Text(
                                                                                      reviewController.reviewName.isNotEmpty && reviewController.reviewName.length > index1 ? "${reviewController.reviewName[index1].name.toString()}" : '',
                                                                                      // "${reviewController.myReviewModel!.items![ii].title}",
                                                                                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                                                                                    )),
                                                                                Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.star,
                                                                                      color: Color(0xffF2CA8A),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 5,
                                                                                    ),
                                                                                    Text(reviewController.myReviewModel!.items![index1].ratings!.length.toString())
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            child:
                                                                                Icon(Icons.share, color: Colors.grey),
                                                                            onTap:
                                                                                () {
                                                                              Share.share(reviewController.myReviewModel!.items![index1].productUrl!, subject: reviewController.reviewName[index1].name.toString());
                                                                            },
                                                                          ),
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (BuildContext c) {
                                                                                      return ProductDetail1Screen(sku: reviewController.myReviewModel!.items![index1].sku!.toString());
                                                                                    },
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                  width: Get.width * 0.25,
                                                                                  child: reviewController.reviewName[index1].imagePath != ''
                                                                                      ? Image.network(
                                                                                          // 'assets/images/product.png',
                                                                                          APIEndPoints.mediaBaseUrl + "${reviewController.reviewName[index1].imagePath}",
                                                                                          width: 72,
                                                                                          height: 72,
                                                                                        )
                                                                                      : Image.network(
                                                                                          APIEndPoints.mediaBaseUrl + "null",
                                                                                          width: 72,
                                                                                          height: 72,
                                                                                        ))),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              var res = await sfAPIGetProductDetailsFromSKU(sku: reviewController.myReviewModel!.items![index1].sku!);
                                                                              Map<String, dynamic> responseBody = json.decode(res.body);
                                                                              print(responseBody['type_id']);
                                                                              String type = responseBody['type_id'];
                                                                              if (type == "configurable") {
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (BuildContext c) {
                                                                                      return ProductDetail1Screen(sku: reviewController.myReviewModel!.items![index1].sku!);
                                                                                    },
                                                                                  ),
                                                                                );
                                                                              } else {
                                                                                await Provider.of<CartProvider>(context, listen: false).addToCart(context, reviewController.myReviewModel!.items![index1].sku!, [], reviewController.reviewName[index1].typeId == 'simple' ? 0 : 1, "");
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                  padding: EdgeInsets.all(0),
                                                                                  backgroundColor: Colors.transparent,
                                                                                  duration: Duration(seconds: 1),
                                                                                  content: Container(
                                                                                    child: CustomSnackBar(
                                                                                      sku: reviewController.myReviewModel!.items![index1].sku!,
                                                                                      image: reviewController.reviewName[index1].imagePath.toString(),
                                                                                      name: reviewController.reviewName[index1].name!,
                                                                                    ),
                                                                                  ),
                                                                                ));
                                                                                // reviewController.productAddtoBag("NA",reviewController.myReviewModel!.items![ii].);
                                                                              }
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: Get.width * 0.2,
                                                                              //  color: Colors.red,
                                                                              child: CircleAvatar(
                                                                                radius: 30,
                                                                                backgroundColor: Colors.black,
                                                                                child: Center(
                                                                                  child: Image.asset(
                                                                                    "assets/images/Path_6.png",
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Divider(),
                                                                  ],
                                                                ),
                                                              );
                                                            })),
                                                  ],
                                                )
                                              : CustomEmptyBagPage(
                                                  title:
                                                      'Oops we are missing your reviews',
                                                  // title: 'Oops You have no reviews yet,\nwant to go to shopping? ',
                                                  ontap: () async {
                                                    //      profileController.screen.value = 0;
                                                    Get.back();
                                                    pp.goToPage(Pages.SHOP);
                                                  },
                                                  emptyBagButtonText:
                                                      'Go TO SHOPPING',
                                                ));
                                })
                              : GetBuilder<ReviewController>(
                                  builder: (revContrl) {
                                  return Container(
                                      alignment: Alignment.center,
                                      child: (reviewController.isGlobaleReviews)
                                          ? Container(
                                              height: Get.height * 0.5,
                                              width: Get.width,
                                              alignment: Alignment.center,
                                              child: SpinKitDoubleBounce(
                                                color: Color(0xffF2CA8A),
                                                size: 50.0,
                                              ),
                                            )
                                          : reviewController.reviewModel!.items!
                                                      .length >
                                                  0
                                              ?  Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: Get.width * 0.10,
                                            color: Colors.grey,
                                            child: Center(
                                              child: Text(
                                                'YOU ARE SAVVY! ${reviewController.reviewModel!.items!.length} DIFFERENT MAKEUPS',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: ListView.builder(
                                                  itemCount:
                                                  reviewController
                                                      .reviewModel!
                                                      .items!
                                                      .length,
                                                  shrinkWrap: true,
                                                  physics:
                                                  AlwaysScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (ctx, index2) {
                                                    return Container(
                                                      margin: EdgeInsets
                                                          .only(
                                                          left:
                                                          20),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height:
                                                            88,
                                                            width: double
                                                                .infinity,
                                                            child:
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: [
                                                                Container(
                                                                  width:
                                                                  Get.width * 0.4,
                                                                  child:
                                                                  Column(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Align(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: Text(
                                                                            reviewController.reviewGlobaleName.isNotEmpty && reviewController.reviewGlobaleName.length > index2 ? "${reviewController.reviewGlobaleName[index2].name}" : "",
                                                                            // "${reviewController.reviewModel!.items![ii].title}",
                                                                            style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                                                                          )),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.star,
                                                                            color: Color(0xffF2CA8A),
                                                                          ),
                                                                          SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(reviewController.reviewModel!.items![index2].ratings!.length.toString())
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  child:
                                                                  Icon(Icons.share, color: Colors.grey),
                                                                  onTap:
                                                                      () {
                                                                    Share.share(reviewController.reviewModel!.items![index2].productUrl!, subject: reviewController.reviewGlobaleName[index2].name.toString());
                                                                  },
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () {
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (BuildContext c) {
                                                                          return ProductDetail1Screen(sku: reviewController.reviewModel!.items![index2].sku!.toString());
                                                                        },
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                      width: Get.width * 0.25,
                                                                      child: reviewController.reviewGlobaleName[index2].imagePath != ''
                                                                          ? Image.network(
                                                                        // 'assets/images/product.png',
                                                                        APIEndPoints.mediaBaseUrl + "${reviewController.reviewGlobaleName[index2].imagePath}",
                                                                        width: 72,
                                                                        height: 72,
                                                                      )
                                                                          : Image.network(
                                                                        APIEndPoints.mediaBaseUrl + "null",
                                                                        width: 72,
                                                                        height: 72,
                                                                      )),
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    var res = await sfAPIGetProductDetailsFromSKU(sku: reviewController.reviewModel!.items![index2].sku!);
                                                                    Map<String, dynamic> responseBody = json.decode(res.body);
                                                                    print(responseBody['type_id']);
                                                                    String type = responseBody['type_id'];
                                                                    if (type == "configurable") {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (BuildContext c) {
                                                                            return ProductDetail1Screen(sku: reviewController.reviewModel!.items![index2].sku!);
                                                                          },
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      await Provider.of<CartProvider>(context, listen: false).addToCart(context, reviewController.reviewModel!.items![index2].sku!, [], reviewController.reviewGlobaleName[index2].typeId == 'simple' ? 0 : 1, "");
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                        padding: EdgeInsets.all(0),
                                                                        backgroundColor: Colors.transparent,
                                                                        duration: Duration(seconds: 1),
                                                                        content: Container(
                                                                          child: CustomSnackBar(
                                                                            sku: reviewController.reviewModel!.items![index2].sku!,
                                                                            image: reviewController.reviewGlobaleName[index2].imagePath.toString(),
                                                                            name: reviewController.reviewGlobaleName[index2].name!,
                                                                          ),
                                                                        ),
                                                                      ));
                                                                    }
                                                                  },
                                                                  child:
                                                                  Container(
                                                                    width: Get.width * 0.2,
                                                                    //  color: Colors.red,
                                                                    child: CircleAvatar(
                                                                      radius: 30,
                                                                      backgroundColor: Colors.black,
                                                                      child: Center(
                                                                        child: Image.asset(
                                                                          "assets/images/Path_6.png",
                                                                          color: Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(),
                                                        ],
                                                      ),
                                                    );
                                                  })),
                                        ],
                                      )

                                              : CustomEmptyBagPage(
                                                  title:
                                                      'Oops You have no reviews yet,\nwant to go to shopping? ',
                                                  ontap: () async {
                                                    //      profileController.screen.value = 0;
                                                    Get.back();
                                                    pp.goToPage(Pages.SHOP);
                                                  },
                                                  emptyBagButtonText:
                                                      'GO TO SHOPPING',
                                                ) /*Container(
                                                child: Center(
                                                  child: Text(
                                                      'Oops! INo Reviews Yet '),
                                                ),
                                              )*/

                                      //  CustomEmptyBagPage(
                                      //     title:
                                      //         'Hey! You have no reviews yet',
                                      //     ontap: () async {
                                      //       await Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //           builder:
                                      //               (BuildContext _) {
                                      //             return MakeOverLoginPrompt();
                                      //           },
                                      //         ),
                                      //       );
                                      //     },
                                      //     emptyBagButtonText:
                                      //         'JOIN SOFIQE FOR FREE',

                                      //   )

                                      );
                                }))),
            ],
          ),
        ),
      ),
    );
  }

  Future showShareDialog(BuildContext context) {
    String message = '';
    String mails = '';
    // Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: HexColor("#EB7AC1"),
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.all(10),
            content: Stack(
              children: <Widget>[
                Form(
                  child: Container(
                    height: 400,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          color: HexColor("#EB7AC1"),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.close,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                    child: Text(
                                  'SHARE WISHLIST',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                )),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: Column(
                            children: [
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    message = value.toString();
                                  });
                                },
                                controller: null,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  labelText:
                                      'Please write a message to your friend',
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    mails = value.toString();
                                  });
                                },
                                controller: null,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  labelText:
                                      'Add email, if more than one, please comma separate them',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CapsuleButton(
                            backgroundColor: Colors.white,
                            borderColor: Color(0xFF393636),
                            onPress: () async {
                              if (mails.isNotEmpty) {
                                await reviewController.shareWishlist(
                                    mails, message);
                                Navigator.pop(context);
                              } else {
                                Get.showSnackbar(
                                  GetSnackBar(
                                    message: 'Please enter required details.',
                                    duration: Duration(seconds: 2),
                                    isDismissible: true,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Share Wishlist',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}