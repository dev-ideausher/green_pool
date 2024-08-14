import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/message_model.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../data/chat_arg.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/dio/api_service.dart';

class ChatPageController extends GetxController {
  final Rx<ChatArg> chatArg = ChatArg().obs;
  final RxBool isLoad = true.obs;
  final RxBool sendingMsg = false.obs;
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

  void readMsg() async {
    try {
      await APIManager.getChatRoomId(receiverId: chatArg.value.id!);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getChat() async {
    FirebaseDatabase.instance
        .ref()
        .child('chats')
        .child(chatArg.value.chatRoomId ?? "")
        .child("messages")
        .onValue
        .listen((event) async {
      var data = event.snapshot.value;
      if (data is Map) {
        final liveLocation =
            DataMsgModel.fromMap(Map<String, dynamic>.from(data));
        messages.value = liveLocation.messages;
        messages.value.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
        try {
          if (chatArg.value.deleteUpdateTime != null ||
              chatArg.value.deleteUpdateTime != "") {
            messages.value.removeWhere((item) => item.timestamp.isBefore(
                DateTime.parse(chatArg.value.deleteUpdateTime ?? "")));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
      readMsg();
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
      duration: const Duration(milliseconds: 200),
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
    final timestamp = DateTime.now().toUtc();
    final senderId = Get.find<GetStorageService>().getUserAppId;
    try {
      messages.value.add(MessageModel(
          id: chatArg.value.chatRoomId ?? "",
          message: msg,
          senderId: senderId ?? "",
          timestamp: timestamp));
      messages.refresh();
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      final res = await APIManager.sendMessage(
          body: {"message": msg, "receiverId": chatArg.value.id});
      eMsg.clear();
      chatArg.value.chatRoomId = res.data["chatRoomId"];
      getChat();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  deleteChat() {
    Get.dialog(
      useSafeArea: true,
      Center(
        child: Container(
          padding: EdgeInsets.all(16.kh),
          height: 212.kh,
          width: 80.w,
          decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.circular(8.kh),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.close),
                ),
              ),
              Text(
                Strings.delete,
                style: TextStyleUtil.k18Semibold(),
                textAlign: TextAlign.left,
              ).paddingSymmetric(vertical: 4.kh),
              Text(
                Strings.areYouSureYouWantToDeleteThisChat,
                style: TextStyleUtil.k14Regular(
                  color: ColorUtil.kBlack04,
                ),
                textAlign: TextAlign.left,
              ).paddingOnly(bottom: 40.kh),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GreenPoolButton(
                    onPressed: () {
                      Get.back();
                    },
                    isBorder: true,
                    height: 40.kh,
                    width: 124.kw,
                    label: Strings.cancel,
                    fontSize: 14.kh,
                    padding: const EdgeInsets.all(8),
                  ),
                  GreenPoolButton(
                    onPressed: () {
                      Get.back();
                      deleteChatApi();
                    },
                    height: 40.kh,
                    width: 124.kw,
                    label: Strings.delete,
                    fontSize: 14.kh,
                    padding: const EdgeInsets.all(8),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteChatApi() async {
    try {
      final res = await APIManager.deleteChat(
          chatRoomId: chatArg.value.chatRoomId ?? "");
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
