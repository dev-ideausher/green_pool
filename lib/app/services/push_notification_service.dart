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
      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
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

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

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
          payload: message.data['notification_type'], // Adding payload for notification click handling
        );
        saveNotification(message);
      }
    });

    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: const AndroidInitializationSettings('logo'), // Ensure 'app_icon' exists
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
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  AndroidNotificationChannel androidNotificationChannel() => const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint('Handling background message: ${message.messageId}');
    PushNotificationService(FlutterLocalNotificationsPlugin()).saveNotification(message);
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
      case 'Start Ride':
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
      case 'End_Ride':
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

    Future<void> navigateToBottomNavigation(tabIndex) async {
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      await Future.delayed(const Duration(seconds: 1)).then((value) => homeController.changeTabIndex(tabIndex));
    }

    void navigateToWallet() {
      homeController.changeTabIndex(3);
      Get.toNamed(Routes.WALLET);
    }

    switch (payload) {
      case "Ride Published":
        homeController.changeTabIndex(1);
        break;

      case "Rider New Request":
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
      case "Payment Refund":
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
      case 'Start Ride':
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

      case 'End_Ride':
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
/* TO COMPARE
class PushNotificationService {
  Future<void> setupInteractedMessage() async {
    try {
      await Permission.notification.isDenied.then((value) {
        if (value) {
          Permission.notification.request();
        }
      });
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        await Future.delayed(const Duration(seconds: 2));
        saveNotification(message);
      });
      await registerNotificationListeners();
      await getFirebaseToken();
    } catch (e) {
      log(e.toString());
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
      requestAlertPermission: true,
    );
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {},
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
                color: ColorUtil.kAccent1),
          ),
        );

        saveNotification(message);
      }
    });
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
      if (message.data["notification_type"] == "chat") {
        var jsonc = {"user1Name": "Test User", "user1profilePic": ""};
        await FlutterCallkitIncoming.showCallkitIncoming(
            Tools().callKitparams(data: jsonc));
      }
      saveNotification(message);
    } catch (e) {
      print(e);
    }
  }

  saveNotification(RemoteMessage message) async {
    try {
      bool isReg = Get.isRegistered<MessagesPageController>();
      if (!isReg) {
        Get.put(MessagesPageController());
      }
      if (message.data["notification_type"] == "chat") {
        Map<String, dynamic> jsond = json.decode(message.data["chat_data"]);
        var msg = MessageModel.fromJson(jsond);
        if (Get.currentRoute == Routes.CHAT_MESSAGE_PAGE) {
          if (message.data["chat_data"].isNotEmpty &&
              msg.primaryUserId.toString() !=
                  Get.find<GetStorageService>().id) {
            Get.find<ChatMessagePageController>().addMessage(chatMessage: msg);
          }
        } else {
          UserModel? userModel;
          try {
            await APIManager.getUserById(id: msg.primaryUserId.toString())
                .then((value) {
              if (value.data["status"]) {
                userModel =
                    UserModel.fromJson(value.data["data"]["usersDetails"][0]);

                Get.toNamed(Routes.CHAT_MESSAGE_PAGE, arguments: {
                  "userModel": userModel,
                  "ChannelId": msg.channelId
                });
              } else {
                showMySnackbar(msg: value.data["message"]);
              }
            });
          } catch (e) {
            log(e.toString());
          }
        }
      } else if (message.data["notification_type"] == "call") {
        // var jsonc = json.decode(message.data["payload"]);
        var jsonc = {"user1Name": "Test User", "user1profilePic": ""};

        await FlutterCallkitIncoming.showCallkitIncoming(
            Tools().callKitparams(data: jsonc));
      }
      /*else if (message.data["notification_type"] == "confirmed") {
        Get.dialog(AppointmentConfirm(
          onCancel: () async {
            Get.offAllNamed(Routes.MAIN_PAGE);
            await Future.delayed(const Duration(seconds: 1));
            Get.find<MainPageController>().updatePage(1);
          },
          title: message.notification?.title.toString() ?? "",
          desc: message.notification?.body.toString() ?? "",
        ));
      } else if (message.data["notification_type"] == "booked") {
        Get.dialog(AppointmentConfirm(
          onCancel: () async {
            Get.offAllNamed(Routes.MAIN_PAGE);
            await Future.delayed(const Duration(seconds: 1));
            Get.find<MainPageController>().updatePage(1);
          },
          title: message.notification?.title.toString() ?? "",
          desc: message.notification?.body.toString() ?? "",
        ));
      }*/
      // Get.find<MyNotificationsController>().getNotification();
      Get.find<MessagesPageController>().getAllUsersChannel();
    } catch (e) {
      print("Error in token listened");
      print(e);
    }
  }

  static Future<void> subFcm(String topic) async {
    print("Subscribed------");
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
    await FirebaseMessaging.instance.getToken().then((value) {});
  }
}
*/

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
