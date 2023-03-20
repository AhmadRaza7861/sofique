import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sofiqe/services/notification_services.dart';

final callSetup = <String, dynamic>{
  'ios': {
    'appName': 'Sofiqe',
  },
  'android': {
    'alertTitle': 'Permissions required',
    'alertDescription': 'This application needs to access your phone accounts',
    'cancelButton': 'Cancel',
    'okButton': 'ok',
    // Required to get audio in background when using Android 11
    'foregroundService': {
      'channelId': 'com.company.my',
      'channelName': 'Foreground service for my app',
      'notificationTitle': 'My app is running on background',
      'notificationIcon': 'mipmap/ic_notification_launcher',
    },
  },
};

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  Map<String, dynamic> data = message.data;
  print("ON APP OPENS !!!!!!!!!!!!! $data");
  //NotificationService.showNotification(message);
}

class FirebaseNotification {
  static init() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print("ON App Open");
        print("ON App Open");
        Map<String, dynamic> data = message.data;
        print("ON APP OPENAA !!!!!!!!!!!!! $data");
        NotificationService.showNotification(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      message.data;
      //RemoteNotification? notification = message.notification;
      //AndroidNotification? android = message.notification?.android;
      print("Listen");
      print("When App is open");

      NotificationService.showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      message.data;
      //RemoteNotification? notification = message.notification;
      //AndroidNotification? android = message.notification?.android;
      log("App Open");
      log("App Open");
      log("App Open");

      NotificationService.showNotification(message);

      /*if (data['notification']['type'] != "chat") {
        LocalNotification.showNotification(message);
      }*/
    });
  }
}
