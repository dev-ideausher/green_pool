//! contains requests view after tapping on the rider tile in my rides
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

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
      appBar: const GreenPoolAppBar(
        title: Text('My Rides'),
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
                    color: Get.find<HomeController>().isSwitched.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                  ),
                  overlayColor: MaterialStatePropertyAll(
                      ColorUtil.kSecondary01.withOpacity(0.05)),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                        color: Get.find<HomeController>().isSwitched.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        width: 2.kh),
                  ),
                  labelColor: Get.find<HomeController>().isSwitched.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  tabs: const [
                    Tab(
                      child: Text(
                        'Confirm Requests',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Send Requests',
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
