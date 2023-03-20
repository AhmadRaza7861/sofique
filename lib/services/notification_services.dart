import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import '../screens/catalog_screen.dart';
import '../screens/product_detail_1_screen.dart';
import 'other_filer_services.dart';

class NotificationService {
  static void _launchScreen(Map<String, dynamic>? data) {
    print("FIRST ON TAP");
    print(data);
    if (data != null) {
      if (gContext.currentState != null) {
        print("Notification Tapped");
        final context = gContext.currentState!.context;
        getJson(data, name: "Data On Notification Tapped");
        if (data['type'] == "SKU") {
          print("SKU PRODUCT");
          push(context: context, screen: ProductDetail1Screen(sku: data['id']));
        } else if (data['type'] == "Campaign") {
          print("CAMPAIGN PRODUCT");
          push(context: context, screen: CatalogScreen());
        }
      }
    }
  }

  static void onInitMessage() async {
    /// This will call when app will open from notification tap
    FirebaseMessaging.instance.getInitialMessage().then((data) {
      if (data != null) {
        _launchScreen(data.data);
      }
    });
  }

  ///
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    sound: RawResourceAndroidNotificationSound('@mipmap/ic_launcher'),
  );

  ///
  static void showNotification(RemoteMessage message) async {
    print("Showing Notification");
    getJson(message.data);
    flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification!.title!,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data));
  }

  /// Background Handler Method
  static Future<void> _firebaseBackgroundNotificationHandler(RemoteMessage message) async {
    getJson(message.data);
    _launchScreen(message.data);
  }

  static int i = 0;

  static Future<void> init() async {
    log("Notification Service Started", name: "NOTIFICATION SERVICE");
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundNotificationHandler);

    /// This will show when any firebase push notification is received..
    FirebaseMessaging.onMessageOpenedApp.listen((data) {
      print("Background Notification --> ${data.data.toString()}");
      getJson(data.data);
      _launchScreen(data.data);
    });

    /// This will call when app will open from notification tap

    ///Init android settings
    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Init IOS settings
    const DarwinInitializationSettings initSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        Map<String, dynamic> _data = json.decode(payload.payload!);
        _launchScreen(_data);
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Notification settings
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    ///
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: Platform.isIOS ? false : true,
      badge: Platform.isIOS ? false : true,
      sound: Platform.isIOS ? false : true,
    );

    await FirebaseMessaging.instance.getToken().then((value) => print("FCM TOKEN: $value"));

    /// Foreground Notification Stream..
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final status = await FirebaseAuth.instance.authStateChanges().first;
      if (status != null) {
        showNotification(message);
      }
    });
  }
}
