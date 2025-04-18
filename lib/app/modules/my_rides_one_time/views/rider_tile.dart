import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/route_widget.dart';
import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/common_image_view.dart';
import '../../../components/green_pool_divider.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../../utils/date_utils.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_rides_one_time_controller.dart';

class RiderTile extends StatelessWidget {
  MyRidesModelData? myRidesModelData;

  RiderTile({super.key, this.myRidesModelData});

  @override
  Widget build(BuildContext context) {
    final bool isConfirmedAndNotStarted =
        (myRidesModelData?.rideStatus == "Confirmed" &&
            myRidesModelData?.isStarted == false);
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    final pendingReq = (myRidesModelData?.driverRequestCount ?? 0);

    return GetBuilder<MyRidesOneTimeController>(builder: (controller) {
      return GestureDetector(
        onTap: () => controller.riderPagePageOpen(myRidesModelData!),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 16.kh,
                  right: 16.kh,
                  bottom: 16.kh,
                  top: isConfirmedAndNotStarted ? 64.kh : 16.kh),
              decoration: BoxDecoration(
                  color: ColorUtil.kWhiteColor,
                  borderRadius: BorderRadius.circular(8.kh),
                  border: Border.all(
                      width: pendingReq > 0 ? 0.8.kh : 0.3.kh,
                      color: pendingReq > 0
                          ? isPinkModeOn
                              ? ColorUtil.kPrimaryPinkMode
                              : ColorUtil.kPrimary01
                          : ColorUtil.kNeutral10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- if rider and driver both have confirmed the ride ------------------- //
                  myRidesModelData!.rideStatus == "Confirmed"
                      ? Column(
                          children: [
                            Row(
                              children: [
                                //for profile pic and rating

                                Stack(
                                  children: [
                                    Container(
                                      height: 64.kh,
                                      width: 64.kw,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.kh),
                                        child: (myRidesModelData
                                                        ?.confirmDriverDetails?[
                                                            0]
                                                        ?.driverPostsDetails
                                                        ?.length ??
                                                    0) ==
                                                0
                                            ? CommonImageView(
                                                imagePath: ImageConstant
                                                    .pngEmptyPassenger,
                                              )
                                            : CommonImageView(
                                                url:
                                                    "${myRidesModelData!.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.profilePic?.url}"),
                                      ),
                                    ).paddingOnly(bottom: 8.kh),
                                    Positioned(
                                      top: 52.kh,
                                      left: 8.kw,
                                      child: Container(
                                        width: 48.kw,
                                        height: 20.kh,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.kw),
                                        decoration: BoxDecoration(
                                            color: isPinkModeOn
                                                ? ColorUtil.kPrimary3PinkMode
                                                : ColorUtil.kSecondary01,
                                            borderRadius:
                                                BorderRadius.circular(16.kh)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: isPinkModeOn
                                                  ? ColorUtil.kWhiteColor
                                                  : ColorUtil.kYellowColor,
                                              size: 12.kh,
                                            ).paddingOnly(right: 2.kw),
                                            Text(
                                              "${myRidesModelData?.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.rating}",
                                              style: TextStyleUtil.k12Semibold(
                                                  color:
                                                      Get.find<HomeController>()
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
                                //for name and date
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${myRidesModelData?.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.fullName}",
                                            style: TextStyleUtil.k16Bold(),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: LocaleKeys.app_fare.tr,
                                                  style:
                                                      TextStyleUtil.k14Semibold(
                                                          color: ColorUtil
                                                              .kSecondary01),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '\$ ${myRidesModelData?.confirmDriverDetails?[0]?.price}',
                                                  style:
                                                      TextStyleUtil.k16Semibold(
                                                          fontSize: 16.kh,
                                                          color: ColorUtil
                                                              .kSecondary01),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ).paddingOnly(bottom: 8.kh),
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
                                                    isPinkModeOn
                                                        ? ColorUtil
                                                            .kPrimary3PinkMode
                                                        : ColorUtil
                                                            .kSecondary01,
                                                    BlendMode.srcIn),
                                              ).paddingOnly(right: 4.kw),
                                              Text(
                                                '${DateTimeUtils.getDateFormat(myRidesModelData?.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.time ?? "")}  ${DateTimeUtils.convertUtcToLocal(myRidesModelData?.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.time ?? "")}',
                                                style: TextStyleUtil.k12Regular(
                                                    color: ColorUtil.kBlack03),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.time_to_leave,
                                                size: 16.kh,
                                                color: isPinkModeOn
                                                    ? ColorUtil
                                                        .kPrimary3PinkMode
                                                    : ColorUtil.kSecondary01,
                                              ).paddingOnly(right: 4.kw),
                                              Text(
                                                '${myRidesModelData?.seatAvailable} seats',
                                                style: TextStyleUtil.k14Regular(
                                                    color: ColorUtil.kBlack03),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox(),

                  // time view if not confirmed by rider
                  myRidesModelData?.rideStatus != "Confirmed"
                      ? Row(
                          children: [
                            // ----------- if rider has not seleted any date while doing "Find a Ride" -------------//

                            myRidesModelData?.date == null
                                ? const SizedBox()
                                : SvgPicture.asset(
                                    ImageConstant.svgIconCalendarTime,
                                    colorFilter: ColorFilter.mode(
                                        isPinkModeOn
                                            ? ColorUtil.kPrimary3PinkMode
                                            : ColorUtil.kSecondary01,
                                        BlendMode.srcIn),
                                  ).paddingOnly(right: 4.kw),
                            myRidesModelData?.date == null
                                ? const SizedBox()
                                : Text(
                                    // '07 Nov 2023, 3:00pm',
                                    '${DateTimeUtils.getDateFormat(myRidesModelData?.time ?? "")}  ${DateTimeUtils.convertUtcToLocal(myRidesModelData?.time ?? "")}',
                                    style: TextStyleUtil.k16Bold(),
                                  ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.center,
                              child: GreenPoolButton(
                                onPressed: () {
                                  controller.riderDeleteRide(
                                      myRidesModelData?.Id ?? "");
                                },
                                label: "Delete",
                                height: 32.kh,
                                width: 96.kw,
                                padding: EdgeInsets.all(0.kh),
                                isBorder: true,
                                fontSize: 12.kh,
                                borderColor: isPinkModeOn
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01,
                                labelColor: isPinkModeOn
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01,
                              ),
                            )
                          ],
                        ).paddingOnly(bottom: 16.kh)
                      : const SizedBox(),

                  Visibility(
                    visible: myRidesModelData?.isStarted ?? false,
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.kw, vertical: 8.kh),
                      decoration: BoxDecoration(
                          color: ColorUtil.kPrimary07,
                          borderRadius: BorderRadius.circular(4.kh)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.emoji_transportation,
                            color: ColorUtil.kBlack01,
                          ).paddingOnly(right: 8.kw),
                          Text(
                            LocaleKeys.app_ongoingRide.tr,
                            style: TextStyleUtil.k14Regular(),
                          ),
                        ],
                      ),
                    ).paddingOnly(bottom: 16.kh),
                  ),
                  //middle divider
                  myRidesModelData?.date == null
                      ? const SizedBox()
                      : const GreenPoolDivider().paddingOnly(bottom: 8.kh),
                  RouteWidget(
                          needPickUp: true,
                          origin: "${myRidesModelData?.origin?.name}",
                          stop1: myRidesModelData?.stops?[0]?.name ?? "",
                          stop2: myRidesModelData?.stops?[1]?.name ?? "",
                          destination: "${myRidesModelData?.destination?.name}")
                      .paddingOnly(bottom: 8.kh),

                  // view details button and cancel ride button
                  myRidesModelData?.rideStatus != "Confirmed"
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GreenPoolButton(
                              height: 40.kh,
                              width: 144.kw,
                              padding: EdgeInsets.all(0.kh),
                              onPressed: () {
                                controller.riderPagePageOpen(myRidesModelData!);
                              },
                              label: LocaleKeys.app_viewDetails.tr,
                              fontSize: 14.kh,
                              borderColor: isPinkModeOn
                                  ? ColorUtil.kPrimary3PinkMode
                                  : ColorUtil.kSecondary01,
                              labelColor: isPinkModeOn
                                  ? ColorUtil.kPrimary3PinkMode
                                  : ColorUtil.kSecondary01,
                            ),
                            Visibility(
                              visible: myRidesModelData?.isStarted != true,
                              child: GreenPoolButton(
                                height: 40.kh,
                                width: 144.kw,
                                padding: EdgeInsets.all(0.kh),
                                onPressed: () {
                                  controller
                                      .riderCancelRideAPI(myRidesModelData!);
                                },
                                isBorder: true,
                                label: LocaleKeys.app_cancelRide.tr,
                                fontSize: 14.kh,
                                borderColor: isPinkModeOn
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01,
                                labelColor: isPinkModeOn
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ).paddingOnly(bottom: 16.kh),
            Visibility(
              visible: isConfirmedAndNotStarted,
              child:
                  _driverArrivalTime(isPinkModeOn).paddingOnly(bottom: 12.kh),
            ),
            Visibility(
                visible: pendingReq > 0, child: _requestCount(isPinkModeOn)),
          ],
        ),
      );
    });
  }

  Container _driverArrivalTime(bool isPinkModeOn) {
    return Container(
      height: 48.kh,
      padding: EdgeInsets.symmetric(horizontal: 16.kw, vertical: 12.kh),
      decoration: BoxDecoration(
          color: isPinkModeOn
              ? ColorUtil.kPrimary2PinkMode
              : ColorUtil.kSecondary01,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.kh), topRight: Radius.circular(8.kh))),
      child: Row(
        children: [
          Icon(Icons.watch_later_outlined,
              color: isPinkModeOn ? ColorUtil.kBlack01 : ColorUtil.kWhiteColor),
          4.kwidthBox,
          Text(
            myRidesModelData?.rideStatus == "Confirmed"
                ? DateTimeUtils.getArrivalTimeOfDriver(DateTime.parse(
                    myRidesModelData?.confirmDriverDetails?.first
                            ?.driverPostsDetails?.first?.time ??
                        ""))
                : "",
            style: TextStyleUtil.k12Regular(
                color:
                    isPinkModeOn ? ColorUtil.kBlack01 : ColorUtil.kWhiteColor),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color:
                  isPinkModeOn ? ColorUtil.kWhiteColor : ColorUtil.kPrimary01,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on,
              color: isPinkModeOn
                  ? ColorUtil.kPrimary2PinkMode
                  : ColorUtil.kSecondary01,
            ),
          )
        ],
      ),
    );
  }

  Positioned _requestCount(bool isPinkModeOn) {
    return Positioned(
      right: 0.0.kh,
      top: -12.0.kh,
      child: Container(
        padding: EdgeInsets.all(6.kh),
        decoration: BoxDecoration(
          color:
              isPinkModeOn ? ColorUtil.kPrimary3PinkMode : ColorUtil.kPrimary01,
          shape: BoxShape.circle,
        ),
        child: Text(
          "${myRidesModelData?.driverRequestCount}",
          style: TextStyleUtil.k12Regular(),
        ),
      ),
    );
  }
}
