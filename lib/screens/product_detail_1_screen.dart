// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

// 3rd party packages
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/selectedProductController.dart';
import 'package:sofiqe/model/product_model.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/evaluate_screen.dart';
import 'package:sofiqe/screens/my_sofiqe.dart';

// <<<<<<< HEAD
import 'package:sofiqe/screens/try_it_on_screen.dart';

// =======
import 'package:sofiqe/utils/api/product_details_api.dart';

// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
// Utils
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/utils/constants/route_names.dart';
import 'package:sofiqe/utils/states/function.dart';
import 'package:sofiqe/widgets/Shimmers/product_detail_shimmer_view.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/product_detail/additional_details.dart';
import 'package:sofiqe/widgets/product_detail/color_selector.dart';
import 'package:sofiqe/widgets/product_detail/order_notification.dart';

// Custom packages
import 'package:sofiqe/widgets/product_detail/product_options_drop_down.dart';
import 'package:sofiqe/widgets/product_detail/static_details.dart';
import 'package:sofiqe/widgets/product_image.dart';
import 'package:sofiqe/widgets/wishlistwhite.dart';

import '../provider/freeshiping_provider.dart';

class ProductDetail1Screen extends StatefulWidget {
  final String sku;
  dynamic selectShadeOption;

  ProductDetail1Screen({Key? key, this.sku = 'MT-45230167'}) : super(key: key);

  @override
  _ProductDetail1ScreenState createState() => _ProductDetail1ScreenState();
}

class _ProductDetail1ScreenState extends State<ProductDetail1Screen> {
  String freeShippingAmount = "";
  List<Product> mConfigurableProduct = <Product>[];
  int qty = 0;
  double price = 0;
  String shadeAttributID = "";
  int selectedShadeIndex = 0;
  bool isDetail = false;
  Product selectedproduct = Product(
      id: 0,
      name: '',
      sku: 'sku',
      price: 0,
      image: 'image',
      description: 'description',
      faceSubArea: 0,
      avgRating: '');

  Future<http.Response> getProductDetails() async {
    return sfAPIGetProductDetailsFromSKU(sku: '${widget.sku}');
  }

  dynamic selectShadeOption;
  dynamic responseBody;
  bool flagLoadingData = true;
  late Product product;
  late String description;
  List options = [];
  List optionsNew = [];
  List shadeOptions = [];
  var type;
  int index = 0;
  int colorIndex = 0;

  loadProductDetails() async {
    setState(() {
      selectShadeOption = widget.selectShadeOption;
      flagLoadingData = true;
    });
    http.Response response = await getProductDetails();

    Map<String, dynamic> responseBodytemp = json.decode(response.body);
    Product producttemp = Product.fromDefaultMap(responseBodytemp);
    if (selectedproduct.id == 0) selectedproduct = producttemp;
    // String shortDescription = (responseBody['custom_attributes'][18]['value'] as String).replaceAll(RegExp(r'<p>|</p>'), '');
    String descriptiontemp = '';
    // print("description at initial");
    if (responseBodytemp['custom_attributes'] != null) {
      (responseBodytemp['custom_attributes'] as List).forEach((customAttr) {
        // print("custom_attribute ::$customAttr");
        if (customAttr['attribute_code'] == 'description') {
          descriptiontemp = (customAttr['value'] as String);
          // print("description  first if::$description");
        }
      });
    }
    if (responseBodytemp['custom_attributes'] != null) {
      if (descriptiontemp.isEmpty) {
        (responseBodytemp['custom_attributes'] as List).forEach((customAttr) {
          if (customAttr['attribute_code'] == 'short_description') {
            descriptiontemp = (customAttr['value'] as String);
            // print("description  description is empty$description");
          }
        });
      }
    }

    List optionstemp = [];
    List optionsNewtemp = [];
    List shadeOptionstemp = [];
    var typetemp;

    if (responseBodytemp['type_id'] == 'configurable') {
      optionstemp = responseBodytemp['extension_attributes']
          ['configurable_product_options'];

      optionsNewtemp = responseBodytemp['options'];

      typetemp = 0;
      List<StockItem> mStockItemList = getStockItemList();
      if (mStockItemList.length > 0) {
        qty = mStockItemList[selectedShadeIndex].qty!;
        price = mStockItemList[selectedShadeIndex].price!;
      }
    } else {
      optionstemp = responseBodytemp['options'];
      typetemp = 1;
      try {
        qty = responseBodytemp['extension_attributes']['stock_item']['qty'];
      } catch (e) {}
      try {
        price = double.parse((responseBodytemp["price"] ?? "0").toString());
      } catch (e) {}
    }
    if (optionstemp.length != 0) {
      optionstemp.forEach((item) {
        if (item['title'] == 'Color') {
          if ((item['values'][0]['title'] as String).startsWith('#')) {
            item['type'] = 'dot_selector';
          }
        }
        if (item['option_type_id'] == null &&
            item['values'] != null &&
            item['values'] is List &&
            (item['values'] as List).isNotEmpty) {
          var tempList = item['values'] as List;
          item['option_type_id'] = "${tempList[0]['option_type_id']}";
        }

        if (item["label"] != null && item["label"] == "Shade Color") {
          shadeOptionstemp = item["values"];
          shadeAttributID = item['attribute_id'];
        }
      });
    }

    if (shadeOptionstemp.length > 0 && selectShadeOption == null) {
      setState(() {
        selectShadeOption = shadeOptionstemp[0];
      });
    }
    setState(() {
      simpleProductOptions = List.generate(optionstemp.length, (index) => {});
      product = producttemp;
      description = descriptiontemp;
      options = optionstemp;
      optionsNew = optionsNewtemp;
      shadeOptions = shadeOptionstemp;
      type = typetemp;
      flagLoadingData = false;
      responseBody = responseBodytemp;
    });
  }

  Future<void> share(prodUrl, title) async {
    await FlutterShare.share(
        title: title, text: title, linkUrl: prodUrl, chooserTitle: 'Share');
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    ///todo: uncomment
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    freeShippingAmount = FreeShippingProvider.shippingValue;
    print("LOKENDRA = " + freeShippingAmount);
    loadProductDetails();
    super.initState();
  }

  List simpleProductOptions = [];

  void setOptions(index, optionMap) {
    simpleProductOptions[index] = optionMap;
    print(simpleProductOptions);
  }

  final TryItOnProvider tiop = Get.find();
  final PageProvider pp = Get.find();
  bool flagAddingtoCart = false;

  @override
  Widget build(BuildContext context) {
    String pdt1 = 'Sofiqe';
    // String pdt6 = 'IN STOCK';
    Size size = MediaQuery.of(context).size;

    var cartItems = Provider.of<CartProvider>(context).getCartLength();
    var totalCartQty = Provider.of<CartProvider>(context).getTotalQty();
    Provider.of<CartProvider>(context).calculateCartPrice();
    return Scaffold(
        appBar: AppBar(
          // shadowColor: Colors.white,
          // elevation: 1,
          // added By kruti back navigation button and close icon code was commented
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),

          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            pdt1.toLowerCase(),
            style: Theme.of(context).textTheme.headline1!.copyWith(
                color: Colors.white, fontSize: 25, letterSpacing: 2.5),
          ),
          actions: [
            Container(
              height: AppBar().preferredSize.height,
              width: AppBar().preferredSize.height * 1.3,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    tiop.sku.value = "123456";
                    tiop.isChangeButtonColor.value = true;
                    tiop.playSound();
                    Future.delayed(Duration(milliseconds: 10)).then((value) {
                      tiop.isChangeButtonColor.value = false;
                      tiop.sku.value = "";
                      Navigator.pushNamed(context, RouteNames.cartScreen);
                    });
                  },
                  child: Obx(
                    () => Container(
                      height: AppBar().preferredSize.height * 0.7,
                      width: AppBar().preferredSize.height * 0.7,
                      decoration: BoxDecoration(
                        color: tiop.isChangeButtonColor.isTrue &&
                                tiop.sku.value == "123456"
                            ? tiop.ontapColor
                            : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                            AppBar().preferredSize.height * 0.7)),
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
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  padding: EdgeInsets.all(5),
                                  child: Text(totalCartQty.toString()))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: (flagLoadingData)
            ? ProductDetailPageShimmerView()
            : Column(
                children: [
                  // added by kruti and commented below code  for pink bar in screen
                  getContainerWidget(context, size),
                  // Container(
                  //   width: double.infinity,
                  //   color: SplashScreenPageColors.freeShippingColor,
                  //   child: Center(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(3.0),
                  //       child: Text(
                  //         "Free shipping above " +
                  //             freeShippingAmount.toProperCurrencyString(),
                  //         style: TextStyle(fontSize: 14.0, color: Colors.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        color: AppColors.navigationBarSelectedColor,
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 40.0),
                                  child: Center(
                                    child: ProductImage(
                                      imageShortPath: '${product.image}',
                                      width: size.width * 0.4,
                                      height: size.width * 0.4,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    // child: ColorSelector(), // here is color selector
                                    child: Column(
                                      children: [
                                        ...options.map(
                                          (items) {
                                            int localIndex = colorIndex++;
                                            if (items['type'] ==
                                                'dot_selector') {
                                              return ColorSelector(
                                                // Here is options
                                                type: type,
                                                optionMap: items,
                                                options: (optionMap) {
                                                  setOptions(
                                                      localIndex, optionMap);
                                                  items['option_type_id'] =
                                                      optionMap['optionValue'];
                                                },
                                              );
                                            } else {
                                              setState(() {
                                                isDetail = false;
                                              });
                                              return Container();
                                            }
                                          },
                                        ).toList()
                                      ],
                                    ),
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.center,
                                    runSpacing: 10,
                                    children: shadeOptions.map((item) {
                                      print(
                                          "selectShadeOption $selectShadeOption");
                                      setState(() {
                                        isDetail = true;
                                      });
                                      return InkWell(
                                        onTap: () {
                                          print("***********************");
                                          print(item);
                                          int indexof =
                                              shadeOptions.indexOf(item);
                                          List<StockItem> mStockItemList =
                                              getStockItemList();
                                          if (mStockItemList.length > 0) {
                                            setState(() {
                                              qty =
                                                  mStockItemList[indexof].qty!;
                                            });
                                            print(qty);
                                          }
                                          Get.find<SelectedProductController>()
                                              .setSelectedColor(Color(int.parse(
                                                      item["extension_attributes"]
                                                              ["value_label"]
                                                          .toString()
                                                          .substring(1, 7),
                                                      radix: 16) +
                                                  0xFF000000));
                                          setState(() {
                                            selectShadeOption = item;
                                            selectedShadeIndex = index;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3.0, right: 3.0),
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(int.parse(
                                                            item["extension_attributes"]
                                                                    [
                                                                    "value_label"]
                                                                .toString()
                                                                .substring(
                                                                    1, 7),
                                                            radix: 16) +
                                                        0xFF000000),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                width: 23.0,
                                                height: 23.0,
                                              ),
                                              selectShadeOption != null &&
                                                      selectShadeOption[
                                                              "value_index"] ==
                                                          item["value_index"]
                                                  ? Container(
                                                      child: Image.asset(
                                                          "assets/images/checked.png",
                                                          height: 10.0),
                                                      margin: EdgeInsets.only(
                                                          left: 16.0),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${responseBody['name'].toString().toUpperCase()}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: SplashScreenPageColors
                                                  .textColor,
                                              fontFamily: 'Arial, Regular',
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      ),

                                      /// Add review icon
                                      //Review(sku: responseBody['sku']),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 40.0,
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => EvaluateScreen(
                                              product.image,
                                              product.sku,
                                              product.name));
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
                                                  product.avgRating),
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
                                              product.avgRating.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '(${product.reviewCount})',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Align(
                                      //   child: RatingBarIndicator(
                                      //     itemSize: 20,
                                      //     rating: double.parse(product.avgRating),
                                      //     unratedColor: Colors.white,
                                      //     direction: Axis.horizontal,
                                      //     itemCount: 5,
                                      //     itemPadding: EdgeInsets.symmetric(
                                      //         horizontal: 4.0),
                                      //     itemBuilder: (context, _) => Icon(
                                      //       Icons.star,
                                      //       color: Colors.amber,
                                      //     ),
                                      //   ),
                                      // ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: size.height * 0.01,
                                                  horizontal:
                                                      size.width * 0.03),
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0),
                                                    child: WishListWhite(
                                                        sku:
                                                            responseBody['sku'],
                                                        itemId:
                                                            responseBody['id']),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: InkWell(
                                                onTap: () {
                                                  share(product.productURL,
                                                      product.name);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Icon(Icons.share,
                                                      color: Colors.white,
                                                      size: 20.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 12),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Text(
                                                  // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                                                  '${price.toString().toProperCurrency()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2!
                                                      .copyWith(
                                                        color:
                                                            SplashScreenPageColors
                                                                .textColor,
                                                        fontSize: 16.0,
                                                      ),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Icon(
                                                        Icons.circle,
                                                        color: qty > 0
                                                            ? SplashScreenPageColors
                                                                .inStockColor
                                                            : Colors
                                                                .red, // change here
                                                        size: 10,
                                                      ),
                                                    ),
                                                    Text(
                                                      qty > 0
                                                          ? 'ONLY ' +
                                                              qty.toString() +
                                                              ' LEFT'
                                                          : 'OUT OF STOCK',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2!
                                                          .copyWith(
                                                            fontSize: 10,
                                                            color:
                                                                SplashScreenPageColors
                                                                    .textColor,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                        // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                                        'Earn ${(responseBody['extension_attributes']['reward_points'])}',

                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                              color: SplashScreenPageColors
                                                  .earnColor,
                                              fontSize: 12.0,
                                            ),
                                      ),
                                      Container(
                                        width: 10.0,
                                        child: Image.asset(
                                          "assets/images/coin.png",
                                        ),
                                      ),
                                      Text(
                                        ' VIP Points',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                              color: SplashScreenPageColors
                                                  .earnColor,
                                              fontSize: 12.0,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                                        'or 4 interest free installment',

                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                              color: SplashScreenPageColors
                                                  .textColor,
                                              fontSize: 12.0,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                                                      'of ${(price / 4).toString().toProperCurrency()}/month with ',

                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2!
                                                          .copyWith(
                                                            color:
                                                                SplashScreenPageColors
                                                                    .textColor,
                                                            fontSize: 12.0,
                                                          ),
                                                    ),
                                                    Container(
                                                      width: 70.0,
                                                      child: Image.asset(
                                                        "assets/images/clearpay_new.png",
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        openDialog();
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        child: Container(
                                                          width: 18.0,
                                                          child: Image.asset(
                                                            "assets/images/information.png",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Container(
                                    child: Text(
                                      '$description',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Arial, Regular',
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Divider(
                                    height: 0,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                                ...options.map(
                                  (items) {
                                    int localIndex = index++;
                                    if (items['type'] == 'dot_selector') {
                                      return Container();
                                    }
                                    if (items['value'] == null) {
                                      return Container();
                                    }
                                    return ProductOptionsDropDown(
                                      // Here is options
                                      type: type,
                                      optionMap: items,
                                      options: (optionMap) {
                                        setOptions(localIndex, optionMap);
                                        items['option_type_id'] =
                                            optionMap['optionValue'];
                                      },
                                    );
                                  },
                                ).toList(),

                                AdditionalOptions(
                                    details: responseBody['custom_attributes']),
                                // Add addional options here
//Shipping Payment, Returns and Exchange
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: FutureBuilder(
                                    future: sfAPIGetProductStatic(),
                                    builder: (BuildContext _, snapshot) {
                                      if (snapshot.hasData) {
                                        return StaticDetails(
                                            data: json.decode(
                                                snapshot.data as String));
                                      } else {
                                        return Container(
                                          height: size.height,
                                          color: Colors.black,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 155,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.primaryColor),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return tiop.ontapColor; //<-- SEE HERE
                                  return null; // Defer to the widget's default.
                                },
                              ),
                            ),
                            onPressed: () {
                              tiop.isChangeButtonColor.value = true;
                              tiop.isChangeButtonColor.value = true;
                              tiop.playSound();
                              Future.delayed(Duration(milliseconds: 10))
                                  .then((value) {
                                tiop.isChangeButtonColor.value = false;
                                tiop.received.value = selectedproduct;
                                tiop.page.value = 2;
                                tiop.directProduct.value = true;
                                tiop.lookProduct.value = false;
                                Get.to(() => TryItOnScreen(
                                      isDetail: isDetail,
                                      selectShadeOption: selectShadeOption,
                                    ));
                              });
                              // Navigator.pop(context);
                              tiop.received.value = selectedproduct;
                              tiop.page.value = 2;
                              tiop.directProduct.value = true;
                              tiop.lookProduct.value = false;
                              Get.to(() => TryItOnScreen(
                                    isDetail: isDetail,
                                    selectShadeOption: selectShadeOption,
                                  ));
                              // tiop.received.value = product;
                              // tiop.page.value = 2;
                              // tiop.directProduct.value = true;
                              // tiop.LookProduct.value=false;
                              // pp.goToPage(Pages.TRYITON);
                            },
                            child: Text(
                              'TRY ON',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Arial, Regular',
                                  color: AppColors.navigationBarSelectedColor),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 155,
                          child: flagAddingtoCart
                              ? SpinKitFadingCircle(
                                  color: Color(0xffF2CA8A),
                                  size: 40.0,
                                )
                              : ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        SplashScreenPageColors.textColor),
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed))
                                          return tiop.ontapColor; //<-- SEE HERE
                                        return null; // Defer to the widget's default.
                                      },
                                    ),
                                  ),
                                  // style: ElevatedButton.styleFrom(
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius:
                                  //       BorderRadius.circular(100),
                                  //     ),
                                  //     primary:
                                  //     SplashScreenPageColors.textColor),
                                  onPressed: () async {
                                    tiop.isChangeButtonColor.value = true;
                                    tiop.playSound();
                                    Future.delayed(Duration(milliseconds: 10))
                                        .then((value) async {
                                      tiop.isChangeButtonColor.value = false;
                                      if (qty == 0) {
                                        Get.showSnackbar(
                                          GetSnackBar(
                                            message:
                                                'The product is out of stock',
                                            duration: Duration(
                                              seconds: 2,
                                            ),
                                          ),
                                        );
                                      } else {
                                        if (options.isNotEmpty) {
                                          options.forEach((po) {
                                            if (po['is_required'] == true &&
                                                po['option_type_id'] == null) {
                                              Get.showSnackbar(
                                                GetSnackBar(
                                                  message:
                                                      'Select ${po['title']} first!!',
                                                  duration:
                                                      Duration(seconds: 2),
                                                  isDismissible: true,
                                                ),
                                              );
                                              return;
                                            }
                                          });

                                          List<Map> selectedOptions = [];
                                          List<Map> customOptions = [];
                                          print(options.toString());
                                          List<StockItem> mcheckStockItem =
                                              getStockItemList();
                                          if (responseBody['type_id'] ==
                                              'configurable') {
                                            if (mcheckStockItem.isNotEmpty) {
                                              selectedOptions.add(
                                                {
                                                  "option_id": shadeAttributID,
                                                  "option_value":
                                                      selectShadeOption[
                                                          'value_index'],
                                                },
                                              );
                                            }

                                            optionsNew.forEach((element) {
                                              customOptions.add(
                                                {
                                                  "option_id":
                                                      "${element['option_id']}",
                                                  "option_value":
                                                      element['values'][0]
                                                          ['option_type_id'],
                                                },
                                              );
                                            });
                                            setState(() {
                                              flagAddingtoCart = true;
                                            });
                                            await Provider.of<CartProvider>(
                                                    context,
                                                    listen: false)
                                                .addToCartConfigurableProduct(
                                                    context,
                                                    responseBody['sku'],
                                                    selectedOptions,
                                                    customOptions,
                                                    1);
                                            setState(() {
                                              flagAddingtoCart = false;
                                            });
                                          } else {
                                            options.forEach((element) {
                                              selectedOptions.add(
                                                {
                                                  "option_id":
                                                      "${element['option_id']}",
                                                  "option_value":
                                                      element['option_type_id'],
                                                },
                                              );
                                            });
                                            setState(() {
                                              flagAddingtoCart = true;
                                            });
                                            await Provider.of<CartProvider>(
                                                    context,
                                                    listen: false)
                                                .addToCart(
                                                    context,
                                                    responseBody['sku'],
                                                    selectedOptions,
                                                    responseBody['type_id'] ==
                                                            'simple'
                                                        ? 0
                                                        : 1,
                                                    "");
                                            setState(() {
                                              flagAddingtoCart = false;
                                            });
                                          }

                                          setState(() {
                                            qty--;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            padding: EdgeInsets.all(0),
                                            backgroundColor:
                                                AppColors.transparent,
                                            duration: Duration(seconds: 1),
                                            content: Container(
                                              child: CustomSnackBar(
                                                  sku: responseBody['sku'],
                                                  image: '${product.image}',
                                                  name: responseBody['name']
                                                      .toString()
                                                      .toUpperCase()),
                                            ),
                                          ));
                                        } else {
                                          setState(() {
                                            flagAddingtoCart = true;
                                          });

                                          await Provider.of<CartProvider>(
                                                  context,
                                                  listen: false)
                                              .addToCart(
                                                  context,
                                                  responseBody['sku'],
                                                  [],
                                                  responseBody['type_id'] ==
                                                          'simple'
                                                      ? 0
                                                      : 1,
                                                  "");

                                          setState(() {
                                            flagAddingtoCart = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            padding: EdgeInsets.all(0),
                                            backgroundColor:
                                                AppColors.transparent,
                                            duration: Duration(seconds: 1),
                                            content: Container(
                                              child: CustomSnackBar(
                                                  sku: responseBody['sku'],
                                                  image: '${product.image}',
                                                  name: responseBody['name']
                                                      .toString()
                                                      .toUpperCase()),
                                            ),
                                          ));
                                        }
                                      }
                                    });
                                    // try {
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/Path_6.png",
                                      ),
                                      Text(
                                        'ADD TO BAG',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: 'Arial, Regular',
                                            color: AppColors
                                                .navigationBarSelectedColor),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }

  // added by kruti to solve error which was not showing pink bar with remaining amount need  to be added to cart
  Container getContainerWidget(BuildContext context, Size size) {
    // CurrencyController currencycntrl = Get.put(CurrencyController());
    String shippingText = "";

    String freeshipping =
        Provider.of<AccountProvider>(context, listen: false).freeShippingAmount;
    if ((Provider.of<CartProvider>(context).cart ?? []).length == 0) {
      shippingText = 'Free shipping above ' +

          //  currencycntrl.defaultCurrency! +

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
            // currencycntrl.defaultCurrency!
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

  void openDialog() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new LearnMoreDialog();
        },
        fullscreenDialog: true));
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
