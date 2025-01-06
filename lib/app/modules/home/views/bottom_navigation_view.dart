import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/home/views/home_view.dart';
import 'package:green_pool/app/modules/messages/views/messages_view.dart';
import 'package:green_pool/app/modules/my_rides_page/views/my_rides_page_view.dart';
import 'package:green_pool/app/modules/profile/views/profile_view.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../services/colors.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';

class BottomNavigationView extends GetView<HomeController> {
  const BottomNavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<GetStorageService>();
    return PopScope(
      canPop: controller.canPop,
      onPopInvoked: (didPop) {
        controller.canPop = didPop;
        if (controller.selectedIndex.value == 0) {
          controller.canPop = true;
        } else {
          controller.changeTabIndex(0);
        }
      },
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              selectedLabelStyle: storageService.isPinkMode
                  ? TextStyleUtil.k12Semibold(
                      color: ColorUtil.kPrimary3PinkMode)
                  : TextStyleUtil.k12Semibold(color: ColorUtil.kSecondary01),
              unselectedLabelStyle:
                  TextStyleUtil.k12Semibold(color: ColorUtil.kBlack05),
              backgroundColor: ColorUtil.kWhiteColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.selectedIndex.value,
              enableFeedback: true,
              unselectedItemColor: ColorUtil.kBlack05,
              selectedItemColor: storageService.isPinkMode
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
              onTap: (index) {
                controller.onTapBottomNavigation(index);
              },
              items: [
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    ImageConstant.svgNavHomeFilled,
                    colorFilter: ColorFilter.mode(
                        storageService.isPinkMode
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(ImageConstant.svgNavHome),
                  label: Strings.home,
                ),
                BottomNavigationBarItem(
                  activeIcon: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SvgPicture.asset(
                        ImageConstant.svgNavCarFilled,
                        colorFilter: ColorFilter.mode(
                            storageService.isPinkMode
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                            BlendMode.srcIn),
                      ),
                      Visibility(
                        visible: controller.reqsCount.value > 0,
                        child: Container(
                          height: 14.kh,
                          width: 14.kw,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 1.kh, horizontal: 4.kw),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: storageService.isPinkMode
                                  ? ColorUtil.kSecondaryPinkMode
                                  : ColorUtil.kPrimary05),
                          child: Text(
                            "${controller.reqsCount.value}",
                            style: TextStyleUtil.k8Semibold(
                                color: storageService.isPinkMode
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01),
                          ),
                        ),
                      ),
                    ],
                  ),
                  icon: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SvgPicture.asset(ImageConstant.svgNavCar),
                      Visibility(
                        visible: controller.reqsCount.value > 0,
                        child: Container(
                          height: 14.kh,
                          width: 14.kw,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 1.kh, horizontal: 4.kw),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: storageService.isPinkMode
                                  ? ColorUtil.kSecondaryPinkMode
                                  : ColorUtil.kPrimary05),
                          child: Text(
                            "${controller.reqsCount.value}",
                            style: TextStyleUtil.k8Semibold(
                                color: storageService.isPinkMode
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01),
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: Strings.myRides,
                ),
                BottomNavigationBarItem(
                  activeIcon: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SvgPicture.asset(
                        ImageConstant.svgNavMessagesFilled,
                        colorFilter: ColorFilter.mode(
                            storageService.isPinkMode
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                            BlendMode.srcIn),
                      ),
                      Visibility(
                        visible: controller.totUnreadMsgs.value > 0,
                        child: Container(
                          height: 14.kh,
                          width: 14.kw,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 1.kh, horizontal: 4.kw),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: storageService.isPinkMode
                                  ? ColorUtil.kSecondaryPinkMode
                                  : ColorUtil.kPrimary05),
                          child: Text(
                            "${controller.totUnreadMsgs.value}",
                            style: TextStyleUtil.k8Semibold(
                                color: storageService.isPinkMode
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01),
                          ),
                        ),
                      ),
                    ],
                  ),
                  icon: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SvgPicture.asset(ImageConstant.svgNavMessages),
                      Visibility(
                        visible: controller.totUnreadMsgs.value > 0,
                        child: Container(
                          height: 14.kh,
                          width: 14.kw,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 1.kh, horizontal: 4.kw),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: storageService.isPinkMode
                                  ? ColorUtil.kSecondaryPinkMode
                                  : ColorUtil.kPrimary05),
                          child: Text(
                            "${controller.totUnreadMsgs.value}",
                            style: TextStyleUtil.k8Semibold(
                                color: storageService.isPinkMode
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01),
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: Strings.messages,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    ImageConstant.svgNavProfileFilled,
                    colorFilter: ColorFilter.mode(
                        storageService.isPinkMode
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(ImageConstant.svgNavProfile),
                  label: Strings.profile,
                ),
              ]),
        ),
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            controller.changeTabIndex(index);
          },
          children: const [
            HomeView(),
            MyRidesPageView(),
            MessagesView(),
            ProfileView(),
          ],
        ),
      ),
    );
  }
}
