import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../res/strings.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';
import '../controllers/profile_controller.dart';
import 'profile_container.dart';
import 'rating_bottomsheet.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.profile),
        leading: const SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => GestureDetector(
                onTap: () => Get.toNamed(Routes.USER_DETAILS)?.then(
                  (value) => controller.updateInfo(),
                ),
                child: Hero(
                  tag: "profilePic",
                  transitionOnUserGestures: true,
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                        child: SizedBox.fromSize(
                            size: Size.fromRadius(44.kh),
                            child: CommonImageView(
                                height: 44.kh,
                                width: 44.kw,
                                url: controller.profilePic.value))),
                  ).paddingOnly(bottom: 8.kh, top: 16.kh),
                ),
              ),
            ),
            Obx(
              () => Text(
                controller.fullName.value ?? Strings.user,
                style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
              ).paddingOnly(bottom: 24.kh),
            ),
            controller.userInfo.value.data?.gender == "Female"
                ? ProfileContainer(
                    image: ImageConstant.svgProfileShieldPink,
                    text: Strings.activatePinkMode,
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
                                      Strings
                                          .travelWithConfidenceWithOurPinkMode,
                                      style: TextStyleUtil.k14Regular(
                                          color: ColorUtil.kBlack03),
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
                        thumbColor: const MaterialStatePropertyAll(
                            ColorUtil.kWhiteColor),
                        trackOutlineColor:
                            const MaterialStatePropertyAll(ColorUtil.kNeutral1),
                      ),
                    ),
                  )
                : const SizedBox(),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.PROFILE_SETTINGS)?.then(
                      (value) => controller.updateInfo(),
                    ),
                image: ImageConstant.svgProfileSettings,
                text: Strings.profileSettings),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.PUSH_NOTIFICATIONS),
                image: ImageConstant.svgProfileNoti,
                text: Strings.notifications),
            ProfileContainer(
                    onTap: () => Get.toNamed(Routes.RIDE_HISTORY),
                    image: ImageConstant.svgProfileRideHistory,
                    text: Strings.ridehistory)
                .paddingOnly(bottom: 8.kh),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.WALLET),
                image: ImageConstant.svgProfileWallet,
                text: Strings.wallet),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.STUDENT_DISCOUNTS),
                image: ImageConstant.svgProfileDiscount,
                text: Strings.studentDiscount),
            ProfileContainer(
                onTap: () async {
                  await Share.share(
                      "Check this cool app! \nhttps://play.google.com/store/apps/details?id=com.greenpool.app");
                },
                image: ImageConstant.svgProfileRefer,
                text: Strings.referAFriend),
            ProfileContainer(
                    onTap: () {
                      Get.bottomSheet(const RatingBottomSheet(),
                          enableDrag: true, isScrollControlled: true);
                    },
                    image: ImageConstant.svgProfileStar,
                    text: Strings.rateUs)
                .paddingOnly(bottom: 8.kh),
            ProfileContainer(
              image: ImageConstant.svgProfileAbout,
              text: Strings.aboutUs,
              onTap: () => Get.toNamed(Routes.ABOUT),
            ),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.FILE_DISPUTE),
                image: ImageConstant.svgProfileFile,
                text: Strings.fileDispute),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.HELP_SUPPORT),
                image: ImageConstant.svgProfileHelp,
                text: Strings.helpAndSupport),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.TERMS_CONDITIONS),
                image: ImageConstant.svgProfileTerms,
                text: Strings.termsAmbersentConditions),
            ProfileContainer(
                onTap: () async {
                  await launchUrl(
                      Uri.parse("https://green-pool-front-end.vercel.app/"));
                },
                image: ImageConstant.svgProfileFollow,
                text: Strings.followUsOnSocialMedia),
            ProfileContainer(
                    onTap: () => Get.toNamed(Routes.REPORT),
                    image: ImageConstant.svgProfileBug,
                    text: Strings.reportABug)
                .paddingOnly(bottom: 8.kh),
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
                          Strings.confirmLogout,
                          style: TextStyleUtil.k18Semibold(),
                          textAlign: TextAlign.center,
                        ).paddingSymmetric(vertical: 4.kh),
                        Text(
                          Strings.sureWantToLogout,
                          style: TextStyleUtil.k14Regular(
                            color: ColorUtil.kBlack04,
                          ),
                          textAlign: TextAlign.center,
                        ).paddingOnly(bottom: 40.kh),
                        Container(
                          alignment: Alignment.centerRight,
                          child: GreenPoolButton(
                            onPressed: () {
                              controller.logoutUser();
                            },
                            height: 40.kh,
                            width: 144.kw,
                            label: Strings.logout,
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
              text: Strings.logout,
              border: Border.all(color: ColorUtil.kWhiteColor),
            ).paddingOnly(bottom: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
