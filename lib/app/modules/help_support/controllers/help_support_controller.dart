import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../data/help_model.dart';

class HelpSupportController extends GetxController {
  final RxBool isLoad = false.obs;
  final RxList<HelpModelData> helpModel = <HelpModelData>[].obs;
  // final RxInt selectedIndex = 0.obs;
  var isExpandedMap = <String, RxBool>{}.obs;

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
    Get.toNamed((Routes.CHAT_WITH_EXPERTS));
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
}
