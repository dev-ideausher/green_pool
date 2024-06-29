import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/map_rider_confirm_request/views/map_rider_confirm_request_view.dart';
import 'package:green_pool/app/modules/rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';

class RiderConfirmRequest extends GetView<RiderMyRideRequestController> {
  const RiderConfirmRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const GpProgress()
          : controller.riderConfirmRequestModel.value.data!.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Get.find<HomeController>().isPinkModeOn.value
                          ? CommonImageView(
                              svgPath: ImageConstant.svgNoRidesPink,
                            )
                          : SvgPicture.asset(ImageConstant.svgNoRides),
                    ),
                    Text(
                      "There are no rides between these two cities",
                      style: TextStyleUtil.k24Heading600(),
                      textAlign: TextAlign.center,
                    ).paddingOnly(bottom: 16.kh),
                    Text(
                      "Please try again after few days.",
                      style:
                          TextStyleUtil.k18Regular(color: ColorUtil.kBlack04),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : controller.mapViewType.value
                  ? const MapRiderConfirmRequestView()
                  : ListView.builder(
                      itemCount: controller
                          .riderConfirmRequestModel.value.data?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.RIDER_MY_RIDES_CONFIRM_DETAILS,
                                arguments: index);
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.kh),
                            decoration: BoxDecoration(
                                color: ColorUtil.kWhiteColor,
                                borderRadius: BorderRadius.circular(8.kh),
                                border: Border.all(
                                    color: ColorUtil.kNeutral10,
                                    width: 0.3.kh)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //for profile pic and rating
                                    Stack(
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.kh),
                                              child: CommonImageView(
                                                  height: 64.kh,
                                                  width: 64.kw,
                                                  url:
                                                      "${controller.riderConfirmRequestModel.value.data![index]?.driverRideDetails!?.driverDetails?[0]?.profilePic?.url}")),
                                        ).paddingOnly(bottom: 8.kh),
                                        Positioned(
                                          top: 52.kh,
                                          left: 8.kw,
                                          child: Container(
                                            width: 50.kw,
                                            height: 20.kh,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.kw),
                                            decoration: BoxDecoration(
                                                color:
                                                    Get.find<HomeController>()
                                                            .isPinkModeOn
                                                            .value
                                                        ? ColorUtil
                                                            .kPrimary3PinkMode
                                                        : ColorUtil
                                                            .kSecondary01,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.kh)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color:
                                                      Get.find<HomeController>()
                                                              .isPinkModeOn
                                                              .value
                                                          ? ColorUtil
                                                              .kWhiteColor
                                                          : ColorUtil
                                                              .kYellowColor,
                                                  size: 12.kh,
                                                ).paddingOnly(right: 2.kw),
                                                Text(
                                                  // '0.0',
                                                  //TODO: rating
                                                  controller
                                                          .riderConfirmRequestModel
                                                          .value
                                                          .data?[index]
                                                          ?.driverRideDetails
                                                          ?.driverDetails?[0]
                                                          ?.rating
                                                          ?.toStringAsFixed(
                                                              1) ??
                                                      '0.0',
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyleUtil.k12Semibold(
                                                      color: Get.find<
                                                                  HomeController>()
                                                              .isPinkModeOn
                                                              .value
                                                          ? ColorUtil.kBlack02
                                                          : ColorUtil
                                                              .kWhiteColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).paddingOnly(right: 16.kw, bottom: 16.kh),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          //TODO: space between
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${controller.riderConfirmRequestModel.value.data?[index]?.driverRideDetails?.driverDetails?[0]?.fullName}",
                                              style: TextStyleUtil.k16Semibold(
                                                  fontSize: 16.kh),
                                            ),
                                            8.kwidthBox,
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "\$ ${(controller.riderConfirmRequestModel.value.data![index]?.price ?? 0)}",
                                                    style:
                                                        TextStyleUtil.k16Bold(
                                                            color: ColorUtil
                                                                .kSecondary01),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            8.kwidthBox,
                                            InkWell(
                                              onTap: () => controller
                                                  .openMessageFromConfirm(
                                                      controller
                                                          .riderConfirmRequestModel
                                                          .value
                                                          .data?[index]
                                                          ?.driverRideDetails),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40.kh),
                                                    border: Border.all(
                                                        color: ColorUtil
                                                            .kSecondary01)),
                                                child: Text(
                                                  Strings.message,
                                                  style: TextStyleUtil
                                                      .k12Semibold(),
                                                ).paddingSymmetric(
                                                    vertical: 4.kh,
                                                    horizontal: 16.kw),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  ImageConstant
                                                      .svgIconCalendarTime,
                                                  colorFilter: ColorFilter.mode(
                                                      Get.find<HomeController>()
                                                              .isPinkModeOn
                                                              .value
                                                          ? ColorUtil
                                                              .kPrimary3PinkMode
                                                          : ColorUtil
                                                              .kSecondary01,
                                                      BlendMode.srcIn),
                                                ).paddingOnly(right: 4.kw),
                                                Text(
                                                  "${GpUtil.getDateFormat(controller.riderConfirmRequestModel.value.data?[index]?.driverRideDetails?.date)}  ${controller.riderConfirmRequestModel.value.data?[index]?.driverRideDetails?.time}",
                                                  style:
                                                      TextStyleUtil.k12Regular(
                                                          color: ColorUtil
                                                              .kBlack02),
                                                ),
                                              ],
                                            ).paddingOnly(right: 10.kw),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.time_to_leave,
                                                  size: 18.kh,
                                                  color:
                                                      Get.find<HomeController>()
                                                              .isPinkModeOn
                                                              .value
                                                          ? ColorUtil
                                                              .kPrimary3PinkMode
                                                          : ColorUtil
                                                              .kSecondary01,
                                                ).paddingOnly(right: 5.kw),
                                                Text(
                                                  '${controller.riderConfirmRequestModel.value.data![index]?.driverRideDetails?.seatAvailable} seats',
                                                  style:
                                                      TextStyleUtil.k14Regular(
                                                          color: ColorUtil
                                                              .kBlack03),
                                                ),
                                              ],
                                            ).paddingOnly(top: 8.kh),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const GreenPoolDivider()
                                    .paddingOnly(bottom: 16.kh),
                                OriginToDestination(
                                  origin:
                                      "${controller.riderConfirmRequestModel.value.data?[index]?.driverRideDetails?.origin?.name}",
                                  destination:
                                      "${controller.riderConfirmRequestModel.value.data?[index]?.driverRideDetails?.destination?.name}",
                                  needPickupText: false,
                                ).paddingOnly(bottom: 8.kh),
                                const GreenPoolDivider()
                                    .paddingOnly(bottom: 16.kh),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GreenPoolButton(
                                      width: 144.kw,
                                      height: 40.kh,
                                      padding: EdgeInsets.all(8.kh),
                                      fontSize: 14.kh,
                                      label: Strings.accept,
                                      onPressed: () async {
                                        // await controller.acceptDriversRequestAPI(index,showAcceptBottom: true);
                                        controller
                                            .moveToPaymentFromConfirmSection(
                                                index,
                                                controller
                                                    .riderConfirmRequestModel
                                                    .value
                                                    .data![index]!);
                                      },
                                    ),
                                    GreenPoolButton(
                                      onPressed: () {
                                        controller
                                            .rejectDriversRequestAPI(index);
                                      },
                                      width: 144.kw,
                                      height: 40.kh,
                                      padding: EdgeInsets.all(8.kh),
                                      fontSize: 14.kh,
                                      isBorder: true,
                                      borderColor: Get.find<HomeController>()
                                              .isPinkModeOn
                                              .value
                                          ? ColorUtil.kPrimary3PinkMode
                                          : ColorUtil.kSecondary01,
                                      labelColor: Get.find<HomeController>()
                                              .isPinkModeOn
                                              .value
                                          ? ColorUtil.kPrimary3PinkMode
                                          : ColorUtil.kSecondary01,
                                      label: 'Reject',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ).paddingOnly(bottom: 16.kh),
                        );
                      },
                    ).paddingOnly(top: 32.kh, left: 16.kw, right: 16.kw),
    );
  }
}
