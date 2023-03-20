import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/model/data_ready_status_enum.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/provider/catalog_provider.dart';
// Remove to test background service
// import 'package:sofiqe/provider/freeshiping_provider.dart';
import 'package:sofiqe/screens/my_sofiqe.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/utils/states/function.dart';
import 'package:sofiqe/widgets/product_item_card.dart';

import '../../Shimmers/catalog_buffering_shimmer.dart';

class Catalog extends StatefulWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  String freeShippingAmount = "Loading..";
  ScrollController gridScrollController = ScrollController();

  final CatalogProvider cp = Get.find();

  @override
  void initState() {
    super.initState();
    gridScrollController.addListener(loadMore);
    // freeShippingAmount = 'Free Shipping above ' +
    //     FreeShippingProvider.shippingValue.toString().toProperCurrency();
    String freeshipping =
        Provider.of<AccountProvider>(context, listen: false).freeShippingAmount;
    freeShippingAmount =
        'Free Shipping above ' + freeshipping.toString().toProperCurrency();

    // loadMore();
  }

  @override
  void dispose() {
    // gridScrollController.removeListener(loadMore);
    super.dispose();
  }

  Future<void> loadMore() async {
    if (gridScrollController.offset ==
        gridScrollController.position.maxScrollExtent) {
      print('Loading More');
      if (await cp.fetchMoreItems()) {
        setState(() {});
        gridScrollController.animateTo(gridScrollController.offset + 20,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      } else {
        print('Could not fetch more products');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double padding = size.height * 0.04;
    return Obx(
      () {
        DataReadyStatus status = cp.catalogItemsStatus.value;
        print("STATUS STATUS ${status}");
        if (status == DataReadyStatus.INACTIVE) {
          return EmptyCatalog();
        } else if (status == DataReadyStatus.FETCHING) {
          return BufferingCatalog();
        } else if (status == DataReadyStatus.COMPLETED) {
          if (cp.catalogItemsList.isEmpty) {
            return EmptyCatalog();
          }
          return Stack(
            children: <Widget>[
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFF4F2F0),
                ),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: gridScrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: padding / 2,
                    mainAxisSpacing: padding / 2,
                    childAspectRatio:
                        ((size.width - padding) / 2) / (size.height * 0.4),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.05, horizontal: padding / 2),
                  // padding: EdgeInsets.all(padding / 2),
                  itemCount: cp.catalogItemsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(cp.catalogItemsList[index].avgRating);
                    // if(index < cp.catalogItemsList.length) {
                    return ProductItemCard(
                      product: cp.catalogItemsList[index],
                    );
                    // } else {
                    //   return Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //      SpinKitDoubleBounce(
                    //           color: Color(0xffF2CA8A),
                    //           size: 50.0,
                    //         ),
                    //       Text('Loading more....')
                    //     ],
                    //   );
                    // }
                  },
                ),
              ),
              // added by kruti for displaying pink var with updated value if cart is empty it display default else
              // getContainer widget will display  updated amount
              Provider.of<CartProvider>(context).itemCount == 0
                  ? Container(
                      width: double.infinity,
                      height: 25.0,
                      color: SplashScreenPageColors.freeShippingColor,
                      child: Center(
                        child: Text(freeShippingAmount,
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0)),
                      ))
                  : getContainerWidget(context, size),
            ],
          );
        } else if (status == DataReadyStatus.ERROR) {
          return ErrorCatalog();
        } else {
          return ErrorCatalog();
        }
      },
    );
  }
}

// added by kruti to display pink bar with updated values
Container getContainerWidget(BuildContext context, Size size) {
  // CurrencyController currencycntrl = Get.put(CurrencyController());
  String shippingText = "";
  String freeshipping =
      Provider.of<AccountProvider>(context, listen: false).freeShippingAmount;
  if (Provider.of<CartProvider>(context).cart!.length == 0) {
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

class EmptyCatalog extends StatelessWidget {
  const EmptyCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Color(0xFFF4F2F0),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/warning.png',
              height: 60,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "We can't find products matching the selection. Please try a different filter",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: size.height * 0.02,
                      color: Colors.black,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BufferingCatalog extends StatelessWidget {
  const BufferingCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CatalogBufferingShimmer();
  }
}

class ErrorCatalog extends StatelessWidget {
  const ErrorCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Color(0xFFF4F2F0),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/warning.png',
              height: 60,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Looks like there is an issue on our end... Please try again later',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: size.height * 0.02,
                      color: Colors.black,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
