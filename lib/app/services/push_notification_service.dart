import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/messages/controllers/messages_controller.dart';
import 'package:green_pool/app/modules/my_rides_request/controllers/my_rides_request_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';
import '../modules/home/views/noti_bottomsheet.dart';
import '../modules/my_rides_one_time/controllers/my_rides_one_time_controller.dart';

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
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        if (message != null) {
          _handleNotificationClick(message);
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleNotificationClick(message);
      });
      enableIOSNotifications();
      await registerNotificationListeners();
      await getFirebaseToken();
    } catch (e) {
      debugPrint('Error in setupInteractedMessage: $e');
    }
  }

  Future<void> registerNotificationListeners() async {
    final AndroidNotificationChannel channel = androidNotificationChannel();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      if (message == null) return;

      debugPrint('Message received: $message');
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: "logo",
              color: Get.context!.theme.primaryColor,
            ),
          ),
          payload: message.data[
              'notification_type'], // Adding payload for notification click handling
        );
        saveNotification(message);
      }
    });

    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: const AndroidInitializationSettings(
            'logo'), // Ensure 'app_icon' exists
        iOS: DarwinInitializationSettings(
          onDidReceiveLocalNotification: (id, title, body, payload) async {
            // Handle local notification on iOS
          },
        ),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          _handleNotificationClickPayload(response.payload!);
        }
      },
    );
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
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint('Handling background message: ${message.messageId}');
    PushNotificationService(FlutterLocalNotificationsPlugin())
        .saveNotification(message);
  }

  void saveNotification(RemoteMessage message) {
    actionData = message;
    if (actionData != null) {
      debugPrint('Notification data: ${actionData!.data}');
      _handleNotificationType(actionData!.data);
    }
  }

  void _handleNotificationType(Map<String, dynamic> data) {
    final notificationType = data['notification_type'];
    switch (notificationType) {
      case 'Start_Ride':
      case 'Rider_Pickup_Request':
      case 'Rider_Dropoff_Request':
      case 'Rider_Confirm_Request':
      case 'Rider_Cancel_Request':
      case 'Rider_Ride_Request':
      case 'Driver_Ride_Request':
      case 'Driver_Confirm_Request':
      case 'Rider Ride Confirmation':
      case 'Driver Request Accept':
      case 'Rider Request Accept':
      case 'Rider Ride Cancellation':
      case 'Ride Cancellation':
      case 'End Ride':
      case 'Rider New request':
        Get.find<MyRidesOneTimeController>().myRidesAPI();
        break;
      case 'Chat':
        Get.find<MessagesController>().getMessageListAPI();
        break;
      case 'Rider New request':
      case 'Rider Ride Confirmation':
        Get.find<MyRidesRequestController>().allConfirmRequestAPI();
        break;
      default:
        debugPrint('Unknown notification type: $notificationType');
    }
  }

  void _handleNotificationClick(RemoteMessage message) {
    debugPrint('Notification clicked with data: ${message.data}');
    _handleNotificationType(message.data);
  }

  void _handleNotificationClickPayload(String payload) {
    final homeController = Get.find<HomeController>();
    final currentRoute = Get.currentRoute;

    void navigateToBottomNavigation(tabIndex) {
      // Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      homeController.changeTabIndex(tabIndex);
    }

    void navigateToWallet() {
      homeController.changeTabIndex(3);
      Get.toNamed(Routes.WALLET);
    }

    switch (payload) {
      case "Ride Published":
        homeController.changeTabIndex(1);
        break;

      case "Rider New request":
      case "Rider Ride Confirmation":
      case "Rider Request Accept":
      case "Rider Ride Cancellation":
      case "Rider Request Declined":
        if (currentRoute == Routes.BOTTOM_NAVIGATION) {
          homeController.changeTabIndex(1);
        } else if (currentRoute == Routes.MY_RIDES_REQUEST) {
          print("refresh confirm rides page");
        } else {
          navigateToBottomNavigation(1);
        }
        break;

      case "Driver Ride Cancellation":
        // when driver itself cancels the ride
        break;

      case "Payment Received":
        if (currentRoute == Routes.BOTTOM_NAVIGATION) {
          navigateToWallet();
        } else {
          navigateToBottomNavigation(3);
          navigateToWallet();
        }
        break;

      case "Driver New request":
      case "Driver Request Accept":
      case "Driver Ride Confirmation":
      // when rider accepts from confirm section
      case 'Start_Ride':
        // Get.toNamed(Routes.RIDER_START_RIDE_MAP, arguments: actionData?.data);
        // need my rides model data
        if (currentRoute == Routes.BOTTOM_NAVIGATION) {
          homeController.changeTabIndex(1);
        } else {
          navigateToBottomNavigation(1);
        }
        break;

      case "Rider Request":
        // rider sends request from send req section
        if (currentRoute == Routes.BOTTOM_NAVIGATION) {
          homeController.changeTabIndex(1);
        } else {
          navigateToBottomNavigation(1);
        }
        break;

      case "Payment Deduction":
        // when payment deducts from wallet
        break;

      case 'End Ride':
        if (currentRoute == Routes.RIDER_START_RIDE_MAP) {
          Get.offNamed(Routes.RATING_RIDER_SIDE, arguments: actionData?.data);
        } else {
          Get.toNamed(Routes.RATING_RIDER_SIDE, arguments: actionData?.data);
        }
        break;

      case "Chat":
        if (currentRoute != Routes.CHAT_PAGE) {
          if (currentRoute == Routes.BOTTOM_NAVIGATION) {
            homeController.changeTabIndex(2);
          } else {
            navigateToBottomNavigation(2);
          }
        }
        break;

      default:
        debugPrint('Unknown notification type: $payload');
    }

    debugPrint('Notification clicked with payload: $payload');
  }

  static Future<void> subFcm(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }

  static Future<void> unsubFcm(String topic) async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    } catch (e) {
      debugPrint('Error unsubscribing from topic: $e');
    }
  }

  Future<void> getFirebaseToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      debugPrint('Firebase token: $token');
    } catch (e) {
      debugPrint('Error getting Firebase token: $e');
    }
  }
}

/*
void _handleNotificationClickPayload(String payload) {
    //for driver
    if (payload == "Ride Published") {
      Get.find<HomeController>().changeTabIndex(1);
    } else if (payload == "Rider New request") {
      //when rider send req from matching rides
      // and also from send request section
      if (Get.currentRoute == Routes.BOTTOM_NAVIGATION) {
        Get.find<HomeController>().changeTabIndex(1);
      } else if (Get.currentRoute == Routes.MY_RIDES_REQUEST) {
        print("refresh confirm rides page");
      } else {
        Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
        Get.find<HomeController>().changeTabIndex(1);
      }
    } else if (payload == "Rider Ride Confirmation") {
      //when driver accepts from confirm section
      if (Get.currentRoute == Routes.BOTTOM_NAVIGATION) {
        Get.find<HomeController>().changeTabIndex(1);
      } else if (Get.currentRoute == Routes.MY_RIDES_REQUEST) {
        print("refresh confirm rides page");
      } else {
        Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
        Get.find<HomeController>().changeTabIndex(1);
      }
    } else if (payload == "Rider Request Accept") {
      //rider confirm section se accept karega
    } else if (payload == "Rider Ride Cancellation") {
      //when rider cancells from my rides
    } else if (payload == "Rider Request Declined") {
      //when rider rejects from confirm section
    } else if (payload == "Driver Ride Cancellation") {
      //when driver itself cancels the ride
    } else if (payload == "Payment Received") {
      //when driver receives payment
    }

      if (actionData!.data["notification_type"] == "Start_Ride") {
        Get.find<MyRidesOneTimeController>().myRidesAPI();
      } else if (actionData!.data["notification_type"] == "End_Ride") {
        // Get.offNamed(Routes.RATING_RIDER_SIDE);
    // {
    //   "fullName" :
    // }

    //for rider
    if (payload == "Ride Published") {
    } else if (payload == "Driver New request") {
      //when driver send from send ride section
    } else if (payload == "Driver Ride Confirmation") {
      //when rider accepts from confirm section
    } else if (payload == "Driver Request Accept") {
      //when driver accepts from confirm section
    } else if (payload == "Driver Ride Cancellation") {
      //when driver cancels the ride
    } else if (payload == "Rider Request Declined") {
      //driver rejects from confirm section
    } else if (payload == "Payment Deduction") {
      //when payment deducts from wallet
    } else if (payload == 'Rider_Dropoff_Request') {
      Get.off(Routes.RATING_RIDER_SIDE, arguments: actionData?.data);
    }

    //
    if (payload == "Chat") {
      if (Get.currentRoute != Routes.CHAT_PAGE) {
        if (Get.currentRoute == Routes.BOTTOM_NAVIGATION) {
          Get.find<HomeController>().changeTabIndex(2);
        } else {
          Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
          Get.find<HomeController>().changeTabIndex(2);
        }
      }
    }

    debugPrint('Notification clicked with payload: $payload');
  }*/
