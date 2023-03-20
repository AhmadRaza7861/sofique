 // ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sofiqe/controller/currencyController.dart';
// <<<<<<< HEAD
import 'package:sofiqe/controller/selectedProductController.dart';
import 'package:sofiqe/provider/banner_provider.dart';
// =======
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
import 'package:sofiqe/provider/catalog_provider.dart';
import 'package:sofiqe/provider/home_provider.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/phone_verification_controller.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/provider/wishlist_provider.dart';
// Utils
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/utils/constants/route_names.dart';
import 'package:sofiqe/utils/db/startup_routine.dart';
import 'package:sofiqe/utils/states/launch_status.dart';

import '../controller/looksController.dart';
import '../controller/msProfileController.dart';
import '../controller/orderProcessing.dart';
import '../controller/questionController.dart';
import '../controller/reviewController.dart';
import '../provider/freeshiping_provider.dart';
import '../services/firebase_notification.dart';
import '../services/notification_services.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    ///todo: uncomment
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    //_setUpDB();
  }

  // Future<void> _setUpDB() async {
  //   if (!_isSet) {
  //     await sfDBStartupRoutine();
  //     // mop.questions= await  ques.getAnaliticalQuestions();
  //     // makeOverProvider.ingredients.value= await sfAPIgetIngredients();
  //     // await makeOverProvider.getQuestionnaireList();
  //     // mop.ingredients = await sfAPIgetIngredients();
  //   }
  // }
  //
  // static bool _isSet = false;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static bool _isSet = false;
  Future<void> _setUpDB() async {
    if (!_isSet) {
      await sfDBStartupRoutine();
      // mop.questions= await  ques.getAnaliticalQuestions();
      // makeOverProvider.ingredients.value= await sfAPIgetIngredients();
      // await makeOverProvider.getQuestionnaireList();
      // mop.ingredients = await sfAPIgetIngredients();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _setUpDB();
      // await Get.put(CartTokenController());
      // await CartTokenController.instance.verifyTokenCall();
      Get.put(ReviewController());
      Get.put(LooksController());
      await Get.find<LooksController>().getLookList();
      Get.put(CatalogProvider());
      // Get.put(HomeProvider());
      Get.put(WishListProvider());
      Get.put(FreeShippingProvider());
      Get.put(PhoneVerificationController());
      Get.put(TryItOnProvider());
      Get.put(PageProvider());
      Get.put(MsProfileController());
      Get.put(QuestionsController());
      Get.put(MakeOverProvider());
      Get.put(SelectedProductController());
      Get.put(CurrencyController());
      Get.put(SelectedProductController());
      Get.put(OrderProcessingController());
      final bannerList = Provider.of<BannerProvider>(context, listen: false);
      await bannerList.getBannerList(context);
      await Get.put(HomeProvider());
      await HomeProvider.to.callAPis();
      _setNextRoute(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (!_isSet) {
    //   _setNextRoute(context);

    //   _isSet = true;
    // }

    // return widget
    return Scaffold(
      backgroundColor: SplashScreenPageColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              highlightColor: Colors.grey[800] as Color,
              baseColor: Colors.white,
              child: Text(
                'sofiqe',
                style: Theme.of(context).textTheme.headline1!.copyWith(
// <<<<<<< HEAD
                      color: SplashScreenPageColors.textColor,
                      fontSize: 50,
                    ),
              ),
            ),
            Text(
              'sophisticated beauty your way',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: SplashScreenPageColors.textColor,
                    fontSize: 16,
                  ),

// =======
//                       color: SplashScreenPageColors.textColor,
//                       fontSize: 50,
//                     ),
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
              // ),
            ),
            // Text(
            //   'beauty your way',
            //   style: Theme.of(context).textTheme.headline1!.copyWith(
            //         color: SplashScreenPageColors.textColor,
            //         fontSize: 16,
            //       ),
            // ),
            // FutureBuilder(
            //     future: Future.delayed(Duration(seconds: 5)),
            //     builder: (c, s) => s.connectionState != ConnectionState.done
            //         ?  Text(
            //       'beauty your way',
            //       style: Theme.of(context).textTheme.headline1!.copyWith(
            //         color: SplashScreenPageColors.textColor,
            //         fontSize: 16,
            //       ),
            //     )
            //         : Text('')
            // )
          ],
        ),
      ),
    );
  }

  void _setNextRoute(BuildContext c) async {
    // Timer(
    //   Duration(seconds: 8),
    //   () async {
    if (await sfDidAppLaunchFirstTime()) {
      Navigator.pushReplacementNamed(c, RouteNames.wizardScreen);
    } else {
      NotificationService.onInitMessage();
      FirebaseNotification.init();
      // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      ///todo: uncomment
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      Navigator.pushReplacementNamed(c, RouteNames.homeScreen);
      // Navigator.pushReplacementNamed(c, RouteNames.wizardScreen);
    }
    //     },
    //   );
  }
}

// // ignore_for_file: deprecated_member_use
//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shimmer/shimmer.dart';
//
// // Utils
// import 'package:sofiqe/utils/constants/app_colors.dart';
// import 'package:sofiqe/utils/constants/route_names.dart';
// import 'package:sofiqe/utils/states/launch_status.dart';
// import 'package:sofiqe/utils/db/startup_routine.dart';
//
// class SplashScreen extends StatefulWidget {
//   SplashScreen() {
//     SystemChrome.setEnabledSystemUIOverlays([]);
//
//     ///todo: uncomment
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//     _setUpDB();
//   }
//   Future<void> _setUpDB() async {
//     if (!_isSet) {
//       await sfDBStartupRoutine();
//       // mop.questions= await  ques.getAnaliticalQuestions();
//       // makeOverProvider.ingredients.value= await sfAPIgetIngredients();
//       // await makeOverProvider.getQuestionnaireList();
//       // mop.ingredients = await sfAPIgetIngredients();
//     }
//   }
//
//   static bool _isSet = false;
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     if (!SplashScreen._isSet) {
//       SplashScreen._isSet = true;
//       _setNextRoute(context);
//     }
//
//     // return widget
//     return Scaffold(
//       backgroundColor: SplashScreenPageColors.backgroundColor,
//       body: Center(
//         child: Shimmer.fromColors(
//           highlightColor: Colors.grey[800] as Color,
//           baseColor: Colors.white,
//           child: Text(
//             'sofiqe',
//             style: Theme.of(context).textTheme.headline1!.copyWith(
//               color: SplashScreenPageColors.textColor,
//               fontSize: 50,
//             ),
//           ),
//         ),
//       ),
//
//     );
//   }
//
//   void _setNextRoute(BuildContext c) {
//     Timer(
//       Duration(seconds: 1),
//           () async {
//         if (await sfDidAppLaunchFirstTime()) {
//           Navigator.pushReplacementNamed(c, RouteNames.wizardScreen);
//         } else {
//           // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//           ///todo: uncomment
//           // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//           Navigator.pushReplacementNamed(c, RouteNames.homeScreen);
//           // Navigator.pushReplacementNamed(c, RouteNames.wizardScreen);
//         }
//       },
//     );
//   }
// }