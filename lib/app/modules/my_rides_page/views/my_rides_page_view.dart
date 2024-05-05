//! contains tab bar for One time view and recurring view
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/my_rides_one_time/controllers/my_rides_one_time_controller.dart';
import 'package:green_pool/app/modules/my_rides_one_time/views/my_rides_one_time_view.dart';
import 'package:green_pool/app/modules/my_rides_recurring/controllers/my_rides_recurring_controller.dart';
import 'package:green_pool/app/modules/my_rides_recurring/views/my_rides_recurring_view.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_appbar.dart';
import '../../../services/colors.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_rides_page_controller.dart';

class MyRidesPageView extends GetView<MyRidesPageController> {
  const MyRidesPageView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(MyRidesRecurringController());
    Get.lazyPut(() => MyRidesPageController());
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
                            await Get.find<MyRidesRecurringController>()
                                .allRecurringRidesAPI();
                          } else {
                            // await controller.allConfirmRequestAPI();
                            await Get.find<MyRidesOneTimeController>()
                                .myRidesAPI();
                          }
                        },
                        indicatorSize: TabBarIndicatorSize.tab,
                        splashBorderRadius: BorderRadius.circular(4.kh),
                        unselectedLabelStyle: TextStyleUtil.k14Semibold(
                            color: ColorUtil.kSecondary01),
                        labelStyle: TextStyleUtil.k14Semibold(
                          color: Get.find<HomeController>().isPinkModeOn.value
                              ? ColorUtil.kPrimary3PinkMode
                              : ColorUtil.kSecondary01,
                        ),
                        overlayColor: MaterialStatePropertyAll(
                            ColorUtil.kSecondary01.withOpacity(0.05)),
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color:
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                              width: 2.kh),
                        ),
                        labelColor:
                            Get.find<HomeController>().isPinkModeOn.value
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
              "Tap on profile to continue",
              style: TextStyleUtil.k20Heading600(),
            )
              //  Text.rich(
              //   TextSpan(
              //     children: [
              //       TextSpan(
              //         text: 'Please  ',
              //         style: TextStyleUtil.k16Regular(),
              //       ),
              //       TextSpan(
              //           text: 'Login  ',
              //           style: TextStyleUtil.k20Heading700(
              //               color: ColorUtil.kPrimary01),
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () => Get.toNamed(Routes.LOGIN, arguments: {
              //                   'isDriver': false,
              //                   'fromNavBar': true
              //                 })),
              //       TextSpan(
              //         text: 'or  ',
              //         style: TextStyleUtil.k16Regular(),
              //       ),
              //       TextSpan(
              //           text: 'SignUp',
              //           style: TextStyleUtil.k20Heading700(
              //               color: ColorUtil.kPrimary01),
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () => Get.toNamed(Routes.CREATE_ACCOUNT,
              //                     arguments: {
              //                       'isDriver': false,
              //                       'fromNavBar': true
              //                     })),
              //     ],
              //   ),
              // ),
              ),
    );
  }
}
