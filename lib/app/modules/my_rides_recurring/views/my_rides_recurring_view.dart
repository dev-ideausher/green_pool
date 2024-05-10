//! contains recurring ride view in my rides
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_rides_recurring_controller.dart';

class MyRidesRecurringView extends GetView<MyRidesRecurringController> {
  const MyRidesRecurringView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const GpProgress()
            : controller.recurringResp.value.data!.isEmpty
                ? Center(
                    child: Text(
                      Strings.notPostedRecurringRides,
                      style: TextStyleUtil.k18Heading600(),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount:
                                controller.recurringResp.value.data?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: controller
                                            .recurringResp
                                            .value
                                            .data?[index]
                                            ?.recurringTrip
                                            ?.isRecurringTripEnabled ??
                                        false
                                    ? () {
                                        Get.toNamed(
                                            Routes.MY_RIDES_RECURRING_DETAILS,
                                            arguments: controller.recurringResp
                                                .value.data?[index]?.Id);
                                      }
                                    : () {},
                                child: Container(
                                  padding: EdgeInsets.all(16.kh),
                                  decoration: BoxDecoration(
                                      color: ColorUtil.kWhiteColor,
                                      borderRadius:
                                          BorderRadius.circular(8.kh)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //TODO: toggle switch
                                          Text(
                                            controller.recurringResp.value
                                                    .data?[index]?.time ??
                                                "00:00",
                                            style: TextStyleUtil.k16Semibold(
                                                fontSize: 16.kh),
                                          ),
                                          Obx(
                                            () => Transform.scale(
                                              scale: 0.8.kh,
                                              child: Switch(
                                                // value: controller
                                                //     .isScheduled[index].value,
                                                value: controller
                                                        .recurringResp
                                                        .value
                                                        .data?[index]
                                                        ?.recurringTrip
                                                        ?.isRecurringTripEnabled ??
                                                    false,
                                                onChanged: (value) {
                                                  controller.isScheduled[index]
                                                      .value = value;
                                                  controller.enableRecurringAPI(
                                                      controller
                                                          .recurringResp
                                                          .value
                                                          .data?[index]
                                                          ?.Id);
                                                },
                                                inactiveThumbColor:
                                                    ColorUtil.kNeutral1,
                                                inactiveTrackColor:
                                                    Get.find<HomeController>()
                                                            .isPinkModeOn
                                                            .value
                                                        ? ColorUtil
                                                            .kSecondaryPinkMode
                                                        : ColorUtil.kPrimary05,
                                                activeTrackColor:
                                                    Get.find<HomeController>()
                                                            .isPinkModeOn
                                                            .value
                                                        ? ColorUtil
                                                            .kPrimary3PinkMode
                                                        : ColorUtil
                                                            .kSecondary01,
                                                trackOutlineWidth:
                                                    const MaterialStatePropertyAll(
                                                        0),
                                                thumbColor:
                                                    const MaterialStatePropertyAll(
                                                        ColorUtil.kWhiteColor),
                                                trackOutlineColor:
                                                    const MaterialStatePropertyAll(
                                                        ColorUtil.kNeutral1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const GreenPoolDivider().paddingOnly(
                                          top: 8.kh, bottom: 16.kh),
                                      OriginToDestination(
                                        needPickupText: false,
                                        origin:
                                            "${controller.recurringResp.value.data?[index]?.origin?.name}",
                                        destination:
                                            "${controller.recurringResp.value.data?[index]?.destination?.name}",
                                      ).paddingOnly(bottom: 8.kh),
                                      const GreenPoolDivider().paddingOnly(
                                          top: 8.kh, bottom: 16.kh),
                                      Text(
                                        Strings.riderDetails,
                                        style: TextStyleUtil.k14Bold(),
                                      ).paddingOnly(bottom: 16.kh),
                                      SizedBox(
                                        height: controller
                                                .recurringResp
                                                .value
                                                .data![index]!
                                                .ridesDetails!
                                                .length *
                                            36.kh,
                                        child: ListView.builder(
                                            itemCount: controller
                                                .recurringResp
                                                .value
                                                .data?[index]
                                                ?.ridesDetails
                                                ?.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index1) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${controller.recurringResp.value.data?[index]?.ridesDetails?[index1]?.day}",
                                                    style: TextStyleUtil
                                                        .k14Semibold(
                                                            color: ColorUtil
                                                                .kBlack02),
                                                  ),
                                                  SizedBox(
                                                    height: 24.kh,
                                                    width: 170.kw,
                                                    child: ListView.builder(
                                                      itemCount: controller
                                                                  .recurringResp
                                                                  .value
                                                                  .data?[index]
                                                                  ?.ridesDetails?[
                                                                      index1]
                                                                  ?.ridersDetails
                                                                  ?.length ==
                                                              0
                                                          ? 4
                                                          : (controller
                                                              .recurringResp
                                                              .value
                                                              .data?[index]
                                                              ?.ridesDetails?[
                                                                  index1]
                                                              ?.ridersDetails
                                                              ?.length),
                                                      reverse: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index1) {
                                                        return Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: ClipOval(
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: Size
                                                                  .fromRadius(
                                                                      12.kh),
                                                              child:
                                                                  Image.asset(
                                                                ImageConstant
                                                                    .pngEmptyPassenger,
                                                              ),
                                                            ),
                                                          ),
                                                        ).paddingOnly(
                                                            right: 4.kw);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ).paddingOnly(bottom: 12.kh);
                                            }),
                                      )
                                    ],
                                  ),
                                ).paddingOnly(bottom: 16.kh),
                              );
                            }),
                      ),
                    ],
                  ).paddingOnly(left: 16.kw, right: 16.kw, top: 32.kh),
      ),
    );
  }
}
