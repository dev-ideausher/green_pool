import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/message_list_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

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
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
