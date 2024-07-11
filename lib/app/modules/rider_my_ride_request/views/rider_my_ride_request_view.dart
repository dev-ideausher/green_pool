//! contains requests view after tapping on the rider tile in my rides
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/rider_my_ride_request_controller.dart';
import 'rider_confirm_request.dart';
import 'rider_send_request.dart';

class RiderMyRideRequestView extends GetView<RiderMyRideRequestController> {
  const RiderMyRideRequestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.myRides),
        actions: [
          Obx(
            () => GestureDetector(
              onTap: controller.changeViewType,
              child: controller.mapViewType.value
                  ? SvgPicture.asset(ImageConstant.svgIconListView)
                  : SvgPicture.asset(ImageConstant.svgIconMapView),
            ).paddingOnly(right: 16.kw),
          ),
        ],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                  onTap: (index) async {
                    if (index == 1) {
                      await controller.allRiderSendRequestAPI();
                    } else {
                      await controller.allRiderConfirmRequestAPI();
                    }
                  },
                  indicatorSize: TabBarIndicatorSize.tab,
                  splashBorderRadius: BorderRadius.circular(4.kh),
                  unselectedLabelStyle:
                      TextStyleUtil.k14Semibold(color: ColorUtil.kSecondary01),
                  labelStyle: TextStyleUtil.k14Semibold(
                    color: Get.find<HomeController>().isPinkModeOn.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                  ),
                  overlayColor: MaterialStatePropertyAll(
                      ColorUtil.kSecondary01.withOpacity(0.05)),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        width: 2.kh),
                  ),
                  labelColor: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  tabs: [
                    Tab(
                      child: Text(
                        Strings.confirmRequests,
                      ),
                    ),
                    Tab(
                      child: Text(
                        Strings.sendRequests,
                      ),
                    ),
                  ]).paddingSymmetric(horizontal: 16.kw),
              const Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [RiderConfirmRequest(), RiderSendRequest()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
