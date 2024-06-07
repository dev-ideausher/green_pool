import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

class PushNotificationsController extends GetxController {
  RxBool trips = Get.find<HomeController>()
      .userInfo
      .value
      .data!
      .notificationPreferences!
      .trip!
      .obs;
  RxBool alerts = Get.find<HomeController>()
      .userInfo
      .value
      .data!
      .notificationPreferences!
      .alerts!
      .obs;
  RxBool payments = Get.find<HomeController>()
      .userInfo
      .value
      .data!
      .notificationPreferences!
      .payments!
      .obs;
  RxBool transactions = Get.find<HomeController>()
      .userInfo
      .value
      .data!
      .notificationPreferences!
      .transactions!
      .obs;
  RxBool offers = Get.find<HomeController>()
      .userInfo
      .value
      .data!
      .notificationPreferences!
      .offers!
      .obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  notificationPreferencesAPI() async {
    final Map<String, dynamic> notiPrefData = {
      "notificationPreferences": {
        "trip": trips.value,
        "alerts": alerts.value,
        "payments": payments.value,
        "transactions": transactions.value,
        "offers": offers.value
      }
    };

    try {
      final response =
          await APIManager.notificationPreferences(body: notiPrefData);
      var data = jsonDecode(response.toString());
      Get.find<HomeController>().userInfoAPI();
    } catch (e) {
      throw Exception(e);
    }
  }
}
