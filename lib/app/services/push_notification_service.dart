import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import '../routes/app_pages.dart';

class PushNotificationService {
  RemoteMessage? actionData;

  Future<void> setupInteractedMessage() async {
    try {
      await Permission.notification.isDenied.then((value) async {
        if (value) {
          await Permission.notification.request();
        }
      });
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
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
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('logo');
    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true);
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        if (actionData != null) {
          if (actionData!.data["type"] == "Start_Ride") {
            Get.toNamed(Routes.RIDER_START_RIDE_MAP);
          } else if (actionData!.data["type"] == "End_Ride") {
            //TODO: HAVE TO SET A CHECK FOR RIDER
            //? one thing that can be done is that in response of end ride the data will contain who was driver and who were the companions and then from there we can maybe check and navigate them to corresponding pages
            //? OR else set driver state from home controller and store it in storage service
            if (Get.find<HomeController>().userInfo.value.data?.isDriver ==
                true) {
              Get.offNamed(Routes.RATING_DRIVER_SIDE);
            } else {
              Get.offNamed(Routes.RATING_RIDER_SIDE);
            }
          }
        }
        print(details);

        // if (actionData != null) {
        //   if (actionData!.data["type"] == "Start_Ride") {
        //     Map<String, dynamic> jsond = json.decode(actionData!.data["rideDetails"]);
        //     // final rideDetails = ChatNotificationModel.fromJson(jsond);
        //     if (Get.currentRoute == Routes.CHAT) {
        //       if (Get.find<ChatController>().chatRoom.value.chatRoomId == rideDetails.chatRoomId) {
        //         Get.find<ChatController>().getMessages();
        //       }
        //     } else {
        //       ChatRoomModelChatRoom chatRoomModelChatRoom;
        //       if (Get.find<GetStorageService>().userId == (rideDetails.senderData?.senderId ?? "")) {
        //         chatRoomModelChatRoom = ChatRoomModelChatRoom(
        //             name: rideDetails.senderData?.name,
        //             Id: rideDetails.senderData?.rideId,
        //             rideId: rideDetails.senderData?.senderId,
        //             image: "",
        //             chatRoomId: rideDetails.chatRoomId);
        //       } else {
        //         chatRoomModelChatRoom = ChatRoomModelChatRoom(
        //             name: rideDetails.senderData?.name,
        //             Id: rideDetails.senderData?.senderId,
        //             rideId: rideDetails.senderData?.rideId,
        //             image: "",
        //             chatRoomId: rideDetails.chatRoomId);
        //       }
        //       Get.toNamed(Routes.CHAT, arguments: chatRoomModelChatRoom);
        //     }
        //   }
        // }
        // print(details);
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        print(details);
      },
    );
    try {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
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
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  icon: "logo",
                  color: ColorUtil.kPrimary07)), //?color
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
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Background Message Handler Working...");

    try {
      await Future.delayed(const Duration(seconds: 2));
      saveNotification(message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  saveNotification(RemoteMessage message) {
    actionData = message;
    // try {
    //   if (message.data["type"] == "request") {

    //   } else if (message.data["type"] == "Completed") {
    //     Map<String, dynamic> jsond = json.decode(message.data["rideDetails"]);
    //     final rideDetails = UserRideComplete.fromJson(jsond);
    //     Get.offAllNamed(Routes.ORDER_SUMMARY_USER, arguments: rideDetails);
    //     /* Get.dialog(CancelRide(
    //       title: message.notification?.title,
    //       content: "Would you like to rate your experience",
    //       onPressYes: () {

    //       },
    //     ));*/
    //   } else if (message.data["type"] == "accept") {
    //   } else if (message.data["type"] == "chat") {
    //     if (Get.currentRoute == Routes.CHAT) {
    //       Map<String, dynamic> jsond = json.decode(message.data["rideDetails"]);
    //       final rideDetails = ChatNotificationModel.fromJson(jsond);
    //       if (Get.find<ChatController>().chatRoom.value.chatRoomId == rideDetails.chatRoomId) {
    //         Get.find<ChatController>().getMessages();
    //       }
    //     }
    //     //
    //   }
    // } catch (e) {
    //   debugPrint(e.toString());

    // }
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
