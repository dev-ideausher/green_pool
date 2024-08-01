import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/help_model.dart';

class HelpSupportController extends GetxController {
  final RxBool isLoad = false.obs;
  final RxList<HelpModelData> helpModel = <HelpModelData>[].obs;
  final RxInt selectedIndex = 100.obs;
  var isExpandedList = <RxBool>[].obs;

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
    
  }

  Future<void> gethelpAndSupport() async {
    try {
      final res = await APIManager.helpAndSupport();
      helpModel.value = HelpModel.fromJson(res.data).data!;
      isExpandedList.value = List<RxBool>.generate(
          helpModel.map((element) => element.quesAns).length,
          (index) => false.obs);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  showHide(int index) {
    selectedIndex.value = index;
  }
}
