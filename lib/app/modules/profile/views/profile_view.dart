import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/auth.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/push_notification_service.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/text_style_util.dart';
import '../controllers/profile_controller.dart';
import 'profile_container.dart';
import 'rating_bottomsheet.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Profile'),
        leading: SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.USER_DETAILS);
              },
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                    child: SizedBox.fromSize(
                        size: Size.fromRadius(44.kh),
                        child: controller.userInfo.value.data?.profilePic?.url == null
                            ? Icon(Icons.account_circle, size: 84.kh)
                            : CommonImageView(height: 44.kh, width: 44.kw, url: controller.userInfo.value.data!.profilePic?.url))),
              ).paddingOnly(bottom: 8.kh, top: 16.kh),
            ),
            Text(
              controller.userInfo.value.data?.fullName ?? 'User',
              style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
            ).paddingOnly(bottom: 24.kh),
            controller.userInfo.value.data?.gender == "Female"
                ? ProfileContainer(
                    image: ImageConstant.svgProfileShieldPink,
                    text: 'Activate Pink Mode',
                    info: GestureDetector(
                        onTap: () => Get.dialog(
                              useSafeArea: true,
                              Center(
                                child: Container(
                                    padding: EdgeInsets.all(16.kh),
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      color: ColorUtil.kWhiteColor,
                                      borderRadius: BorderRadius.circular(8.kh),
                                    ),
                                    child: Text(
                                      "Travel with confidence in our 'Pink Mode'\nensuring safety and security with female\nriders and drivers.",
                                      style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                                    )),
                              ),
                            ),
                        child: SvgPicture.asset(ImageConstant.svgIconInfo)),
                    child: Obx(
                      () => Switch(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: controller.pinkMode.value,
                        onChanged: (value) {
                          controller.toggleSwitch();
                        },
                        inactiveThumbColor: ColorUtil.kNeutral1,
                        inactiveTrackColor: ColorUtil.kSecondaryPinkMode,
                        activeTrackColor: ColorUtil.kPrimary2PinkMode,
                        trackOutlineWidth: const MaterialStatePropertyAll(0),
                        thumbColor: const MaterialStatePropertyAll(ColorUtil.kWhiteColor),
                        trackOutlineColor: const MaterialStatePropertyAll(ColorUtil.kNeutral1),
                      ),
                    ),
                  )
                : const SizedBox(),
            ProfileContainer(onTap: () => Get.toNamed(Routes.PROFILE_SETTINGS), image: ImageConstant.svgProfileSettings, text: 'Profile Settings'),
            ProfileContainer(onTap: () => Get.toNamed(Routes.PUSH_NOTIFICATIONS), image: ImageConstant.svgProfileNoti, text: "Notifications"),
            ProfileContainer(onTap: () => Get.toNamed(Routes.RIDE_HISTORY), image: ImageConstant.svgProfileRideHistory, text: "Ride history")
                .paddingOnly(bottom: 8.kh),
            ProfileContainer(onTap: () => Get.toNamed(Routes.WALLET), image: ImageConstant.svgProfileWallet, text: "Wallet"),
            ProfileContainer(onTap: () => Get.toNamed(Routes.STUDENT_DISCOUNTS), image: ImageConstant.svgProfileDiscount, text: "Student Discount"),
            ProfileContainer(
                onTap: () async {
                  await Share.share("Check this cool app! \nhttps://play.google.com/store/apps/details?id=com.greenpool.app");
                },
                image: ImageConstant.svgProfileRefer,
                text: "Refer a friend"),
            ProfileContainer(
                    onTap: () {
                      Get.bottomSheet(RatingBottomSheet(), enableDrag: true, isScrollControlled: true);
                    },
                    image: ImageConstant.svgProfileStar,
                    text: "Rate us")
                .paddingOnly(bottom: 8.kh),
            ProfileContainer(
              image: ImageConstant.svgProfileAbout,
              text: "About",
              // onTap: () => Get.toNamed(Routes.ABOUT),
              onTap: () async {
                await launchUrl(Uri.parse("https://green-pool-front-end.vercel.app/aboutus"));
              },
            ),
            ProfileContainer(onTap: () => Get.toNamed(Routes.FILE_DISPUTE), image: ImageConstant.svgProfileFile, text: "File Dispute"),
            ProfileContainer(onTap: () => Get.toNamed(Routes.HELP_SUPPORT), image: ImageConstant.svgProfileHelp, text: "Help & Support"),
            ProfileContainer(onTap: () => Get.toNamed(Routes.TERMS_CONDITIONS), image: ImageConstant.svgProfileTerms, text: "Terms & Conditions"),
            ProfileContainer(
                onTap: () async {
                  await launchUrl(Uri.parse("https://green-pool-front-end.vercel.app/"));
                },
                image: ImageConstant.svgProfileFollow,
                text: "Follow us on Social Media"),
            ProfileContainer(onTap: () => Get.toNamed(Routes.REPORT), image: ImageConstant.svgProfileBug, text: "Report a Bug").paddingOnly(bottom: 8.kh),
            ProfileContainer(
              onTap: () => Get.dialog(
                useSafeArea: true,
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16.kh),
                    height: 192.kh,
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
                          'Confirm Logout',
                          style: TextStyleUtil.k18Semibold(),
                          textAlign: TextAlign.center,
                        ).paddingSymmetric(vertical: 4.kh),
                        Text(
                          'Are you sure you want to logout?',
                          style: TextStyleUtil.k14Regular(
                            color: ColorUtil.kBlack04,
                          ),
                          textAlign: TextAlign.center,
                        ).paddingOnly(bottom: 40.kh),
                        Container(
                          alignment: Alignment.centerRight,
                          child: GreenPoolButton(
                            onPressed: () {
                              Get.find<AuthService>().logOutUser();
                              controller.pinkMode.value = false;
                              Get.find<HomeController>().selectedIndex.value = 0;
                              Get.offAllNamed(Routes.ONBOARDING);
                              PushNotificationService.unsubFcm("${controller.userInfo.value.data?.Id}");
                            },
                            height: 40.kh,
                            width: 144.kw,
                            label: 'Logout',
                            fontSize: 14.kh,
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              image: ImageConstant.svgProfileLogout,
              text: "Logout",
              border: Border.all(color: ColorUtil.kWhiteColor),
            ).paddingOnly(bottom: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
