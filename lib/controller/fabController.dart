import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/scaffold/custom_fab.dart';

class FABController extends GetxController {
    RxBool showFab = true.obs;
    final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
}