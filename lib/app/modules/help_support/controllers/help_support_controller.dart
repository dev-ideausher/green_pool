import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../data/help_model.dart';
import '../../../data/message_model.dart';
import '../views/support_chat.dart';

class HelpSupportController extends GetxController {
  final RxBool isLoad = false.obs;
  final RxList<HelpModelData> helpModel = <HelpModelData>[].obs;
  // final RxInt selectedIndex = 0.obs;
  var isExpandedMap = <String, RxBool>{}.obs;
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final ScrollController scrollController = ScrollController();
  String chatRoomId = "";
  final TextEditingController eMsg = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await gethelpAndSupport();
    isLoad.value = false;
  }

  // navigateToChat() async {
  //   final url =
  //       "https://wa.me/111111111?text=${Uri.encodeComponent(Strings.howCanWeHelpYou)}";
  //   if (await canLaunch(url)) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  navigateToChatPage() {
    Get.to(() => const SupportChat());
    if (chatRoomId != "") {
      getChat();
    }
  }

  getChat() {
    FirebaseDatabase.instance
        .ref()
        .child('userSupportChat')
        .child(chatRoomId ?? "")
        .child("messages")
        .onValue
        .listen((event) async {
      var data = event.snapshot.value;
      if (data is Map) {
        final liveLocation =
            DataMsgModel.fromMap(Map<String, dynamic>.from(data));
        messages.value = liveLocation.messages;
        messages.value.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
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

  Future<void> gethelpAndSupport() async {
    try {
      final res = await APIManager.helpAndSupport();
      helpModel.value = HelpModel.fromJson(res.data).data!;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showHide(int parentIndex, int itemsIndex) {
    final key = '${parentIndex}_$itemsIndex';
    if (isExpandedMap.containsKey(key)) {
      isExpandedMap[key]!.value = !isExpandedMap[key]!.value;
    } else {
      isExpandedMap[key] = true.obs;
    }
  }

  Future<void> sendMsg() async {
    final msg = eMsg.text;
    FocusScope.of(Get.context!).unfocus();
    eMsg.clear();
    try {
      messages.refresh();
      final res = await APIManager.userSupportSendMessage(
          body: {"message": msg, "chatRoomId": chatRoomId});
      eMsg.clear();
      chatRoomId = res.data["chatRoomId"];
      getChat();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
