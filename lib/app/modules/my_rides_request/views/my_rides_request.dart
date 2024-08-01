//! contains tab bar for Confirm Request view and Send Request view (my_rides_view -> my_ride_details (view matching rides))
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/modules/my_rides_request/controllers/my_rides_request_controller.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import 'confirm_request.dart';
import 'send_request.dart';

class MyRideRequestsView extends GetView<MyRidesRequestController> {
  const MyRideRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyRidesRequestController());
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
                      await controller.allSendRequestAPI();
                    } else {
                      await controller.allConfirmRequestAPI();
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
                  children: [ConfirmRequest(), SendRequest()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
