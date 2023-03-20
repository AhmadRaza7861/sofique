import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/total_make_over_provider.dart';
import 'package:sofiqe/utils/constants/route_names.dart';
import 'package:sofiqe/widgets/png_icon.dart';

import '../../../provider/cart_provider.dart';

class TotalMakeOverTopMenu extends StatelessWidget {
  TotalMakeOverTopMenu({Key? key}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.03, horizontal: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: Obx(
              () {
                if (tmo.currentSelectedArea.value != 0) {
                  return SearchIcon();
                } else {
                  return Container(
                    width: AppBar().preferredSize.height * 0.7,
                  );
                }
              },
            ),
          ),
          _Heading(),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: ShoppingBagButton(),
          ),
        ],
      ),
    );
  }
}

class SearchIcon extends StatelessWidget {
  SearchIcon({Key? key}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tmo.toggleSearch();
      },
      child: Container(
        height: AppBar().preferredSize.height * 0.7,
        width: AppBar().preferredSize.height * 0.7,
        decoration: BoxDecoration(
          color: Color(0xFFF2CA8A),
          borderRadius: BorderRadius.all(
              Radius.circular(AppBar().preferredSize.height * 0.7)),
        ),
        child: PngIcon(
          image: 'assets/icons/search_black.png',
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  _Heading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Text(
            'sofiqe',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Colors.white,
                  fontSize: size.height * 0.035,
                ),
          ),
        ],
      ),
    );
  }
}

class ShoppingBagButton extends StatelessWidget {
  const ShoppingBagButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// <<<<<<< HEAD
//     var cartItems = Provider.of<CartProvider>(context).cart!.length;
// =======
    var cartItems = Provider.of<CartProvider>(context).itemCount;
    var cartTotalQty = Provider.of<CartProvider>(context).getTotalQty();
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.cartScreen, arguments: {
          'empty_bag_button_text': 'GO BACK',
        });
      },
      child: Container(
        height: AppBar().preferredSize.height * 0.7,
        width: AppBar().preferredSize.height * 0.7,
        decoration: BoxDecoration(
          color: Color(0xFFF4F2F0),
          borderRadius: BorderRadius.all(
              Radius.circular(AppBar().preferredSize.height * 0.7)),
        ),
        child: Stack(
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
    );
  }
}
