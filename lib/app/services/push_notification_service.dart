import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/chat_with_experts/controllers/chat_with_experts_controller.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/messages/controllers/messages_controller.dart';
import 'package:green_pool/app/modules/my_rides_request/controllers/my_rides_request_controller.dart';
import 'package:green_pool/app/modules/rider_confirmed_ride_details/controllers/rider_confirmed_ride_details_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:permission_handler/permission_handler.dart';
import '../data/chat_arg.dart';
import '../data/ride_detail_id.dart';
import '../modules/my_rides_one_time/controllers/my_rides_one_time_controller.dart';
import 'dio/api_service.dart';

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
        _handleNotificationClickPayload(
            actionData?.data['notification_type'] ?? "");
        debugPrint("NotificationResponse: $details");
      },
    );
    try {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } catch (e) {
      debugPrint("onBackgroundMessage error: $e");
    }
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
            )),
            payload: message.data['notification_type'] ?? "");
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
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint("Background Message Handler Working...");

    try {
      actionData = message;
      await Future.delayed(const Duration(seconds: 2));
      saveNotification(message);
      _handleNotificationClickPayload(message.data['notification_type']);
    } catch (e) {
      debugPrint("_firebaseMessagingBackgroundHandler error: $e");
    }
  }

  void saveNotification(RemoteMessage message) {
    actionData = message;
    print("ACTION DATA: ${actionData!.data.toString()}");
    if (actionData != null) {
      debugPrint('Notification data: ${actionData!.data}');
      _handleNotificationType(actionData!.data);
    }
  }

  void _handleNotificationType(Map<String, dynamic> data) {
    final notificationType = data['notification_type'];
    switch (notificationType) {
      case "New Ride Match!":
      case "Ride Cancelled":
      case "Your Driver Has Arrived":
      case "Ride Request Accepted":
      case "Ride Request Declined":
      case "New Ride Request!":
      case "Request Cancelled":
      case "Ride Cancelled by Rider":
      case "Request Declined":
      case "Upcoming Ride Reminder":
      case "Refund Processed":
      case "Refund Issued":
      case "Ride Confirmed!":
        Get.find<MyRidesOneTimeController>().myRidesAPI();
        Get.find<HomeController>().newMsgReceived.value = true;
        break;
      case "Request Accepted!":
        Get.find<HomeController>().newMsgReceived.value = true;
        if (Get.currentRoute == Routes.MY_RIDES_REQUEST) {
          Get.find<MyRidesRequestController>().allConfirmRequestAPI();
          Get.find<MyRidesRequestController>().allSendRequestAPI();
        } else {
          Get.find<MyRidesOneTimeController>().myRidesAPI();
        }
        break;
      case "New Rider Request!":
        Get.find<HomeController>().newMsgReceived.value = true;
        Get.find<MyRidesOneTimeController>().myRidesAPI();
        Get.find<MyRidesRequestController>().allConfirmRequestAPI();
        break;

      case "Payment Received!":
        break;

      case "Ride Completed":
        Get.find<HomeController>().newMsgReceived.value = true;
        if (Get.currentRoute == Routes.RIDER_START_RIDE_MAP) {
          Get.find<MyRidesOneTimeController>().myRidesAPI();
          Get.back();
        } else {
          Get.find<MyRidesOneTimeController>().myRidesAPI();
        }
        break;

      case "Account Suspended":
        Get.find<HomeController>().newMsgReceived.value = true;
        Get.find<GetStorageService>().accSuspended = true;
        Get.find<HomeController>().userInfoAPI();
        break;

      case "Account Active":
        Get.find<HomeController>().newMsgReceived.value = true;
        Get.find<GetStorageService>().accSuspended = false;
        Get.find<HomeController>().userInfoAPI();
        break;
      //

      case 'Chat':
        Get.find<HomeController>().newMsgReceived.value = true;
        Get.find<MessagesController>().getMessageListAPI();
        break;

      case "ChatResolved":
        Get.find<HomeController>().newMsgReceived.value = true;
        Get.find<GetStorageService>().setSupportChatRoomId = "";
        if (Get.currentRoute == Routes.CHAT_WITH_EXPERTS) {
          Get.find<ChatWithExpertsController>().isChatStarted.value = false;
        }
        break;

      case 'Start Ride':
      case 'Start_Ride':
        Get.find<HomeController>().newMsgReceived.value = true;
        if (Get.currentRoute == Routes.RIDER_CONFIRMED_RIDE_DETAILS) {
          Get.find<MyRidesOneTimeController>().myRidesAPI();
          Get.find<RiderConfirmedRideDetailsController>().isRideStarted.value =
              true;
        } else {
          Get.find<MyRidesOneTimeController>().myRidesAPI();
        }
        break;
      default:
        debugPrint('Unknown notification type: $notificationType');
    }
  }

  void _handleNotificationClick(RemoteMessage message) {
    debugPrint('Notification clicked with data: ${message.data}');
    actionData = message;
    _handleNotificationClickPayload(message.data['notification_type'] ?? "");
  }

  Future<void> _handleNotificationClickPayload(String payload) async {
    final homeController = Get.find<HomeController>();
    final currentRoute = Get.currentRoute;

    Future<void> navigateToBottomNavigation(tabIndex) async {
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => homeController.changeTabIndex(tabIndex));
    }

    void navigateToWallet() {
      homeController.changeTabIndex(3);
      Get.toNamed(Routes.WALLET);
    }

    Future<void> navigateToChatPage() async {
      //"chatRoomId" -> "-O4Oour1mIpoIWZsvoHz"
      try {
        final res = await APIManager.getChatRoomId(
            receiverId: actionData?.data['senderId'] ?? "");
        Get.toNamed(Routes.CHAT_PAGE,
            arguments: ChatArg(
                chatRoomId: res.data["data"]["chatRoomId"] ?? "",
                deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
                id: actionData?.data['senderId'],
                name: actionData?.data['name'],
                image: actionData?.data['profilePic']));
      } catch (e) {
        try {
          Get.toNamed(Routes.CHAT_PAGE,
              arguments: ChatArg(
                  chatRoomId: "",
                  deleteUpdateTime: "",
                  id: actionData?.data['senderId'],
                  name: actionData?.data['name'],
                  image: actionData?.data['profilePic']));
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }

    Future<void> navigateToDriversRequestSection() async {
      try {
        //navigate to request section
        Future.delayed(const Duration(seconds: 1)).then(
          (value) async {
            await Get.toNamed(Routes.MY_RIDES_REQUEST,
                arguments: RideDetailId(
                    driverRidId: actionData?.data['rideId'] ?? "",
                    riderRidId: ""));
          },
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    Future<void> navigateToRidersRequestSection() async {
      try {
        //navigate to request section
        Future.delayed(const Duration(seconds: 1)).then(
          (value) async {
            await Get.toNamed(Routes.RIDER_MY_RIDE_REQUEST,
                arguments: actionData?.data['rideId'] ?? "");
          },
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    switch (payload) {
      //for riders
      case "New Ride Match!":
      case "Ride Cancelled":
      case "Your Driver Has Arrived":
      case "Ride Request Accepted":
      case "Request Cancelled":
      case "Ride Cancelled by Rider":
        if (currentRoute == Routes.BOTTOM_NAVIGATION) {
          homeController.changeTabIndex(1);
        } else {
          navigateToBottomNavigation(1);
        }
        break;

      case "Ride Request Declined":
      case "New Ride Request!":
        if (currentRoute == Routes.BOTTOM_NAVIGATION) {
          homeController.changeTabIndex(1);
          await navigateToRidersRequestSection();
        } else if (currentRoute == Routes.RIDER_MY_RIDE_REQUEST) {
          //page will refresh as soon as the notification is received
          print("refresh rider confirm rides page");
        } else {
          await navigateToBottomNavigation(1);
          await navigateToRidersRequestSection();
        }
        break;

      //for drivers
      case "New Rider Request!":
        if (currentRoute == Routes.BOTTOM_NAVIGATION) {
          homeController.changeTabIndex(1);
          await navigateToDriversRequestSection();
        } else if (currentRoute == Routes.MY_RIDES_REQUEST) {
          //page will refresh as soon as the notification is received
          print("refresh confirm rides page");
        } else if (currentRoute == Routes.MY_RIDES_DETAILS) {
          await Get.toNamed(Routes.MY_RIDES_REQUEST,
              arguments: RideDetailId(
                  driverRidId: actionData?.data['rideId'] ?? "",
                  riderRidId: ""));
        } else {
          await navigateToBottomNavigation(1);
          await navigateToDriversRequestSection();
        }
        break;

      case "Request Declined":
        if (currentRoute == Routes.BOTTOM_NAVIGATION) {
          homeController.changeTabIndex(1);
          await navigateToDriversRequestSection();
        } else if (currentRoute == Routes.MY_RIDES_REQUEST) {
          //page will refresh as soon as the notification is received
          print("refresh confirm rides page");
        } else {
          await navigateToBottomNavigation(1);
          await navigateToDriversRequestSection();
        }
        break;

      //
      case "Ride Confirmed!":
      case "Upcoming Ride Reminder":
      case "Request Accepted!":
        if (currentRoute == Routes.BOTTOM_NAVIGATION) {
          homeController.changeTabIndex(1);
        } else {
          navigateToBottomNavigation(1);
        }
        break;

      case "Ride Completed":
        if (currentRoute == Routes.RIDER_START_RIDE_MAP) {
          Get.offNamed(Routes.RATING_RIDER_SIDE, arguments: actionData!.data);
        } else if (currentRoute == Routes.START_RIDE ||
            currentRoute == Routes.RATING_DRIVER_SIDE) {
          print("ride ended");
        } else if (currentRoute == Routes.BOTTOM_NAVIGATION) {
          await Future.delayed(const Duration(seconds: 1)).then((value) async {
            await Get.toNamed(Routes.RATING_RIDER_SIDE,
                arguments: actionData!.data);
          });
        } else {
          await navigateToBottomNavigation(1);
          await Future.delayed(const Duration(seconds: 1)).then((value) async {
            await Get.toNamed(Routes.RATING_RIDER_SIDE,
                arguments: actionData!.data);
          });
        }
        break;

      //payment
      case "Payment Successful":
      case "Refund Processed":
      case "Refund Issued":
      case "Payment Received!":
      case "Payment Refund":
      case "Payment Deduction":
        if (currentRoute == Routes.BOTTOM_NAVIGATION) {
          navigateToWallet();
        } else {
          navigateToBottomNavigation(3);
          navigateToWallet();
        }
        break;

      case "Chat":
        if (currentRoute != Routes.CHAT_PAGE) {
          if (currentRoute == Routes.BOTTOM_NAVIGATION) {
            homeController.changeTabIndex(2);
            await navigateToChatPage();
          } else {
            await navigateToBottomNavigation(2);
            await navigateToChatPage();
          }
        }
        break;

      case "ChatResolved":
        Get.find<GetStorageService>().setSupportChatRoomId = "";
        break;

      case "Ride_Published":
      case 'Start Ride':
      case 'Start_Ride':
        if (currentRoute == Routes.BOTTOM_NAVIGATION ||
            currentRoute == Routes.START_RIDE) {
          homeController.changeTabIndex(1);
        } else {
          navigateToBottomNavigation(1);
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
