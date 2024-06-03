import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/message_model.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/chat_arg.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/dio/api_service.dart';

class ChatPageController extends GetxController {
  final Rx<ChatArg> chatArg = ChatArg().obs;
  final RxBool isLoad = true.obs;
  final TextEditingController eMsg = TextEditingController();
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final ScrollController scrollController = ScrollController();
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
        messages.value.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    }, onError: (Object error) {
      debugPrint("Error: $error");
    });
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
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
      final res = await APIManager.sendMessage(body: {"message": msg, "receiverId": chatArg.value.id});
      eMsg.clear();
      FocusScope.of(Get.context!).unfocus();
      chatArg.value.chatRoomId = res.data["chatRoomId"];
      getChat();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  deleteChat() {
    Get.defaultDialog(
      title: Strings.deleteChat,
      content: Text(Strings.areYouSureYouWantToDeleteThisChat),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            Strings.cancel,
            style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack03),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
            deleteChatApi();
          },
          child: Text(Strings.delete, style: TextStyleUtil.k14Bold(color: ColorUtil.kError4)),
        ),
      ],
    );
  }

  Future<void> deleteChatApi() async {
    try {
      final res = await APIManager.deleteChat(chatRoomId: chatArg.value.chatRoomId ?? "");
      Get.back();
      showMySnackbar(msg: res.data["message"]);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  call() {
    // launchUrl(Uri.parse("tel:${chatArg.value.phone}"));
  }
}
