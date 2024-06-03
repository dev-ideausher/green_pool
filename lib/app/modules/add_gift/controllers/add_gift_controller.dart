import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../data/notification_model.dart';

class AddGiftController extends GetxController {
  final RxBool isLoad = true.obs;
  final RxList<NotificationModelData> notifications = RxList<NotificationModelData>([]);

  @override
  Future<void> onInit() async {
    super.onInit();
    await getNotifications();
    isLoad.value = false;
  }

  Future<void> getNotifications() async {
    try {
      final res = await APIManager.notifications();
      final notification = NotificationModel.fromJson(res.data);
      notifications.value = notification.data!;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
