// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/catalog_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/screens/general_account_screen.dart';
import 'package:sofiqe/screens/shopping_bag_screen.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/widgets/catalog/catalog_products/catalog.dart';
import 'package:sofiqe/widgets/catalog/catalog_products/filter_overlay.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/round_button.dart';
import 'package:sofiqe/widgets/translucent_background.dart';

import '../provider/cart_provider.dart';

class CatalogScreen extends StatelessWidget {
  CatalogScreen({Key? key}) : super(key: key);

  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height - 56 - MediaQuery.of(context).padding.bottom,
        // height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _TopBanner(),
            Container(
              color: Colors.black,
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () {
                        FaceArea fa = catp.faceArea.value;
                        return _MainFilter(faceArea: fa);
                      },
                    ),
                  ),
                  Obx(() {
                    return Container(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                            onPressed: () {
                              catp.setShowSubFilters(!catp.showSubFilters.value);
                            },
                            icon: Icon(
                              Icons.tune,
                              color: catp.showSubFilters.value ? AppColors.primaryColor : Colors.white,
                            )));
                  })
                ],
              ),
            ),
            Obx(
              () {
                FilterType ft = catp.filterType.value;
                return catp.showSubFilters.value
                    ? _SubFilter(
                        filterType: ft,
                      )
                    : Container();
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  Catalog(),
                  Obx(
                    () {
                      return catp.showSubFilters.value ? FilterOverlay() : Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBanner extends StatelessWidget {
  _TopBanner({Key? key}) : super(key: key);

  final PageProvider pp = Get.find();
  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
// <<<<<<< HEAD
//     var cartItems = Provider.of<CartProvider>(context).cart!.length;
// =======
    var cartItems = Provider.of<CartProvider>(context).itemCount;
    var cartTotalQty = Provider.of<CartProvider>(context).getTotalQty();
    // print("carttotalQty catalog_screen ::$cartTotalQty");
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
    return Stack(
      children: [
        Container(
          height: size.height * 0.15,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/catalog_top_banner.png'),
            ),
          ),
        ),
        Container(height: size.height * 0.15, width: size.width, child: TranslucentBackground(opacity: 0.2)),
        Container(
          height: size.height * 0.15,
          width: size.width,
          child: Row(
            children: [
              Container(
                width: size.width * 0.18,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    pp.goToPage(Pages.HOME);
                  },
                  child: SvgPicture.asset('assets/svg/arrow.svg'),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () {
            FaceArea ft = catp.faceArea.value;
            int count = catp.catalogItemsList.length;
            String faceAreaName = 'ALL';
            switch (ft) {
              case FaceArea.ALL:
                faceAreaName = 'ALL';
                break;
              case FaceArea.EYES:
                faceAreaName = 'EYES';
                break;
              case FaceArea.LIPS:
                faceAreaName = 'LIPS';
                break;
              case FaceArea.CHEEKS:
                faceAreaName = 'COMPLEXION';
                break;
            }
            return Container(
              width: size.width,
              height: size.height * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$faceAreaName',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.white,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    '$count Products',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.white,
                          fontSize: size.height * 0.015,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
        Obx(
              () {
            return Container(
              width: size.width,
              height: size.height * 0.15,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.014),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  catp.showSearchBar.value ? SearchBar() : Container(),
                  SizedBox(width: size.width * 0.024),
                  RoundButton(
                    backgroundColor: Colors.white,
                    size: size.height * 0.05,
                    onPress: () {
                      if (catp.showSearchBar.value) {
                        catp.hideSearchBar();
                      } else {
                        catp.unhideSeachBar();
                      }
                    },
                    child: catp.showSearchBar.value ? Icon(Icons.close) : SvgPicture.asset('assets/svg/search.svg'),
                  ),
                  SizedBox(width: size.width * 0.014),
                  RoundButton(
                    sku: "12",
                    backgroundColor:catp.isChangeButtonColor.isTrue && catp.sku.value=="12"?catp.ontapColor:Colors.black,
                    size: size.height * 0.05,
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext c) {
                            return ShoppingBagScreen();
                          },
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        PngIcon(image: 'assets/icons/add_to_cart_white.png'),
                        cartItems == 0
                            ? SizedBox()
                            : Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                            padding: EdgeInsets.all(5),
                            child: Text(cartTotalQty.toString()))
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final CatalogProvider catp = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(storeInput);
  }

  void storeInput() {
    catp.inputText.value = controller.value.text;
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {});
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.012, vertical: size.height * 0.008),
      alignment: Alignment.center,
      width: size.width * 0.6,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(size.height * 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: size.width * 0.5,
            child: CupertinoTextField(
              padding: EdgeInsets.symmetric(horizontal: 4),
              controller: controller,
              autofocus: true,
              cursorColor: Colors.black,
              decoration: BoxDecoration(
                  // border: InputBorder.none,
                  ),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.02,
                    decoration: TextDecoration.none,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              catp.search();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: SvgPicture.asset(
                'assets/svg/search.svg',
                color: Colors.black,
                height: size.height * 0.018,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MainFilter extends StatelessWidget {
  final FaceArea faceArea;
  _MainFilter({
    Key? key,
    required this.faceArea,
  }) : super(key: key);

  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.055,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              catp.setFaceArea(FaceArea.ALL);
            },
            child: Text(
              'ALL',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: faceArea == FaceArea.ALL ? Color(0xFFF2CA8A) : Colors.white,
                    fontSize: size.height * 0.018,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              catp.setFaceArea(FaceArea.EYES);
            },
            child: Text(
              'EYES',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: faceArea == FaceArea.EYES ? Color(0xFFF2CA8A) : Colors.white,
                    fontSize: size.height * 0.018,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              catp.setFaceArea(FaceArea.LIPS);
            },
            child: Text(
              'LIPS',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: faceArea == FaceArea.LIPS ? Color(0xFFF2CA8A) : Colors.white,
                    fontSize: size.height * 0.018,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              catp.setFaceArea(FaceArea.CHEEKS);
            },
            child: Text(
              'CHEEKS',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: faceArea == FaceArea.CHEEKS ? Color(0xFFF2CA8A) : Colors.white,
                    fontSize: size.height * 0.018,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubFilter extends StatelessWidget {
  final FilterType filterType;
  _SubFilter({
    Key? key,
    required this.filterType,
  }) : super(key: key);

  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.075,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SubFilterButton(
            filterName: 'Skin Tone',
            svgPath: 'assets/svg/face_filter.svg',
            color: filterType == FilterType.SKINTONE ? Color(0xFFF2CA8A) : Color(0xFF8E8484),
            premium: true,
            onTap: () async {
              if (catp.faceArea.value == FaceArea.ALL) {
                catp.setFaceArea(FaceArea.EYES);
              }
              if (!Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext c) {
                      return GeneralAccountScreen(
                        message: 'Looks like you want to select custom colors!',
                        prompt:
                            'Login to get a range of customization options and get your own personalized product catalog',
                        onSuccess: () {
                          Navigator.pop(context);
                          catp.setFilter(FilterType.SKINTONE);
                        },
                      );
                    },
                  ),
                );
                if (!Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
                  Get.showSnackbar(
                    GetSnackBar(
                      message: 'Please signup to use this feature',
                      duration: Duration(
                        seconds: 2,
                      ),
                    ),
                  );
                  return;
                }
              } else {
                catp.setFilter(FilterType.SKINTONE);
              }
            },
          ),
          _SubFilterButton(
            filterName: 'Product',
            svgPath: 'assets/svg/lipstick.svg',
            color: filterType == FilterType.PRODUCT ? Color(0xFFF2CA8A) : Color(0xFF8E8484),
            onTap: () {
              if (catp.faceArea.value == FaceArea.ALL) {
                catp.setFaceArea(FaceArea.EYES);
              }
              catp.setFilter(FilterType.PRODUCT);
            },
          ),
          _SubFilterButton(
            filterName: 'Price',
            svgPath: 'assets/svg/price.svg',
            color: filterType == FilterType.PRICE ? Color(0xFFF2CA8A) : Color(0xFF8E8484),
            onTap: () {
              // catp.priceFilter.value.currentMinPrice = 1;
              // catp.priceFilter.value.currentMaxPrice = 199;
              // print(
              //     ' min price val is ${catp.priceFilter.value.currentMinPrice.toDouble()} ====');
              // print(
              //     ' min price val is ${catp.priceFilter.value.currentMaxPrice.toDouble()} ====');
              catp.setFilter(FilterType.PRICE);
            },
          ),
          _SubFilterButton(
            filterName: 'Brand',
            svgPath: 'assets/svg/brand.svg',
            color: filterType == FilterType.BRAND ? Color(0xFFF2CA8A) : Color(0xFF8E8484),
            onTap: () {
              if (catp.faceArea.value == FaceArea.ALL) {
                catp.setFaceArea(FaceArea.EYES);
              }
              catp.setFilter(FilterType.BRAND);
            },
          ),
          _SubFilterButton(
            filterName: 'Review',
            svgPath: 'assets/svg/review.svg',
            color: filterType == FilterType.REVIEW ? Color(0xFFF2CA8A) : Color(0xFF8E8484),
            onTap: () {
              catp.setFilter(FilterType.REVIEW);
            },
          ),
          _SubFilterButton(
            filterName: 'Popular',
            svgPath: 'assets/svg/popular.svg',
            color: filterType == FilterType.POPULAR ? Color(0xFFF2CA8A) : Color(0xFF8E8484),
            onTap: () {
              catp.setFilter(FilterType.POPULAR);
            },
          ),
        ],
      ),
    );
  }
}

class _SubFilterButton extends StatelessWidget {
  final String filterName;
  final String svgPath;
  final Color color;
  final bool premium;
  final void Function() onTap;
  const _SubFilterButton({
    Key? key,
    required this.filterName,
    required this.svgPath,
    required this.color,
    required this.onTap,
    this.premium = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.01),
            SvgPicture.asset(
              '$svgPath',
              color: color,
              width: size.height * 0.02,
              height: size.height * 0.02,
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              '$filterName',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: color,
                    fontSize: size.height * 0.015,
                  ),
            ),
            Text(
              '${premium ? 'PREMIUM' : ''}',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFFF2CA8A),
                    fontSize: size.height * 0.01,
                    letterSpacing: 0,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
