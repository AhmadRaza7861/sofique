// ignore_for_file: deprecated_member_use, await_only_futures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/wishlist_provider.dart';
import 'package:sofiqe/widgets/png_icon.dart';

class WishListWhite extends StatelessWidget {
  final String sku;
  final int itemId;
  WishListWhite({
    Key? key,
    required this.sku,
    required this.itemId,
  }) : super(key: key);

  final WishListProvider wp = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (wp.wishlistSkuList.any((element) => element.sku == sku)) {
          return GestureDetector(
            onTap: () async {
              if (Provider.of<AccountProvider>(context, listen: false)
                  .isLoggedIn) {
                wp.removeItemToWishList(sku);
              } else {
                wp.saveInLocalWishList(sku, itemId,false);
              }
            },
            child: _AddedToWishList(),
          );
        } else {
          return GestureDetector(
            onTap: () {
              if (Provider.of<AccountProvider>(context, listen: false)
                  .isLoggedIn) {
                int customerId =
                    Provider.of<AccountProvider>(context, listen: false)
                        .customerId;
                wp.addItemToWishList(sku, itemId, customerId);
              } else {
                wp.saveInLocalWishList(sku, itemId,true);
              }
            },
            child: _NotAddedToWishList(),
          );
        }
      },
    );
  }
}

class WishListNew extends StatelessWidget {
  final String sku;
  final int itemId;
  WishListNew({
    Key? key,
    required this.sku,
    required this.itemId,
  }) : super(key: key);

  final WishListProvider wp = Get.find();

  @override
  Widget build(BuildContext context) {

    return Obx(
          () {
        if (wp.wishlistSkuList.any((element) => element.sku == sku)) {
          return GestureDetector(
            onTap: () async {
              if (Provider.of<AccountProvider>(context, listen: false)
                  .isLoggedIn) {
                wp.removeItemToWishList(sku);
              } else {
                wp.saveInLocalWishList(sku, itemId,false);
              }
            },
            child: Icon(Icons.favorite_outlined,color: Colors.red),
          );
        } else {
          return GestureDetector(
            onTap: () {
              if (Provider.of<AccountProvider>(context, listen: false)
                  .isLoggedIn) {
                int customerId =
                    Provider.of<AccountProvider>(context, listen: false)
                        .customerId;
                wp.addItemToWishList(sku, itemId, customerId);
              } else {
                wp.saveInLocalWishList(sku, itemId,true);
              }
            },
            child:  Icon(Icons.favorite_border_outlined,color: Colors.grey),
          );
        }
      },
    );
  }
}

class _NotAddedToWishList extends StatelessWidget {
  const _NotAddedToWishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PngIcon(image: 'assets/icons/wishlist_white.png');
  }
}

class _AddedToWishList extends StatelessWidget {
  const _AddedToWishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PngIcon(image: 'assets/icons/wishlist_active_new.png');
  }
}
