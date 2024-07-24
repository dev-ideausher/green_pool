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
  var chatRoomIds;

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
      chatRoomIds = messagesModel.value;
      // chatRoomIds?.sort(
      //     (a, b) => b.lastMessage.dateTime.compareTo(a.lastMessage.dateTime));
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
        .then((value) => getMessageListAPI());
  }
}
