import 'package:get/get.dart';
import 'package:green_pool/app/services/snackbar.dart';
import '../../../data/message_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../services/dio/api_service.dart';

class ChatWithExpertsController extends GetxController {
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final ScrollController scrollController = ScrollController();
  String chatRoomId = "";
  final TextEditingController eMsg = TextEditingController();
  final RxBool isLoad = true.obs;
  final RxBool isChatStarted = false.obs;
  final RxBool isBtnActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    addInitialMessage();
  }

  void addInitialMessage() {
    Future.delayed(const Duration(milliseconds: 50), () {
      messages.add(
        MessageModel(
          id: "admin",
          senderId: "admin",
          message:
              "Hi, how can I help you to resolve your queries? Pick a topic to start our chat.",
          timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        ),
      );
      isLoad.value = false;
    });
  }

  getChat() {
    FirebaseDatabase.instance
        .ref()
        .child('userSupportChat')
        .child(chatRoomId)
        .child("messages")
        .onValue
        .listen((event) async {
      var data = event.snapshot.value;
      if (data is Map) {
        final liveLocation =
            DataMsgModel.fromMap(Map<String, dynamic>.from(data));
        messages.value = liveLocation.messages;
        messages.value.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
        messages.value.insert(
          0,
          MessageModel(
            id: "admin",
            senderId: "admin",
            message:
                "Hi, how can I help you to resolve your queries? Pick a topic to start our chat.",
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          ),
        );
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    }, onError: (Object error) {
      debugPrint("Error: $error");
    });
  }

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMsg() async {
    final msg = eMsg.text;
    FocusScope.of(Get.context!).unfocus();
    eMsg.clear();
    try {
      if (!isChatStarted.value) {
        messages.refresh();
        final res =
            await APIManager.userSupportFirstMessage(body: {"issueType": msg});
        if (res.data["message"] == "Chat message written successfully.") {
          eMsg.clear();
          //save the id in storage
          chatRoomId = res.data["chatRoomId"];
          isChatStarted.value = true;
        } else {
          showMySnackbar(msg: res.data["message"]);
        }
      } else {
        messages.refresh();
        final res = await APIManager.userSupportSendMessage(
            body: {"message": msg, "chatRoomId": chatRoomId});
        eMsg.clear();
        //store the id in storage
        chatRoomId = res.data["chatRoomId"];

        //clear the id from storage when Resolved is coming in response
      }
      getChat();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
