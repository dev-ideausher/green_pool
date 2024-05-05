import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/rider_post_ride_controller.dart';

class RiderPostRideView extends GetView<RiderPostRideController> {
  const RiderPostRideView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Post a Ride'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.POST_RIDE);
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
                        bottom: 0,
                        child: SvgPicture.asset(
                          Get.find<HomeController>().isPinkModeOn.value
                              ? ImageConstant.svgPinkRiderDriving
                              : ImageConstant.svgRiderDriving,
                        )),
                    Positioned(
                      left: 16.kw,
                      top: 37.kh,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'I am driving !',
                            style: TextStyleUtil.k20Heading700(),
                          ).paddingOnly(bottom: 4.kh),
                          Text(
                            'I\'m looking to occupy\nvacant spots in my car.',
                            style: TextStyleUtil.k14Regular(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 24.kh, top: 40.kh),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.RIDER_MY_RIDE_REQUEST),
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
                        bottom: 0,
                        child: SvgPicture.asset(
                          Get.find<HomeController>().isPinkModeOn.value
                              ? ImageConstant.svgPinkRiderNeedRide
                              : ImageConstant.svgRiderNeedRide,
                        )),
                    Positioned(
                      left: 16.kw,
                      top: 37.kh,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'I need a ride !',
                            style: TextStyleUtil.k20Heading700(),
                          ).paddingOnly(bottom: 4.kh),
                          Text(
                            'Let me know when there\'s\na ride available.',
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
