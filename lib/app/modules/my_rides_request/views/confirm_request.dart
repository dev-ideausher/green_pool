import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/map_driver_confirm_request/controllers/map_driver_confirm_request_controller.dart';
import 'package:green_pool/app/modules/map_driver_confirm_request/views/map_driver_confirm_request_view.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_rides_request_controller.dart';

class ConfirmRequest extends GetView<MyRidesRequestController> {
  const ConfirmRequest({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => MapDriverConfirmRequestController(),
    );
    return Obx(
      () => controller.confirmRequestModel.value.data == null
          ? const GpProgress()
          : controller.confirmRequestModel.value.data!.isEmpty
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
                      Strings.noRidesBetweenCities,
                      style: TextStyleUtil.k24Heading600(),
                      textAlign: TextAlign.center,
                    ).paddingOnly(bottom: 16.kh),
                    Text(
                      Strings.pleaseTryAgain,
                      style:
                          TextStyleUtil.k18Regular(color: ColorUtil.kBlack04),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : controller.mapViewType.value
                  ? const MapDriverConfirmRequestView()
                  : ListView.builder(
                      itemCount:
                          controller.confirmRequestModel.value.data?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(16.kh),
                            decoration: BoxDecoration(
                              color: ColorUtil.kWhiteColor,
                              borderRadius: BorderRadius.circular(8.kh),
                              border: Border(
                                bottom: BorderSide(
                                    color: ColorUtil.kNeutral7, width: 2.kh),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: ClipOval(
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(20.kh),
                                          child: CommonImageView(
                                              url:
                                                  "${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.riderDetails?[0]?.profilePic?.url}"),
                                        ),
                                      ),
                                    ).paddingOnly(right: 8.kw),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.riderDetails?[0]?.fullName}",
                                          style: TextStyleUtil.k16Semibold(
                                              fontSize: 16.kh),
                                        ).paddingOnly(bottom: 8.kh),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                  // '07 July 2023, 3:00pm',
                                                  "${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.date.toString().split("T")[0] ?? ""}  ${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.time ?? ""}",
                                                  style:
                                                      TextStyleUtil.k12Regular(
                                                          color: ColorUtil
                                                              .kBlack02),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 16.kh,
                                                  color:
                                                      Get.find<HomeController>()
                                                              .isPinkModeOn
                                                              .value
                                                          ? ColorUtil
                                                              .kPrimary3PinkMode
                                                          : ColorUtil
                                                              .kSecondary01,
                                                ),
                                                Text(
                                                  // "${controller.confirmRequestModel.value.data?[index]?.distance} km away",
                                                  "${GpUtil.calculateDistance(startLat: controller.latitude, startLong: controller.longitude, endLat: controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.origin?.coordinates?.last ?? controller.latitude, endLong: controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.origin?.coordinates?.first ?? controller.longitude).toStringAsFixed(2)} ${Strings.kmAway}",
                                                  style:
                                                      TextStyleUtil.k12Regular(
                                                          color: ColorUtil
                                                              .kBlack02),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {},
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
                                              style:
                                                  TextStyleUtil.k12Semibold(),
                                            ).paddingSymmetric(
                                                vertical: 4.kh,
                                                horizontal: 16.kw),
                                          ),
                                        ).paddingSymmetric(vertical: 8.kh),
                                      ],
                                    ),
                                  ],
                                ),
                                const GreenPoolDivider()
                                    .paddingOnly(bottom: 16.kh),
                                OriginToDestination(
                                        needPickupText: false,
                                        origin:
                                            "${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.origin?.name}",
                                        destination:
                                            "${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.destination?.name}")
                                    .paddingOnly(bottom: 8.kh),
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
                                        try {
                                          await controller
                                              .acceptRidersRequestAPI(index);
                                          await Get.bottomSheet(
                                            Container(
                                                padding: EdgeInsets.all(24.kh),
                                                //TODO: height and drag indicator
                                                // height: 610.kh,
                                                width: 100.w,
                                                decoration: BoxDecoration(
                                                    color: ColorUtil
                                                        .kWhiteColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    40.kh),
                                                            topRight: Radius
                                                                .circular(
                                                                    40.kh))),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          Strings
                                                              .bookingConfirmed,
                                                          style: TextStyleUtil
                                                              .k18Heading600(),
                                                        ).paddingOnly(
                                                            bottom: 24.kh),
                                                      ),
                                                      Center(
                                                        child: SvgPicture.asset(
                                                          ImageConstant
                                                              .svgCompleteTick,
                                                          height: 64.kh,
                                                          width: 64.kw,
                                                        ).paddingOnly(
                                                            bottom: 16.kh),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          "${Strings.bookingId} ${controller.confirmRequestModel.value.data?[index]?.Id}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyleUtil
                                                              .k16Semibold(
                                                                  fontSize:
                                                                      16.kh),
                                                        ),
                                                      ),
                                                      const GreenPoolDivider()
                                                          .paddingSymmetric(
                                                              vertical: 16.kh),
                                                      Text(
                                                        Strings.riderDetails,
                                                        style: TextStyleUtil
                                                            .k16Semibold(
                                                                fontSize:
                                                                    16.kh),
                                                      ).paddingOnly(
                                                          bottom: 16.kh),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child: ClipOval(
                                                              child: SizedBox
                                                                  .fromSize(
                                                                size: Size
                                                                    .fromRadius(
                                                                        20.kh),
                                                                child: CommonImageView(
                                                                    url:
                                                                        "${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.riderDetails?[0]?.profilePic?.url}"),
                                                              ),
                                                            ),
                                                          ).paddingOnly(
                                                              right: 8.kw),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.riderDetails?[0]?.fullName}",
                                                                style: TextStyleUtil
                                                                    .k16Semibold(
                                                                        fontSize:
                                                                            16.kh),
                                                              ).paddingOnly(
                                                                  bottom: 8.kh),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                        ImageConstant
                                                                            .svgIconCalendarTime,
                                                                        colorFilter: ColorFilter.mode(
                                                                            Get.find<HomeController>().isPinkModeOn.value
                                                                                ? ColorUtil.kPrimary3PinkMode
                                                                                : ColorUtil.kSecondary01,
                                                                            BlendMode.srcIn),
                                                                      ).paddingOnly(
                                                                          right:
                                                                              4.kw),
                                                                      Text(
                                                                        // '07 July 2023, 3:00pm',
                                                                        "${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.date.toString().split("T")[0]}  ${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.time}",
                                                                        style: TextStyleUtil.k12Regular(
                                                                            color:
                                                                                ColorUtil.kBlack02),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .location_on,
                                                                        size: 16
                                                                            .kh,
                                                                        color: Get.find<HomeController>().isPinkModeOn.value
                                                                            ? ColorUtil.kPrimary3PinkMode
                                                                            : ColorUtil.kSecondary01,
                                                                      ),
                                                                      Text(
                                                                        "${GpUtil.calculateDistance(startLat: controller.latitude, startLong: controller.longitude, endLat: controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.origin?.coordinates?.last ?? controller.latitude, endLong: controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.origin?.coordinates?.first ?? controller.longitude).toStringAsFixed(2)} ${Strings.kmAway}",
                                                                        style: TextStyleUtil.k12Regular(
                                                                            color:
                                                                                ColorUtil.kBlack02),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const GreenPoolDivider()
                                                          .paddingOnly(
                                                              bottom: 16.kh),
                                                      OriginToDestination(
                                                              origin:
                                                                  "${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.origin?.name}",
                                                              destination:
                                                                  "${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.destination?.name}",
                                                              needPickupText:
                                                                  false)
                                                          .paddingOnly(
                                                              bottom: 8.kh),
                                                      const GreenPoolDivider()
                                                          .paddingOnly(
                                                              top: 8.kh,
                                                              bottom: 40.kh),
                                                      GreenPoolButton(
                                                          label: Strings
                                                              .continueText,
                                                          onPressed: () {
                                                            Get.until((route) =>
                                                                Get.currentRoute ==
                                                                Routes
                                                                    .BOTTOM_NAVIGATION);
                                                          }),
                                                      GreenPoolButton(
                                                              label: Strings
                                                                  .cancelRequest,
                                                              isBorder: true,
                                                              onPressed: () {
                                                                Get.until((route) =>
                                                                    Get.currentRoute ==
                                                                    Routes
                                                                        .BOTTOM_NAVIGATION);
                                                              })
                                                          .paddingOnly(
                                                              top: 16.kh),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        } catch (e) {
                                          debugPrint(e.toString());
                                        }
                                      },
                                    ),
                                    GreenPoolButton(
                                      onPressed: () async {
                                        try {
                                          await controller
                                              .rejectRidersRequestAPI(index);
                                        } catch (e) {
                                          throw Exception(e);
                                        }
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
                                      label: Strings.reject,
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
