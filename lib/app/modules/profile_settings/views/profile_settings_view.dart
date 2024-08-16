import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/profile/views/profile_container.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';
import '../controllers/profile_settings_controller.dart';

class ProfileSettingsView extends GetView<ProfileSettingsController> {
  const ProfileSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
                child: SizedBox.fromSize(
                    size: Size.fromRadius(44.kh),
                    child: CommonImageView(
                        height: 44.kh,
                        width: 44.kw,
                        url:
                            "${Get.find<GetStorageService>().profilePicUrl}"))),
          ).paddingOnly(bottom: 8.kh, top: 16.kh),
          Text(
            Get.find<GetStorageService>().getUserName ?? "User",
            style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
          ).paddingOnly(bottom: 24.kh),
          ProfileContainer(
              onTap: () => Get.toNamed(Routes.USER_DETAILS),
              image: ImageConstant.svgProfileDetails,
              text: 'User Details'),
          Get.find<HomeController>().userInfo.value.data?.vehicleStatus == true
              ? ProfileContainer(
                  onTap: () => Get.toNamed(Routes.VEHICLE_DETAILS),
                  image: ImageConstant.svgProfileCar,
                  text: Strings.vehicleDetails)
              : const SizedBox(),
          // ProfileContainer(
          //     onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD),
          //     image: ImageConstant.svgProfileLock,
          //     text: 'Change Password'),
          ProfileContainer(
              onTap: () => Get.toNamed(Routes.EMERGENCY_CONTACTS),
              image: ImageConstant.svgProfileCall,
              text: 'Emergency Contacts'),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}
