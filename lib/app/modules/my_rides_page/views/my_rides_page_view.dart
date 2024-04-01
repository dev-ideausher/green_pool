//! contains tab bar for One time view and recurring view
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/my_rides_one_time/controllers/my_rides_controller.dart';
import 'package:green_pool/app/modules/my_rides_one_time/views/my_rides_one_time_view.dart';
import 'package:green_pool/app/modules/my_rides_recurring/views/my_rides_recurring_view.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_appbar.dart';
import '../../../services/colors.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/my_rides_page_controller.dart';

class MyRidesPageView extends GetView<MyRidesPageController> {
  const MyRidesPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('My Rides'),
        leading: SizedBox(),
      ),
      body: Get.find<GetStorageService>().getLoggedIn
          ? SafeArea(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                        onTap: (index) async {
                          if (index == 1) {
                            // await controller.allSendRequestAPI();
                          } else {
                            // await controller.allConfirmRequestAPI();
                            Get.find<MyRidesOneTimeController>().myRidesApi();
                          }
                        },
                        indicatorSize: TabBarIndicatorSize.tab,
                        splashBorderRadius: BorderRadius.circular(4.kh),
                        unselectedLabelStyle: TextStyleUtil.k14Semibold(
                            color: ColorUtil.kSecondary01),
                        labelStyle: TextStyleUtil.k14Semibold(
                          color: Get.find<ProfileController>().isSwitched.value
                              ? ColorUtil.kPrimary3PinkMode
                              : ColorUtil.kSecondary01,
                        ),
                        overlayColor: MaterialStatePropertyAll(
                            ColorUtil.kSecondary01.withOpacity(0.05)),
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color:
                                  Get.find<ProfileController>().isSwitched.value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                              width: 2.kh),
                        ),
                        labelColor:
                            Get.find<ProfileController>().isSwitched.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                        tabs: const [
                          Tab(
                            child: Text(
                              'One-time Trips',
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Recurring Trips',
                            ),
                          ),
                        ]).paddingSymmetric(horizontal: 16.kw),
                    const Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          MyRidesOneTimeView(),
                          MyRidesRecurringView()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
