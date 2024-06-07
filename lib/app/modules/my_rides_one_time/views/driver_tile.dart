import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';

import '../../../components/common_image_view.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_rides_one_time_controller.dart';

class DriverTile extends StatelessWidget {
  MyRidesModelData myRidesModelData;

  DriverTile({super.key, required this.myRidesModelData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRidesOneTimeController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          controller.viewDetails(myRidesModelData);
        },
        child: Container(
          padding: EdgeInsets.all(16.kh),
          decoration: BoxDecoration(
              color: ColorUtil.kWhiteColor,
              borderRadius: BorderRadius.circular(8.kh),
              border: Border(
                  bottom: BorderSide(color: ColorUtil.kNeutral7, width: 2.kh))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SizedBox(
                    height: 40.kh,
                    width: 40.kw,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.kh),
                        child: CommonImageView(
                            url: Get.find<HomeController>()
                                .userInfo
                                .value
                                .data
                                ?.profilePic
                                ?.url))),
                title: Text(
                    Get.find<HomeController>().userInfo.value.data?.fullName ??
                        "",
                    style: TextStyleUtil.k16Bold()),
                subtitle: Text(
                  // '07 November 2023',
                  GpUtil.getDateFormat(myRidesModelData.date) ??
                      ((myRidesModelData.time ?? "") == ""
                          ? ""
                          : "${myRidesModelData.time}"),
                  style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
                ),
                trailing: SizedBox(
                  height: 24.kh,
                  width: 170.kw,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: (myRidesModelData.postsInfo?.length ?? 0) == 0
                          ? 4
                          : myRidesModelData.postsInfo?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index1) {
                        return Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(12.kh),
                              child: (myRidesModelData.postsInfo?.length ??
                                          0) ==
                                      0
                                  ? Image.asset(
                                      ImageConstant.pngEmptyPassenger,
                                    )
                                  : CommonImageView(
                                      url:
                                          "${myRidesModelData.postsInfo?[index1]?.riderPostsDetails?[0]?.ridersDetails?[0]?.profilePic?.url}"),
                            ),
                          ),
                        ).paddingOnly(right: 4.kw);
                      },
                    ),
                  ),
                ),
              ),
              // Text(myRidesModelData.origin?.originDestinationFair??"0", style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack03)),

              12.kheightBox,
              //-------------------- if rider has done "Find a Ride" and has not selected any time ----------------

              myRidesModelData.time == ""
                  ? const SizedBox()
                  : Row(
                      children: [
                        SvgPicture.asset(
                          ImageConstant.svgIconCalendarTime,
                          colorFilter: ColorFilter.mode(
                              Get.find<HomeController>().isPinkModeOn.value
                                  ? ColorUtil.kPrimary3PinkMode
                                  : ColorUtil.kSecondary01,
                              BlendMode.srcIn),
                        ).paddingOnly(right: 4.kw),
                        Text(
                          GpUtil.getDateFormat(myRidesModelData.date) ?? "",
                          style: TextStyleUtil.k12Regular(
                              color: ColorUtil.kBlack03),
                        ),
                      ],
                    ).paddingOnly(bottom: 8.kh),
              const GreenPoolDivider().paddingOnly(bottom: 16.kh),
              OriginToDestination(
                needPickupText: false,
                origin: myRidesModelData.origin?.name ?? Strings.pickup,
                destination:
                    myRidesModelData.destination?.name ?? Strings.destination,
              ).paddingOnly(bottom: 8.kh),
              const GreenPoolDivider().paddingOnly(bottom: 16.kh),
              // Obx(
              //   () =>
              myRidesModelData.isStarted == true
                  ?
                  // Text(
                  //     Strings.rideIsCancelled,
                  //     style: TextStyleUtil.k16Bold(color: ColorUtil.kError2),
                  //   )
                  GreenPoolButton(
                      onPressed: myRidesModelData.isCompleted!
                          ? () {}
                          : () {
                              controller.startRide(myRidesModelData);
                            },
                      width: 144.kw,
                      height: 40.kh,
                      padding: EdgeInsets.all(8.kh),
                      fontSize: 14.kh,
                      label: Strings.viewDetails)
                  : myRidesModelData.date == "" || myRidesModelData.date == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GreenPoolButton(
                              onPressed: () {
                                controller.viewDetails(myRidesModelData);
                              },
                              width: 144.kw,
                              height: 40.kh,
                              padding: EdgeInsets.all(8.kh),
                              fontSize: 14.kh,
                              borderColor:
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                              labelColor:
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                              label: Strings.viewDetails,
                            ),
                            GreenPoolButton(
                              onPressed: () {
                                controller.cancelRideAPI(myRidesModelData);
                              },
                              width: 144.kw,
                              height: 40.kh,
                              padding: EdgeInsets.all(8.kh),
                              fontSize: 14.kh,
                              isBorder: true,
                              borderColor:
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                              labelColor:
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                              label: Strings.cancelRide,
                            ),
                          ],
                        )
                      : isToday(myRidesModelData.date ?? "")
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GreenPoolButton(
                                    onPressed: myRidesModelData.isCompleted!
                                        ? () {}
                                        : () {
                                            controller
                                                .startRide(myRidesModelData);
                                          },
                                    width: 144.kw,
                                    height: 40.kh,
                                    padding: EdgeInsets.all(8.kh),
                                    fontSize: 14.kh,
                                    label:
                                        (myRidesModelData.isCompleted ?? false)
                                            ? Strings.rideCompleted
                                            : (myRidesModelData
                                                        .postsInfo?.isEmpty ??
                                                    false)
                                                ? Strings.viewDetails
                                                : Strings.startRide),
                                GreenPoolButton(
                                  onPressed: () {
                                    controller.cancelRideAPI(myRidesModelData);
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
                                  label: Strings.cancelRide,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GreenPoolButton(
                                  onPressed: () {
                                    controller.viewDetails(myRidesModelData);
                                  },
                                  width: 144.kw,
                                  height: 40.kh,
                                  padding: EdgeInsets.all(8.kh),
                                  fontSize: 14.kh,
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
                                  label: Strings.viewDetails,
                                ),
                                GreenPoolButton(
                                  onPressed: () {
                                    controller.cancelRideAPI(myRidesModelData);
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
                                  label: Strings.cancelRide,
                                ),
                              ],
                            ),
              // ),
            ],
          ),
        ).paddingOnly(bottom: 16.kh),
      );
    });
  }

  bool isToday(String s) {
    DateTime dateTime = DateTime.parse(s).toLocal();
    DateTime now = DateTime.now().toLocal();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  bool isNow(String s) {
    DateTime dateTime = DateTime.parse(s).toLocal();
    DateTime now = DateTime.now().toLocal();
    return dateTime.hour == now.hour;
  }
}
