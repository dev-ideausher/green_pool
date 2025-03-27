import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/map_rider_confirm_request/views/map_rider_confirm_request_view.dart';
import 'package:green_pool/app/modules/rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/locales.g.dart';
import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../../utils/date_utils.dart';
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
                          ? CommonImageView(svgPath: Assets.svgPinkModegirl)
                          : SvgPicture.asset(ImageConstant.svgNoRides),
                    ),
                    Text(
                      LocaleKeys.app_thereAreNoRidesBetweenTheseCities.tr,
                      style: TextStyleUtil.k24Heading600(),
                      textAlign: TextAlign.center,
                    ).paddingOnly(bottom: 16.kh),
                    Text(
                      LocaleKeys.app_pleaseTryAgainAfterFewDays.tr,
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
                        final data = controller
                            .riderConfirmRequestModel.value.data![index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.RIDER_MY_RIDES_CONFIRM_DETAILS,
                                arguments: controller.riderConfirmRequestModel
                                    .value.data?[index]);
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
                                                      "${data?.driverRideDetails!.driverDetails?[0]?.profilePic?.url}")),
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
                                                  data
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 75.kw,
                                              child: Text(
                                                "${data?.driverRideDetails?.driverDetails?[0]?.fullName.toString().split(" ").first}",
                                                style:
                                                    TextStyleUtil.k16Semibold(
                                                        fontSize: 16.kh),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            8.kwidthBox,
                                            SizedBox(
                                              width: 50.kw,
                                              child: Text.rich(
                                                overflow: TextOverflow.ellipsis,
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${LocaleKeys.app_dollar.tr} ${(data?.price ?? 0)}",
                                                      style:
                                                          TextStyleUtil.k16Bold(
                                                              color: ColorUtil
                                                                  .kSecondary01),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            8.kwidthBox,
                                            InkWell(
                                              onTap: () => controller
                                                  .openMessageFromConfirm(
                                                      data: data
                                                          ?.driverRideDetails,
                                                      ridePostId: controller
                                                              .riderConfirmRequestModel
                                                              .value
                                                              .data![index]!
                                                              .Id ??
                                                          "",
                                                      driverRideId:
                                                          data?.driverRideId ??
                                                              "",
                                                      riderRideId:
                                                          data?.riderRideId ??
                                                              "",
                                                      seats: data
                                                              ?.riderRideDetails
                                                              ?.seatAvailable ??
                                                          0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40.kh),
                                                    border: Border.all(
                                                        color: ColorUtil
                                                            .kSecondary01)),
                                                child: Text(
                                                  LocaleKeys.app_message.tr,
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
                                                  "${DateTimeUtils.getDateFormat(data?.driverRideDetails?.time ?? "")} ${DateTimeUtils.convertUtcToLocal(data?.driverRideDetails?.time ?? "")}",
                                                  style:
                                                      TextStyleUtil.k12Regular(
                                                          color: ColorUtil
                                                              .kBlack02),
                                                ),
                                              ],
                                            ).paddingOnly(right: 2.kw),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.time_to_leave,
                                                  size: 16.kh,
                                                  color:
                                                      Get.find<HomeController>()
                                                              .isPinkModeOn
                                                              .value
                                                          ? ColorUtil
                                                              .kPrimary3PinkMode
                                                          : ColorUtil
                                                              .kSecondary01,
                                                ).paddingOnly(right: 4.kw),
                                                Text(
                                                  '${data?.driverRideDetails?.seatAvailable} seats',
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
                                    .paddingOnly(bottom: 8.kh),
                                OriginToDestination(
                                  origin:
                                      "${data?.driverRideDetails?.origin?.name}",
                                  stop1: data?.driverRideDetails?.stops?[0]
                                          ?.name ??
                                      "",
                                  stop2: data?.driverRideDetails?.stops?[1]
                                          ?.name ??
                                      "",
                                  destination:
                                      "${data?.driverRideDetails?.destination?.name}",
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
                                      label: LocaleKeys.app_accept.tr,
                                      onPressed: () async {
                                        controller
                                            .moveToPaymentFromConfirmSection(
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
                                      label: LocaleKeys.app_reject.tr,
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
