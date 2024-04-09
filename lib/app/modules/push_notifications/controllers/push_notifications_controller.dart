import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

class PushNotificationsController extends GetxController {
  RxBool trips = true.obs;
  RxBool alerts = true.obs;
  RxBool payments = true.obs;
  RxBool transactions = true.obs;
  RxBool offers = true.obs;

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
      log(data.toString());
    } catch (e) {
      throw Exception(e);
    }
  }
}
