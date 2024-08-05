import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/map_rider_send_request/views/map_rider_send_request_view.dart';
import 'package:green_pool/app/modules/rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/assets.dart';
import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/snackbar.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';

class RiderSendRequest extends GetView<RiderMyRideRequestController> {
  const RiderSendRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const GpProgress()
          : controller.riderSendRequestModel.value.data?.isEmpty ?? true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Get.find<HomeController>().isPinkModeOn.value
                          ? CommonImageView(svgPath: Assets.svgPinkModegirl)
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
                  ? const MapRiderSendRequestView()
                  : ListView.builder(
                      itemCount:
                          controller.riderSendRequestModel.value.data?.length,
                      itemBuilder: (context, index) {
                        final rideDetails =
                            controller.riderSendRequestModel.value.data![index];
                        return GestureDetector(
                          onTap: () {
                            controller.moveToDetailsPage(rideDetails);
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
                                                    "${rideDetails?.driverDetails![0]?.profilePic?.url}"),
                                          ),
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
                                                  rideDetails
                                                          ?.driverDetails?[0]!
                                                          .rating
                                                          ?.toStringAsFixed(
                                                              1) ??
                                                      '0.0',
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${rideDetails!.driverDetails![0]!.fullName}  ",
                                                  style:
                                                      TextStyleUtil.k16Semibold(
                                                          fontSize: 16.kh),
                                                ),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "\$ ${rideDetails?.price ?? "0"}",
                                                      style:
                                                          TextStyleUtil.k16Bold(
                                                              color: ColorUtil
                                                                  .kSecondary01),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  if (rideDetails?.date != null)
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
                                                  if (rideDetails?.date != null)
                                                    Text(
                                                      "${GpUtil.getDateFormat(rideDetails?.time ?? "")}  ${GpUtil.convertUtcToLocal(rideDetails?.time ?? "")}",
                                                      style: TextStyleUtil
                                                          .k12Regular(
                                                              color: ColorUtil
                                                                  .kBlack02),
                                                    ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.time_to_leave,
                                                    size: 18.kh,
                                                    color: Get.find<
                                                                HomeController>()
                                                            .isPinkModeOn
                                                            .value
                                                        ? ColorUtil
                                                            .kPrimary3PinkMode
                                                        : ColorUtil
                                                            .kSecondary01,
                                                  ).paddingOnly(right: 8.kw),
                                                  Text(
                                                    '${rideDetails?.seatAvailable ?? "0"} seats',
                                                    style: TextStyleUtil
                                                        .k14Regular(
                                                            color: ColorUtil
                                                                .kBlack03),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ).paddingOnly(top: 8.kh),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const GreenPoolDivider()
                                    .paddingOnly(bottom: 16.kh),
                                OriginToDestination(
                                        needPickupText: false,
                                        origin: "${rideDetails?.origin?.name}",
                                        stop1:
                                            rideDetails.stops?[0]?.name ?? "",
                                        stop2:
                                            rideDetails.stops?[1]?.name ?? "",
                                        destination:
                                            "${rideDetails?.destination?.name}")
                                    .paddingOnly(bottom: 8.kh),
                                const GreenPoolDivider()
                                    .paddingOnly(bottom: 16.kh),
                                //

                                //
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // InkWell(
                                    //   onTap: () => controller.openMessage(
                                    //       controller.riderSendRequestModel.value
                                    //           .data![index]!),
                                    //   child: Container(
                                    //     height: 38.kh,
                                    //     width: 134.kw,
                                    //     alignment: Alignment.center,
                                    //     decoration: BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.circular(40.kh),
                                    //         border: Border.all(
                                    //             color: ColorUtil.kSecondary01)),
                                    //     child: Text(
                                    //       Strings.message,
                                    //       style: TextStyleUtil.k12Semibold(),
                                    //     ),
                                    //   ),
                                    // ).paddingAll(8.kh),
                                    GreenPoolButton(
                                      onPressed: () {
                                        controller.openMessage(rideDetails!);
                                      },
                                      label: Strings.message,
                                      isBorder: true,
                                      fontSize: 14.kh,
                                      height: 38.kh,
                                      width: 134.kw,
                                      padding: EdgeInsets.all(0.kh),
                                    ),
                                    GreenPoolButton(
                                      width: 144.kw,
                                      height: 40.kh,
                                      padding: EdgeInsets.all(8.kh),
                                      fontSize: 14.kh,
                                      label: controller
                                                  .riderSendRequestModel
                                                  .value
                                                  .data![index]
                                                  .requestSent ??
                                              false
                                          ? Strings.sent
                                          : Strings.request,
                                      onPressed: () async {
                                        if (controller
                                                .riderSendRequestModel
                                                .value
                                                .data![index]
                                                .requestSent ??
                                            false) {
                                          showMySnackbar(
                                              msg:
                                                  "The request has already been sent.");
                                        } else {
                                          controller
                                              .moveToPaymentFromSendRequest(
                                                  rideDetails);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ).paddingOnly(bottom: 16.kh),
                        );
                      },
                    ).paddingOnly(top: 12.kh, left: 16.kw, right: 16.kw),
    );
  }
}
