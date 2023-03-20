import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/currencyController.dart';
import 'package:sofiqe/controller/ms8Controller.dart';
import 'package:sofiqe/model/lookms3model.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/MS8/looks_option.dart';
import 'package:sofiqe/screens/evaluate_screen.dart';
import 'package:sofiqe/screens/my_sofiqe.dart';
import 'package:sofiqe/screens/try_it_on_screen.dart';
import 'package:sofiqe/utils/api/product_details_api.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/utils/constants/route_names.dart';
import 'package:sofiqe/utils/states/function.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/product_detail/order_notification.dart';
import 'package:sofiqe/widgets/product_detail/static_details.dart';
import 'package:sofiqe/widgets/wishlist.dart';

import '../premium_subscription_screen.dart';

class LookPackageMS8 extends StatefulWidget {
  final String? image;
  final String? look;
  final String? sku;
  final int? id;
  final Item? item;
  final List? looklist;

  const LookPackageMS8(
      {Key? key,
      this.image,
      this.look,
      this.sku,
      this.id,
      this.item,
      this.looklist})
      : super(key: key);

  @override
  _LookPackageMS8State createState() => _LookPackageMS8State();
}

class _LookPackageMS8State extends State<LookPackageMS8> {
  bool expanded = false;
  Ms8Controller controller = Get.put(Ms8Controller());
  CurrencyController currencycntrl = Get.put(CurrencyController());

// <<<<<<< HEAD
  final TryItOnProvider tiop = Get.find();

// =======
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5

  @override
  void initState() {
    controller.getLookList(widget.item!.name!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// <<<<<<< HEAD
//     var cartItems = Provider.of<CartProvider>(context).cart!.length;
// =======
    var cartItems = Provider.of<CartProvider>(context).itemCount;
    var cartTotalQty = Provider.of<CartProvider>(context).getTotalQty();
    // print("carttotalQty looks_packge)details ::$cartTotalQty");
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
    Size size = MediaQuery.of(context).size;

    Future<void> share(prodUrl, title) async {
      await FlutterShare.share(
          title: title, text: title, linkUrl: prodUrl, chooserTitle: 'Share');
    }

    void openDialog() {
      Navigator.of(context).push(new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return new LearnMoreDialog();
          },
          fullscreenDialog: true));
    }

    Widget options(Ms8Controller cntrl) {
      return Column(
        children: cntrl.ms8model!.itemData!
            .map((item) => LooksOption(
                  data: item,
                ))
            .toList(),
      );
    }

    stockupdate(Ms8Controller cntrl) {
      bool? stock;
      cntrl.ms8model!.itemData!.forEach((element) {
        element.quantityAndStockStatus!.isInStock == "true"
            ? stock = true
            : stock = false;
      });

      if (stock == true)
        return "IN STOCK";
      else
        return "OUT OF STOCK";
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.08),
        child: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          leading: Container(
            // width: size.width * 0.20,
            // height: size.width * 0.20,
            //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: BackButtonApp(
              flowFromMs: false,
              child: Transform.rotate(
                angle: 3.1439,
                child: PngIcon(
                  color: Colors.white,
                  image: 'assets/icons/arrow-2-white.png',
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'sofiqe',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.035,
                    letterSpacing: 0.6),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Text(
                'LOOKS',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
          actions: [
            Container(
              // height: AppBar().preferredSize.height,
              // width: AppBar().preferredSize.height * 1,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.cartScreen);
                  },
                  child: Container(
                    height: AppBar().preferredSize.height * 0.7,
                    width: AppBar().preferredSize.height * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppBar().preferredSize.height * 0.7)),
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        PngIcon(
                          image: 'assets/images/Path_6.png',
                        ),
                        cartItems == 0
                            ? SizedBox()
                            : Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                padding: EdgeInsets.all(5),
                                child: Text(cartTotalQty.toString()))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // Container(
        //   width: double.infinity,
        //   height: 80,
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   color: Colors.black,
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       IconButton(
        //         onPressed: () {
        //           Get.back();
        //         },
        //         icon: Icon(
        //           Icons.clear,
        //           color: Colors.white,
        //         ),
        //       ),
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           Text(
        //             "sofiqe",
        //             style: TextStyle(color: Colors.white, fontSize: 25),
        //           ),
        //           Text(
        //             "LOOKS",
        //             style: TextStyle(color: Colors.white, fontSize: 12),
        //           ),
        //         ],
        //       ),
        //       Container(
        //         child: Center(
        //           child: GestureDetector(
        //             onTap: () {
        //               Navigator.pushNamed(context, RouteNames.cartScreen);
        //             },
        //             child: Container(
        //               height: AppBar().preferredSize.height * 0.7,
        //               width: AppBar().preferredSize.height * 0.7,
        //               decoration: BoxDecoration(
        //                 color: Colors.white,
        //                 borderRadius: BorderRadius.all(Radius.circular(
        //                     AppBar().preferredSize.height * 0.7)),
        //               ),
        //               child: Stack(
        //                 alignment: Alignment.topRight,
        //                 children: [
        //                   PngIcon(
        //                     image: 'assets/images/Path_6.png',
        //                   ),
        //                   cartItems == 0
        //                       ? SizedBox()
        //                       : Container(
        //                           decoration: BoxDecoration(
        //                               shape: BoxShape.circle,
        //                               color: Colors.red),
        //                           padding: EdgeInsets.all(5),
        //                           child: Text(cartTotalQty.toString()))
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Expanded(
          child: GetBuilder<Ms8Controller>(builder: (contrl) {
            return (contrl.isLookLoading)
                ? Container(
                    height: Get.height,
                    width: Get.width,
                    child: Center(
                      child: SpinKitDoubleBounce(
                        color: Color(0xffF2CA8A),
                        size: 50.0,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      getContainerWidget(size),
                      contrl.ms8model == null
                          ? Expanded(
                              child: Center(
                                  child: Text(
                                'The product you requested is not found.',
                                style: TextStyle(color: Colors.white),
                              )),
                            )
                          : Expanded(
                              child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 308,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 35),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                              widget.item!.imageUrl!,
                                              // AssetImage('assets/images/mysofiqe.png')
                                              //     as ImageProvider

                                              // contrl.ms8model!.lookImage != null
                                              // NetworkImage(APIEndPoints.mediaBaseUrl +
                                              //         "${contrl.ms8model!.lookImage!}"
                                              //'assets/images/mysofiqe.png'
                                            )
                                            //     : AssetImage('assets/images/mysofiqe.png')
                                            //         as ImageProvider,
                                            //  fit: BoxFit.fill

                                            )),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            widget.item!.name! //"BOMBSHELL"
                                            ,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                                                      ' WISHLIST',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2!
                                                          .copyWith(
                                                            color:
                                                                SplashScreenPageColors
                                                                    .textColor,
                                                            fontSize: 7.0,
                                                          ),
                                                    ),
                                                    WishListNew(
                                                      sku: widget.item!.sku
                                                          .toString(),
                                                      itemId: int.parse(widget
                                                          .item!.entityId
                                                          .toString()),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  child: InkWell(
                                                    onTap: () {
                                                      share(
                                                          widget
                                                              .item!.productUrl,
                                                          widget.item!.name);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Icon(
                                                          Icons.share_outlined,
                                                          color: Colors.white,
                                                          size: 20.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => EvaluateScreen(
                                          widget.item!.imageUrl,
                                          widget.item!.sku,
                                          widget.item!.name));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RatingBar.builder(
                                          unratedColor: Colors.grey,
                                          ignoreGestures: true,
                                          itemSize: 25,
                                          initialRating: double.parse(
                                              contrl.ms8model!.lookAvgrating!),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 0.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          contrl.ms8model!.lookAvgrating!
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '(${widget.item!.reviewCount.toString()})',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // currencycntrl
                                                  //         .defaultCurrency! +
                                                  //     " " +
                                                  contrl.ms8model!.lookPrice!
                                                      .toString()
                                                      .toProperCurrency(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                              text: 'Earn ' +
                                                                  contrl
                                                                      .ms8model!
                                                                      .lookRewardPoints
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize:
                                                                      13)),
                                                          WidgetSpan(
                                                            alignment:
                                                                PlaceholderAlignment
                                                                    .middle,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      2.0),
                                                              child: PngIcon(
                                                                height: 12,
                                                                width: 12,
                                                                image:
                                                                    'assets/images/goldencoin.png',
                                                              ),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                              text:
                                                                  'VIP points',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize:
                                                                      13)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                contrl.ms8model!.lookPrice! <
                                                        1000
                                                    ? Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 0.0,
                                                                vertical: 5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                                                              'or 4 interest free installment',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline2!
                                                                  .copyWith(
                                                                    color: SplashScreenPageColors
                                                                        .textColor,
                                                                    fontSize:
                                                                        13.0,
                                                                  ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'of ' +
                                                                      '${((contrl.ms8model!.lookPrice!).toDouble() / 4).toString().toProperCurrency()} with ',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline2!
                                                                      .copyWith(
                                                                        color: SplashScreenPageColors
                                                                            .textColor,
                                                                        fontSize:
                                                                            12.0,
                                                                      ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                                Container(
                                                                  width: 70.0,
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/images/clearpay_new.png",
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    openDialog();
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10.0,
                                                                        top: 5,
                                                                        bottom:
                                                                            5),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          18.0,
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/information.png",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 5,
                                                  backgroundColor:
                                                      stockupdate(contrl) ==
                                                              "IN STOCK"
                                                          ? Color.fromRGBO(
                                                              0, 255, 68, 1)
                                                          : Color.fromRGBO(
                                                              255, 0, 0, 1),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  stockupdate(contrl),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.white,
                                        ),
                                        options(contrl),
                                        FutureBuilder(
                                          future: sfAPIGetProductStatic(),
                                          builder: (BuildContext _, snapshot) {
                                            if (snapshot.hasData) {
                                              return StaticDetails(
                                                  data: json.decode(
                                                      snapshot.data as String));
                                            } else {
                                              return Container(
                                                height: 65,
                                                color: Colors.black,
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            )),
                      contrl.ms8model == null
                          ? Container()
                          : Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                    height: 50,
                                    minWidth: Get.width * 0.4,
                                    color: Color(0xffF2CA8A),
                                    shape: StadiumBorder(),
                                    onPressed: () {
                                      // Get.to(() => MakeOverTryOn());
//                                       controller.lookModel!.items!.forEach((element) {
// looklist.add(element.name);
// });

                                      tiop.looklist.value = widget.looklist!;
                                      tiop.lookname.value = widget.item!.name!;
                                      tiop.lookindex.value = widget.id!;
                                      tiop.page.value = 2;
                                      tiop.lookProduct.value = true;
                                      tiop.directProduct.value = false;
                                      Get.to(() => TryItOnScreen());
                                    },
                                    child: Text("TRY ON"),
                                  ),
                                  MaterialButton(
                                    height: 50,
                                    minWidth: Get.width * 0.4,
                                    color: Colors.white,
                                    shape: StadiumBorder(),
                                    onPressed: () async {
                                      await Provider.of<CartProvider>(context,
                                              listen: false)
                                          .addToCart(context, widget.item!.sku!,
                                              [], 1, widget.item!.name!);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        padding: EdgeInsets.all(0),
                                        backgroundColor: Colors.transparent,
                                        duration: Duration(seconds: 1),
                                        content: Container(
                                          child: CustomSnackBar(
                                            sku: widget.item!.sku!,
                                            image: contrl.ms8model!.lookImage
                                                .toString(),
                                            name: widget.item!.name!,
                                          ),
                                        ),
                                      ));
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/Path_6.png'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("ADD TO BAG")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(vertical: 10),
                            ),
                    ],
                  );
          }),
        )
      ]),
    ));
  }

  Container getContainerWidget(Size size) {
    String shippingText = "";
    String freeshipping =
        Provider.of<AccountProvider>(context, listen: false).freeShippingAmount;
    if (Provider.of<CartProvider>(context).itemCount == 0) {
      shippingText = 'Free shipping above ' +
          // currencycntrl.defaultCurrency! +
          freeshipping.toString().toProperCurrency();
      return Container(
          color: HexColor("#EB7AC1"),
          height: 25,
          width: size.width,
          child: Center(
              child: Text(
            shippingText,
            style: TextStyle(fontSize: 12),
          )));
    } else {
      double minusAmount = (double.parse(
              Provider.of<AccountProvider>(context, listen: false)
                  .freeShippingAmount) -
          double.parse(Provider.of<CartProvider>(context)
              .chargesList[0]['amount']
              .toString()));
      if (minusAmount > 0) {
        shippingText = 'Add ' +
            // currencycntrl.defaultCurrency! +
            minusAmount.toString().toProperCurrency() +
            " to your cart to get free shipping";

        return Container(
            color: HexColor("#EB7AC1"),
            height: 25,
            width: size.width,
            child: Center(
                child: Text(
              shippingText,
              style: TextStyle(fontSize: 12),
            )));
      } else {
        return Container();
      }
    }
  }
}

class LearnMoreDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: const Text("Clear Pay"),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/clearpay.jpeg"),
            )),
      ),
    );
  }
}
