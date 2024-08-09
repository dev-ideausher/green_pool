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
import '../../../services/colors.dart';
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
              : RefreshIndicator(
                  backgroundColor: ColorUtil.kWhiteColor,
                  color: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kPrimary01,
                  onRefresh: () async {
                    await controller.myRidesAPI();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Visibility(
                          visible: type == null,
                          child:
                              (controller.recurringResp.value.data?.isEmpty ??
                                      true)
                                  ? const SizedBox()
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: controller
                                          .recurringResp.value.data?.length,
                                      itemBuilder: (context, index) {
                                        return RecurringTile(
                                            recurringResp: controller
                                                .recurringResp
                                                .value
                                                .data?[index]);
                                      },
                                    ),
                        ),
                        Builder(builder: (context) {
                          bool isListEmpty = false;
                          if (type == null) {
                            if (controller.myRidesModelData.isEmpty) {
                              isListEmpty = true;
                            } else {
                              isListEmpty = false;
                            }
                          } else if (type == Strings.booked) {
                            if (controller.driverRides.isEmpty) {
                              isListEmpty = true;
                            } else {
                              isListEmpty = false;
                            }
                          } else if (type == Strings.published) {
                            if (controller.riderRides.isEmpty) {
                              isListEmpty = true;
                            } else {
                              isListEmpty = false;
                            }
                          }

                          return isListEmpty
                              ? Visibility(
                                  visible:
                                      controller.decideNoRidesVisibilty(type),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height -
                                        100,
                                    child:const Center(
                                      child:  NoRidePosted(),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: controller.myRidesModelData.length,
                                  itemBuilder: (context, index) {
                                    if (type == null) {
                                      if (controller.myRidesModelData[index]
                                              .driverId !=
                                          null) {
                                        return DriverTile(
                                            myRidesModelData: controller
                                                .myRidesModelData[index]);
                                      } else {
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
                                          return const SizedBox();
                                        }
                                      } else {
                                        if (controller.myRidesModelData[index]
                                                .driverId !=
                                            null) {
                                          return const SizedBox();
                                        } else {
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
                ),
        ),
      ),
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
