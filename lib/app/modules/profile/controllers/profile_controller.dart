import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pool/app/data/user_info_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../services/storage.dart';

class ProfileController extends GetxController {
  RxBool isSwitched = false.obs;
  // RxBool isSwitched = Get.find<GetStorageService>().isPinkMode;
  var userInfo = UserInfoModel().obs;
  RxString fullName = "".obs;

  @override
  void onInit() {
    super.onInit();
    userInfoAPI();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  bool toggleSwitch() {
    isSwitched.value = !isSwitched.value;
    Get.find<GetStorageService>().isPinkMode = isSwitched.value;
    print(Get.find<GetStorageService>().isPinkMode);
    return isSwitched.value;
  }

  userInfoAPI() async {
    final response = await APIManager.getUserByID();
    var data = jsonDecode(response.toString());
    userInfo.value = UserInfoModel.fromJson(data);
    print(response.data.toString());
    fullName.value = userInfo.value.data!.fullName!;
  }
}
