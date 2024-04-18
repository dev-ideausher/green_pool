import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/message_model.dart';

import '../../../data/chat_arg.dart';
import '../../../services/dio/api_service.dart';

class ChatPageController extends GetxController {
  final Rx<ChatArg> chatArg = ChatArg().obs;
  final RxBool isLoad = true.obs;
  final TextEditingController eMsg = TextEditingController();
  ScrollController scrollController = ScrollController();
  final RxList<MessageModel> messages = <MessageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    chatArg.value = Get.arguments;
    if (chatArg.value.chatRoomId != null) {
      getChat();
    }
    isLoad.value = false;
  }

  void getChat() {
    FirebaseDatabase.instance.ref().child('chats').child(chatArg.value.chatRoomId ?? "").child("messages").onValue.listen((event) async {
      var data = event.snapshot.value;
      if (data is Map) {
        final liveLocation = DataMsgModel.fromMap(Map<String, dynamic>.from(data));
        messages.value = liveLocation.messages;
        _scrollToBottom();
      }
    }, onError: (Object error) {
      debugPrint("Error: $error");
    });
  }

  void _scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent + 100, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  sendMsg() async {
    if (eMsg.text.trim().isEmpty) {
      return;
    } else {
      await setMessageInApi();
    }
  }

  Future<void> setMessageInApi() async {
    final msg = eMsg.text;
    eMsg.clear();

    try {
      final res = await APIManager.sendMessage(body: {"message": msg, "receiverId": chatArg.value.id, "ridePostId": chatArg.value.rideId});
      eMsg.clear();
      FocusScope.of(Get.context!).unfocus();
      chatArg.value.chatRoomId = res.data["chatRoomId"];
      getChat();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
