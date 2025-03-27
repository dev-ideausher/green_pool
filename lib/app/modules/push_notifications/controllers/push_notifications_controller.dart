import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/storage.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/snackbar.dart';

class PushNotificationsController extends GetxController {
  RxBool trips = Get.find<GetStorageService>().trips.obs;
  RxBool alerts = Get.find<GetStorageService>().alerts.obs;
  RxBool payments = Get.find<GetStorageService>().payments.obs;
  RxBool transactions = Get.find<GetStorageService>().transactions.obs;
  RxBool offers = Get.find<GetStorageService>().offers.obs;

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
      if (response.data['status']) {
        Get.find<HomeController>().userInfoAPI();
        Get.back();
        showMySnackbar(msg: LocaleKeys.app_noti_pref_updated.tr);
      } else {
        showMySnackbar(msg: response.data["message"].toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
