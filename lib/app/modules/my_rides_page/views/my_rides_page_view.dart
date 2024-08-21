//! contains tab bar for One time view and recurring view
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/my_rides_one_time/controllers/my_rides_one_time_controller.dart';
import 'package:green_pool/app/modules/my_rides_one_time/views/my_rides_one_time_view.dart';
import 'package:green_pool/app/modules/my_rides_recurring/controllers/my_rides_recurring_controller.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_appbar.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';

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
        body: SafeArea(
          child: Get.find<HomeController>().userInfo.value.data?.isDriver ??
                  false
              ? DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                          onTap: (index) async {
                            if (index == 0) {
                              await Get.find<MyRidesOneTimeController>()
                                  .myRidesAPI(isRecurring: true);
                            } else {
                              // await Get.find<MyRidesOneTimeController>()
                              //     .myRidesAPI();
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
                                color: Get.find<HomeController>()
                                        .isPinkModeOn
                                        .value
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01,
                                width: 2.kh),
                          ),
                          isScrollable: false,
                          labelColor:
                              Get.find<HomeController>().isPinkModeOn.value
                                  ? ColorUtil.kPrimary3PinkMode
                                  : ColorUtil.kSecondary01,
                          tabs: [
                            Tab(
                              child: Text(
                                Strings.allRides,
                              ),
                            ),
                            Tab(
                              child: Text(
                                Strings.driver,
                              ),
                            ),
                            Tab(
                              child: Text(
                                Strings.rider,
                              ),
                            ),
                            /*  Tab(
                            child: Text(
                              Strings.recurringTrips,
                            ),
                          ),*/
                          ]).paddingSymmetric(horizontal: 16.kw),
                      Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            MyRidesOneTimeView(),
                            MyRidesOneTimeView(type: Strings.booked),
                            MyRidesOneTimeView(type: Strings.published),
                            //  MyRidesRecurringView()
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : MyRidesOneTimeView(),
        ));
  }
}
