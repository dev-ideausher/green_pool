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
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/app/services/storage.dart';

import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';

class BottomNavigationView extends GetView<HomeController> {
  const BottomNavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
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
              selectedLabelStyle: isPinkModeOn
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
              selectedItemColor: isPinkModeOn
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
              onTap: (index) {
                controller.onTapBottomNavigation(index);
              },

              // Get.find<GetStorageService>().isLoggedIn
              //     ? Get.find<GetStorageService>().profileStatus
              //         ? (index) {
              //             controller.changeTabIndex(index);
              //             // controller.pageController?.animateToPage(
              //             //   index,
              //             //   duration: const Duration(milliseconds: 1),
              //             //   curve: Curves.easeIn,
              //             // );
              //           }
              //         : (index) {
              //             if (index != 0) {
              //               Get.toNamed(Routes.RIDER_PROFILE_SETUP,
              //                   arguments: true);
              //               showMySnackbar(
              //                   msg: Strings.pleaseCompleteProfileSetup);
              //             }
              //           }
              //     : (index) {
              //         if (index != 0) {
              //           print(
              //               "GET STORAGE IS LOGGED IN: ${Get.find<GetStorageService>().isLoggedIn.toString()}");
              //           Get.toNamed(Routes.LOGIN,
              //               arguments: {'isDriver': false, 'fromNavBar': true});
              //         }
              //       },
              items: [
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    ImageConstant.svgNavHomeFilled,
                    colorFilter: ColorFilter.mode(
                        isPinkModeOn
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(ImageConstant.svgNavHome),
                  label: Strings.home,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    ImageConstant.svgNavCarFilled,
                    colorFilter: ColorFilter.mode(
                        isPinkModeOn
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(ImageConstant.svgNavCar),
                  label: Strings.myRides,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    ImageConstant.svgNavMessagesFilled,
                    colorFilter: ColorFilter.mode(
                        isPinkModeOn
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(ImageConstant.svgNavMessages),
                  label: Strings.messages,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    ImageConstant.svgNavProfileFilled,
                    colorFilter: ColorFilter.mode(
                        isPinkModeOn
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
