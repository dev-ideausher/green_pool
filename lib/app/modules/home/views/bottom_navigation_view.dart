import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/home/views/home_view.dart';
import 'package:green_pool/app/modules/messages/views/messages_view.dart';
import 'package:green_pool/app/modules/my_rides_page/views/my_rides_page_view.dart';
import 'package:green_pool/app/modules/profile/views/profile_view.dart';

import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';

class BottomNavigationView extends GetView<HomeController> {
  const BottomNavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            selectedLabelStyle: Get.find<HomeController>().isPinkModeOn.value
                ? TextStyleUtil.k12Semibold(color: ColorUtil.kPrimary3PinkMode)
                : TextStyleUtil.k12Semibold(color: ColorUtil.kSecondary01),
            unselectedLabelStyle:
                TextStyleUtil.k12Semibold(color: ColorUtil.kBlack05),
            backgroundColor: ColorUtil.kWhiteColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            enableFeedback: true,
            unselectedItemColor: ColorUtil.kBlack05,
            selectedItemColor: Get.find<HomeController>().isPinkModeOn.value
                ? ColorUtil.kPrimary3PinkMode
                : ColorUtil.kSecondary01,
            onTap: (index) {
              controller.changeTabIndex(index);
              controller.pageController?.animateToPage(
                index,
                duration: const Duration(milliseconds: 1),
                curve: Curves.easeIn,
              );
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  ImageConstant.svgNavHomeFilled,
                  colorFilter: ColorFilter.mode(
                      Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(ImageConstant.svgNavHome),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  ImageConstant.svgNavCarFilled,
                  colorFilter: ColorFilter.mode(
                      Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(ImageConstant.svgNavCar),
                label: 'My Rides',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  ImageConstant.svgNavMessagesFilled,
                  colorFilter: ColorFilter.mode(
                      Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(ImageConstant.svgNavMessages),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  ImageConstant.svgNavProfileFilled,
                  colorFilter: ColorFilter.mode(
                      Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(ImageConstant.svgNavProfile),
                label: 'Profile',
              ),
            ]),
      ),
      body: PageView(
        controller: controller.pageController,
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
    );
  }
}
