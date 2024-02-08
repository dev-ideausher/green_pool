import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/auth.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';
import '../controllers/profile_controller.dart';
import 'profile_container.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Profile'),
        leading: SizedBox(),
      ),
      body: Get.find<GetStorageService>().getLoggedIn
          ? SingleChildScrollView(
              child: Column(
                children: [
                  // SvgPicture.asset(ImageConstant.svgIconProfilePic)
                  //     .paddingOnly(bottom: 8.kh, top: 16.kh),
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: ColorUtil.kPrimary01),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(44.kh),
                        child: Image.asset(
                          ImageConstant.pngEmptyPassenger,
                        ),
                      ),
                    ),
                  ).paddingOnly(bottom: 8.kh, top: 16.kh),
                  Text(
                    Get.find<GetStorageService>().getLoggedIn
                        ? Get.find<GetStorageService>().getUserName ?? "User"
                        : 'User',
                    style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                  ).paddingOnly(bottom: 24.kh),
                  Get.find<GetStorageService>().isFemale
                      ? ProfileContainer(
                          image: ImageConstant.svgProfileShieldPink,
                          text: 'Activate Pink Mode',
                          info: GestureDetector(
                              onTap: () => Get.defaultDialog(
                                  title: '',
                                  content: Text(
                                    "Travel with confidence in our 'Pink Mode'\nensuring safety and security with female\nriders and drivers.",
                                    style: TextStyleUtil.k14Regular(
                                        color: ColorUtil.kBlack03),
                                  )),
                              child:
                                  SvgPicture.asset(ImageConstant.svgIconInfo)),
                          child: Obx(
                            () => Switch(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: controller.isSwitched.value,
                              onChanged: (value) {
                                controller.isSwitched.value = value;
                              },
                              inactiveThumbColor: ColorUtil.kNeutral1,
                              inactiveTrackColor: ColorUtil.kSecondaryPinkMode,
                              activeTrackColor: ColorUtil.kPrimary2PinkMode,
                              trackOutlineWidth:
                                  const MaterialStatePropertyAll(0),
                              thumbColor: const MaterialStatePropertyAll(
                                  ColorUtil.kWhiteColor),
                              trackOutlineColor: const MaterialStatePropertyAll(
                                  ColorUtil.kNeutral1),
                            ),
                          ),
                        )
                      : const SizedBox(),

                  ProfileContainer(
                      onTap: () => Get.toNamed(Routes.PROFILE_SETTINGS),
                      image: ImageConstant.svgProfileSettings,
                      text: 'Profile Settings'),
                  ProfileContainer(
                      onTap: () => Get.toNamed(Routes.PUSH_NOTIFICATIONS),
                      image: ImageConstant.svgProfileNoti,
                      text: "Notifications"),
                  ProfileContainer(
                          onTap: () => Get.toNamed(Routes.RIDE_HISTORY),
                          image: ImageConstant.svgProfileRideHistory,
                          text: "Ride history")
                      .paddingOnly(bottom: 8.kh),
                  ProfileContainer(
                      image: ImageConstant.svgProfileWallet, text: "Wallet"),
                  ProfileContainer(
                      onTap: () => Get.toNamed(Routes.STUDENT_DISCOUNTS),
                      image: ImageConstant.svgProfileDiscount,
                      text: "Student Discount"),
                  ProfileContainer(
                      image: ImageConstant.svgProfileInsurance,
                      text: "Insurance"),
                  ProfileContainer(
                      onTap: () => Get.bottomSheet(
                            Container(
                                padding: EdgeInsets.all(24.kh),
                                height: 317.kh,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    color: ColorUtil.kWhiteColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40.kh),
                                        topRight: Radius.circular(40.kh))),
                                child: Column(
                                  children: [
                                    Text(
                                      'Refer a friend',
                                      style: TextStyleUtil.k18Semibold(),
                                    ).paddingOnly(bottom: 8.kh),
                                    Text(
                                      'Share your referral URL through:',
                                      style: TextStyleUtil.k14Semibold(
                                          color: ColorUtil.kBlack04),
                                    ),
                                  ],
                                )),
                          ),
                      image: ImageConstant.svgProfileRefer,
                      text: "Refer a friend"),
                  ProfileContainer(
                          onTap: () => Get.bottomSheet(
                                Container(
                                  padding: EdgeInsets.all(24.kh),
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      color: ColorUtil.kWhiteColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40.kh),
                                          topRight: Radius.circular(40.kh))),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Enjoying Green Pool App ?',
                                        style: TextStyleUtil.k18Semibold(),
                                      ).paddingOnly(bottom: 8.kh),
                                      Image.asset(
                                        ImageConstant.gifRateUs,
                                        height: 200.kh,
                                        width: 200.kw,
                                      ),
                                      Text(
                                        'Support us by giving rate and your\nprecious review !\nIt will take few seconds only.',
                                        style: TextStyleUtil.k14Semibold(
                                            color: ColorUtil.kBlack04),
                                        textAlign: TextAlign.center,
                                      ).paddingOnly(bottom: 24.kh),
                                      RatingBar(
                                        allowHalfRating: false,
                                        glow: false,
                                        ratingWidget: RatingWidget(
                                          full: const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          half: const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          empty: const Icon(
                                            Icons.star,
                                            color: ColorUtil.kGreyColor,
                                          ),
                                        ),
                                        onRatingUpdate: (double value) {},
                                      ),
                                      const Expanded(child: SizedBox()),
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text(
                                          'Maybe Later',
                                          style: TextStyleUtil.k16Bold(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          image: ImageConstant.svgProfileStar,
                          text: "Rate us")
                      .paddingOnly(bottom: 8.kh),
                  ProfileContainer(
                    image: ImageConstant.svgProfileAbout,
                    text: "About",
                    onTap: () => Get.toNamed(Routes.ABOUT),
                  ),
                  ProfileContainer(
                      onTap: () => Get.toNamed(Routes.FILE_DISPUTE),
                      image: ImageConstant.svgProfileFile,
                      text: "File Dispute"),
                  ProfileContainer(
                      onTap: () => Get.toNamed(Routes.HELP_SUPPORT),
                      image: ImageConstant.svgProfileHelp,
                      text: "Help & Suppurt"),
                  ProfileContainer(
                      onTap: () => Get.toNamed(Routes.TERMS_CONDITIONS),
                      image: ImageConstant.svgProfileTerms,
                      text: "Terms & Conditions"),
                  ProfileContainer(
                      image: ImageConstant.svgProfileFollow,
                      text: "Follow us on Social Media"),
                  ProfileContainer(
                          onTap: () => Get.toNamed(Routes.REPORT),
                          image: ImageConstant.svgProfileBug,
                          text: "Report a Bug")
                      .paddingOnly(bottom: 8.kh),
                  ProfileContainer(
                    onTap: () => Get.dialog(
                      // title: ''
                      // titlePadding: const EdgeInsets.all(0),
                      // contentPadding: const EdgeInsets.all(0),
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
                                    Get.find<ProfileController>()
                                        .isSwitched
                                        .value = false;
                                    Get.find<HomeController>()
                                        .selectedIndex
                                        .value = 0;
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
            )
          : Center(
              child: Text(
                'Please Login or SignUp',
                style: TextStyleUtil.k24Heading600(),
              ),
            ),
    );
  }
}
