import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import '../modules/my_rides_one_time/controllers/my_rides_one_time_controller.dart';
import '../routes/app_pages.dart';

class PushNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  PushNotificationService(this.flutterLocalNotificationsPlugin);

  RemoteMessage? actionData;

  Future<void> setupInteractedMessage() async {
    try {
      await Permission.notification.isDenied.then((value) async {
        if (value) {
          await Permission.notification.request();
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
        saveNotification(message);
      });
      enableIOSNotifications();
      await registerNotificationListeners();
      await getFirebaseToken();
    } catch (e) {
      print(e);
    }
  }

  Future<void> registerNotificationListeners() async {
    final AndroidNotificationChannel channel = androidNotificationChannel();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    try {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    } catch (e) {
      print(e);
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      if (message == null) return;

      print(message);
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android:
                  AndroidNotificationDetails(channel.id, channel.name, channelDescription: channel.description, icon: "logo", color: Get.context!.iconColor)),
        );
        saveNotification(message);
      }
    });
  }

  Future<void> enableIOSNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  AndroidNotificationChannel androidNotificationChannel() => const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Background Message Handler Working...");

    try {
      await Future.delayed(const Duration(seconds: 2));
      PushNotificationService(FlutterLocalNotificationsPlugin()).saveNotification(message);
    } catch (e) {
      print(e);
    }
  }

  saveNotification(RemoteMessage message) {
    actionData = message;
    if (actionData != null) {
      if (actionData!.data["notification_type"] == "Start_Ride") {
        Get.find<MyRidesOneTimeController>().myRidesAPI();
      }
      if (actionData!.data["notification_type"] == "Rider_Dropoff_Request") {
        Get.find<MyRidesOneTimeController>().myRidesAPI();
      }

      if (actionData!.data["notification_type"] == "Rider_Pickup_Request") {
        Get.find<MyRidesOneTimeController>().myRidesAPI();
      }
      if (actionData!.data["notification_type"] == "Rider_Ride_Request") {
        Get.find<MyRidesOneTimeController>().myRidesAPI();
      }
      if (actionData!.data["notification_type"] == "Driver_Ride_Request") {
        Get.find<MyRidesOneTimeController>().myRidesAPI();
      }

      if (actionData!.data["notification_type"] == "Start_Ride") {
        Get.find<MyRidesOneTimeController>().myRidesAPI();
      } else if (actionData!.data["notification_type"] == "End_Ride") {
        Get.offNamed(Routes.RATING_RIDER_SIDE);
      }
    }
  }

  static Future<void> subFcm(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> unsubFcm(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  Future<void> getFirebaseToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      print(value);
    });
  }
}
