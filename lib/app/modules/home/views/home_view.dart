import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/home/views/welcome_tile.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../services/storage.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const WelcomeTile(),
            Obx(
              () => GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.POST_RIDE, arguments: true);
                  controller.findingRide.value = false;
                },
                child: Container(
                  width: 100.w,
                  height: 149.kh,
                  decoration: BoxDecoration(
                    color: ColorUtil.kWhiteColor,
                    borderRadius: BorderRadius.circular(8.kh),
                    border: Border(
                      right: BorderSide(
                        color: ColorUtil.kSecondary04,
                        width: 0.2.kh,
                      ),
                      bottom: BorderSide(
                        color: ColorUtil.kSecondary04,
                        width: 0.2.kh,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 0,
                          left: Get.find<ProfileController>().isSwitched.value
                              ? 0
                              : null,
                          bottom: 0,
                          child: Get.find<ProfileController>().isSwitched.value
                              ? SvgPicture.asset(
                                  ImageConstant.svgPinkPostRide,
                                  fit: BoxFit.fill,
                                )
                              : SvgPicture.asset(
                                  ImageConstant.svgPostRide,
                                )),
                      Positioned(
                        left: 16.kw,
                        top: 48.kh,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Post a Ride',
                              style: TextStyleUtil.k20Heading700(),
                            ).paddingOnly(bottom: 4.kh),
                            Text(
                              'Offer a ride nearby',
                              style: TextStyleUtil.k14Regular(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 24.kh),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.FIND_RIDE, arguments: false);
                controller.findingRide.value = true;
              },
              child: Container(
                width: 100.w,
                height: 149.kh,
                decoration: BoxDecoration(
                  color: ColorUtil.kWhiteColor,
                  borderRadius: BorderRadius.circular(8.kh),
                  border: Border(
                    right: BorderSide(
                      color: ColorUtil.kSecondary04,
                      width: 0.2.kh,
                    ),
                    bottom: BorderSide(
                      color: ColorUtil.kSecondary04,
                      width: 0.2.kh,
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    Obx(
                      () => Positioned(
                          right: 0.kw,
                          left: Get.find<ProfileController>().isSwitched.value
                              ? 0
                              : null,
                          bottom: 0.kh,
                          child: Get.find<ProfileController>().isSwitched.value
                              ? SvgPicture.asset(
                                  ImageConstant.svgPinkFindRide,
                                  fit: BoxFit.fill,
                                )
                              : SvgPicture.asset(
                                  ImageConstant.svgFindRide,
                                )),
                    ),
                    Positioned(
                      left: 16.kw,
                      top: 48.kh,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Find a Ride',
                            style: TextStyleUtil.k20Heading700(),
                          ).paddingOnly(bottom: 4.kh),
                          Text(
                            'Take a ride nearby',
                            style: TextStyleUtil.k14Regular(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
