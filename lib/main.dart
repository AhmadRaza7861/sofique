// Libraries commented for testing purpose of background service
// import 'dart:async';
import 'dart:io';
// import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sofiqe/controller/nav_controller.dart';
// import 'package:sofiqe/provider/catalog_provider.dart';
// import 'package:sofiqe/provider/freeshiping_provider.dart';
// import 'package:sofiqe/provider/home_provider.dart';
// import 'package:sofiqe/provider/make_over_provider.dart';
// import 'package:sofiqe/provider/page_provider.dart';
// import 'package:sofiqe/provider/phone_verification_controller.dart';
// import 'package:sofiqe/provider/try_it_on_provider.dart';
// import 'package:sofiqe/provider/wishlist_provider.dart';
import 'package:sofiqe/services/firebase_notification.dart';
import 'package:sofiqe/services/notification_services.dart';
import 'package:sofiqe/sofiqe.dart';
// import 'package:sofiqe/utils/db/startup_routine.dart';

// import 'controller/currencyController.dart';
import 'controller/fabController.dart';
// import 'controller/msProfileController.dart';
// import 'controller/questionController.dart';

///
/// we put controller at the start only for testing purpose
/// you can put on exect location

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  // Commented for testing purporse >>>>>>>>>
  WidgetsFlutterBinding.ensureInitialized();
  // Get.put(WishListProvider());
  // Get.put(MsProfileController());
  // Get.put(QuestionsController());
  // Get.put(MakeOverProvider());
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays:[]).then(
  //         (_) => runApp(MyApp()),
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
      overlays: [SystemUiOverlay.top]);

  // SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarBrightness: Brightness.dark
  //   // systemNavigationBarColor: Colors.blue, // navigation bar color
  //   // statusBarColor: Colors.pink, // status bar color
  // ));

//
  await Firebase.initializeApp();
  Stripe.publishableKey =
  "pk_test_51Ge2zLHMAWs8sg7x0WJkDfJGFVH3mTbPatdgowjkSKFWn1UL5igV0j7wwv6IbdBGYhoofzGBcAa90CJvj5mlm8jz00BB7dkElF";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await FirebaseNotification.init();
  await NotificationService.init();

  Get.put(FABController());
  // await initializeService();
  runApp(Sofiqe(
    gcontext: gContext,
  ));
}

final gContext = GlobalKey<NavigatorState>();
// >>>>>>>>>>>>> commented for testing purpose

// Future<void> initializeService() async {
//   print("KK initialize service called");
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,

//       // auto start service
//       autoStart: false,
//       isForegroundMode: false,
//     ),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: false,

//       // this will be executed when app is in foreground in separated isolate
//       onForeground: onStart,

//       // you have to enable background fetch capability on xcode project
//       onBackground: onIosBackground,
//     ),
//   );
//   service.startService();
// }

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
// >>>>>>>>>>>>>> Commented for testing purporse
// bool onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();
//   print('FLUTTER BACKGROUND FETCH');
//   sfDBStartupRoutine();
//   Get.put(CatalogProvider());
//   Get.put(WishListProvider());
//   Get.put(FreeShippingProvider());
//   Get.put(PhoneVerificationController());
//   Get.put(HomeProvider());
//   Get.put(TryItOnProvider());
//   Get.put(PageProvider());
//   Get.put(MsProfileController());
//   Get.put(QuestionsController());
//   Get.put(MakeOverProvider());
//   Get.put(CurrencyController());

//   Get.put(NavController());

//   return true;
// }

@pragma('vm:entry-point')
// >>>>>>>>>> Commented for testing purpose
// void onStart(ServiceInstance service) async {
//   // Only available for flutter 3.0.0 and later
//   // DartPluginRegistrant.ensureInitialized();

//   // For flutter prior to version 3.0.0
//   // We have to register the plugin manually

//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.setString("hello", "world");
//   print("KK on start api called");
//   // CallApis();
//   //print("CallApisState class");
//   Get.put(NavController());
//   await sfDBStartupRoutine();
//   Get.put(CatalogProvider());
//   Get.put(WishListProvider());
//   Get.put(FreeShippingProvider());
//   Get.put(PhoneVerificationController());
//   Get.put(HomeProvider());
//   Get.put(TryItOnProvider());
//   Get.put(PageProvider());
//   Get.put(MsProfileController());
//   Get.put(QuestionsController());
//   Get.put(MakeOverProvider());
//   Get.put(CurrencyController());

//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//       print("KK setAsForeground");
//     });

//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//       print("setAsBackground");
//     });
//   }

//   service.on('stopService').listen((event) {
//     service.stopSelf();
//     print("KK stop service");
//   });
//   // bring to foreground
//   // Timer.periodic(const Duration(seconds: 1), (timer) async {
//   //   final hello = preferences.getString("hello");
//   //   print(hello);
//   //
//   //   if (service is AndroidServiceInstance) {
//   //     service.setForegroundNotificationInfo(
//   //       title: "My App Service",
//   //       content: "Updated at ${DateTime.now()}",
//   //     );u
//   //   }
//   //
//   //   /// you can see this log in logcat
//   //   print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
//   //
//   //   // test using external plugin
//   //   final deviceInfo = DeviceInfoPlugin();
//   //   String? device;
//   //   if (Platform.isAndroid) {
//   //     final androidInfo = await deviceInfo.androidInfo;
//   //     device = androidInfo.model;
//   //   }
//   //
//   //   if (Platform.isIOS) {
//   //     final iosInfo = await deviceInfo.iosInfo;
//   //     device = iosInfo.model;
//   //   }
//   //
//   //   service.invoke(
//   //     'update',
//   //     {
//   //       "current_date": DateTime.now().toIso8601String(),
//   //       "device": device,
//   //     },
//   //   );
//   // });
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}