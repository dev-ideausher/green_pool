//! contains my rides view (driver tile and rider tile)

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/my_rides_one_time/views/driver_tile.dart';
import 'package:green_pool/app/modules/my_rides_one_time/views/recurring_tile.dart';
import 'package:green_pool/app/modules/my_rides_one_time/views/rider_tile.dart';
import 'package:green_pool/app/res/strings.dart';

import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/assets.dart';
import '../../../components/gp_progress.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_rides_one_time_controller.dart';

class MyRidesOneTimeView extends GetView<MyRidesOneTimeController> {
  String? type;

  MyRidesOneTimeView({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyRidesOneTimeController());
    controller.myRidesAPI();
    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : controller.myRidesModelData.isEmpty
                ? const NoRidePosted()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Visibility(
                          visible: type == null,
                          child: (controller
                                      .recurringResp.value.data?.isEmpty ??
                                  true)
                              ? const SizedBox()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller
                                      .recurringResp.value.data?.length,
                                  itemBuilder: (context, index) {
                                    return RecurringTile(
                                        recurringResp: controller
                                            .recurringResp.value.data?[index]);
                                  }),
                        ),
                        Builder(builder: (context) {
                          bool isListEmpty = false;
                          if (type == null &&
                              controller.myRidesModelData.isEmpty) {
                            const NoRidePosted();
                          } else if (type == Strings.booked) {
                            bool containsDriverId = controller.myRidesModelData
                                .any((obj) => obj.driverId == null);
                            if (!containsDriverId) {
                              final myList = controller.myRidesModelData
                                  .where((obj) => obj.driverId == null)
                                  .toList();
                              if (myList.isEmpty) {
                                isListEmpty = false;
                              } else {
                                isListEmpty = true;
                              }
                            } else {
                              isListEmpty = true;
                            }
                          } else if (type == Strings.published) {
                            bool containsRiderId = controller.myRidesModelData
                                .any((obj) => obj.riderId == null);
                            if (!containsRiderId) {
                              final myList = controller.myRidesModelData
                                  .where((obj) => obj.riderId == null)
                                  .toList();
                              if (myList.isEmpty) {
                                isListEmpty = false;
                              } else {
                                isListEmpty = true;
                              }
                            } else {
                              isListEmpty = true;
                            }
                          }
                          return isListEmpty
                              ? const NoRidePosted()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.myRidesModelData.length,
                                  itemBuilder: (context, index) {
                                    if (type == null) {
                                      if (controller.myRidesModelData[index]
                                              .driverId !=
                                          null) {
                                        return
                                            // --------------- for driver tile -----------------//
                                            DriverTile(
                                                myRidesModelData: controller
                                                    .myRidesModelData[index]);
                                      } else {
                                        //---------------- for rider tile ------------------//
                                        return RiderTile(
                                            myRidesModelData: controller
                                                .myRidesModelData[index]);
                                      }
                                    } else {
                                      if (type == Strings.booked) {
                                        if (controller.myRidesModelData[index]
                                                .driverId !=
                                            null) {
                                          return DriverTile(
                                              myRidesModelData: controller
                                                  .myRidesModelData[index]);
                                        } else {
                                          //---------------- for rider tile ------------------//
                                          return const SizedBox();
                                        }
                                      } else {
                                        if (controller.myRidesModelData[index]
                                                .driverId !=
                                            null) {
                                          return const SizedBox();
                                        } else {
                                          //---------------- for rider tile ------------------//
                                          return RiderTile(
                                              myRidesModelData: controller
                                                  .myRidesModelData[index]);
                                        }
                                      }
                                    }
                                  },
                                ).paddingOnly(top: 32.kh);
                        }),
                      ],
                    ).paddingSymmetric(horizontal: 16.kw),
                  ),
      )),
    );
  }
}

class NoRidePosted extends StatelessWidget {
  const NoRidePosted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Get.find<HomeController>().isPinkModeOn.value
                ? CommonImageView(svgPath: Assets.svgPinkModegirl)
                : SvgPicture.asset(ImageConstant.svgNoRides)),
        Text(
          Strings.youHavePostedNoRides,
          style: TextStyleUtil.k24Heading600(),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
