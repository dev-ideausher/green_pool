import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/message_list_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../data/chat_arg.dart';
import '../../../routes/app_pages.dart';

class MessagesController extends GetxController {
  RxBool refreshPage = true.obs;
  RxBool isLoading = false.obs;
  final Rx<MessageListModel> messagesModel = MessageListModel().obs;

  @override
  void onInit() {
    super.onInit();
    getMessageListAPI();
  }

  getMessageListAPI() async {
    try {
      isLoading.value = true;
      final resp = await APIManager.getChatList();
      var data = jsonDecode(resp.toString());
      messagesModel.value = MessageListModel.fromJson(data);
      messagesModel.value?.chatRoomIds?.sort((a, b) {
        final dateTimeA =
            DateTime.parse(a!.updatedAt ?? "2024-01-01T00:00:00.000Z");
        final dateTimeB =
            DateTime.parse(b!.updatedAt ?? "2024-01-01T00:00:00.000Z");

        if (dateTimeA == null && dateTimeB == null) {
          return 0;
        } else if (dateTimeA == null) {
          return 1;
        } else if (dateTimeB == null) {
          return -1;
        } else {
          return dateTimeB.compareTo(dateTimeA);
        }
      });
      messagesModel.refresh();
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getToChatPage(message) async {
    Get.toNamed(Routes.CHAT_PAGE,
            arguments: ChatArg(
                chatRoomId: message?.chatRoomId ?? "",
                id: message?.user2?.Id ?? "",
                image: message?.user2?.profilePic?.url,
                deleteUpdateTime: message?.deleteUpdateTime ?? "",
                name: message?.user2?.fullName))!
        .then((value) async {
      if (value != true) {
        final resp = await APIManager.getChatList();
        var data = jsonDecode(resp.toString());
        messagesModel.value = MessageListModel.fromJson(data);
        messagesModel.value?.chatRoomIds?.sort((a, b) {
          final dateTimeA =
              DateTime.parse(a!.updatedAt ?? "2024-01-01T00:00:00.000Z");
          final dateTimeB =
              DateTime.parse(b!.updatedAt ?? "2024-01-01T00:00:00.000Z");

          if (dateTimeA == null && dateTimeB == null) {
            return 0;
          } else if (dateTimeA == null) {
            return 1;
          } else if (dateTimeB == null) {
            return -1;
          } else {
            return dateTimeB.compareTo(dateTimeA);
          }
        });
        messagesModel.refresh();
      } else {
        getMessageListAPI();
      }
    });
  }
}
