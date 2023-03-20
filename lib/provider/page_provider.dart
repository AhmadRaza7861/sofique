import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

class PageProvider extends GetxController {
  late RxInt page;
  late RxInt lastPage;
  late PageController controller;
  late void Function(int) onTapCallback;

  PageProvider() {
    setDefaults();
  }

  Future<void> share(prodUrl, title) async {
    await FlutterShare.share(
        title: title, text: title, linkUrl: prodUrl, chooserTitle: 'Share');
  }

  void goToPage(Pages p) async {
    switch (p) {
      case Pages.HOME:
        page.value = 0;
        onTapCallback(0);
        break;
      case Pages.TRYITON:
        page.value = 1;
        onTapCallback(1);
        break;
      case Pages.SHOP:
        page.value = 2;
        onTapCallback(2);
        break;

      case Pages.MAKEOVER:
        page.value = 3;
        onTapCallback(3);
        break;

      case Pages.MYSOFIQE:
        page.value = 4;
        onTapCallback(4);
        break;

    }
  }

  void setDefaults() {
    page = 0.obs;
  }
}

enum Pages { HOME, TRYITON ,SHOP, MAKEOVER, MYSOFIQE }
