import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';

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
              border: Border.all(width: 0.3.kh, color: ColorUtil.kNeutral10)),
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
                  // GpUtil.getDateFormat(myRidesModelData.date) ??
                  ((myRidesModelData.time ?? "") == ""
                      ? ""
                      : GpUtil.convertUtcToLocal(myRidesModelData.time ?? "")),
                  style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
                ),
                trailing: SizedBox(
                  height: 24.kh,
                  width: 30.w,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: (myRidesModelData.postsInfo?.length ?? 0) +
                          (myRidesModelData.seatAvailable ?? 0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index1) {
                        int profilePicCount =
                            myRidesModelData.postsInfo?.length ?? 0;

                        bool isProfilePic = index1 < profilePicCount;

                        return Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(12.kh),
                              child: isProfilePic
                                  ? CommonImageView(
                                      url: myRidesModelData
                                              .postsInfo?[index1]
                                              ?.riderPostsDetails?[0]
                                              ?.ridersDetails?[0]
                                              ?.profilePic
                                              ?.url ??
                                          "",
                                    )
                                  : Image.asset(
                                      ImageConstant.pngEmptyPassenger,
                                    ),
                            ),
                          ),
                        ).paddingOnly(right: 4.kw);
                      },
                    ),
                  ),
                ),
              ),

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
                          GpUtil.getDateFormat(myRidesModelData.time ?? "") ??
                              "",
                          style: TextStyleUtil.k12Regular(
                              color: ColorUtil.kBlack03),
                        ),
                      ],
                    ).paddingOnly(bottom: 8.kh),
              const GreenPoolDivider().paddingOnly(bottom: 8.kh),
              OriginToDestination(
                needPickupText: true,
                origin: myRidesModelData.origin?.name ?? Strings.pickup,
                stop1: myRidesModelData.stops?[0]?.name ?? "",
                stop2: myRidesModelData.stops?[1]?.name ?? "",
                destination:
                    myRidesModelData.destination?.name ?? Strings.destination,
              ).paddingOnly(bottom: 8.kh),
              const GreenPoolDivider().paddingOnly(bottom: 16.kh),
              myRidesModelData.isStarted == true
                  ? GreenPoolButton(
                      //this button is when the ride is started so the user cannot cancel the ride
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
                                controller
                                    .checkCancellationCount(myRidesModelData);
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
                      : isWithinTimeRange(myRidesModelData.time ?? "")
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
                                                ? Strings.requests
                                                : Strings.startRide),
                                GreenPoolButton(
                                  onPressed: () {
                                    controller.checkCancellationCount(
                                        myRidesModelData);
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
                          : RequestAndCancelButtons(
                              myRidesModelData: myRidesModelData,
                              controller: controller,
                            ),
            ],
          ),
        ).paddingOnly(bottom: 16.kh),
      );
    });
  }

  bool isWithinTimeRange(String timeString) {
    try {
      // Parse the timeString as a UTC DateTime
      DateTime parsedTimeUTC = DateTime.parse(timeString);

      // Convert the parsed time to local time
      DateTime parsedTimeLocal = parsedTimeUTC.toLocal();
      DateTime now = DateTime.now();

      // Check if the parsed date is today
      bool isToday = parsedTimeLocal.year == now.year &&
          parsedTimeLocal.month == now.month &&
          parsedTimeLocal.day == now.day;

      // If the timeString is around midnight or very close to it
      if (parsedTimeLocal.hour == 0 || parsedTimeLocal.hour == 12) {
        // Adjust the parsed time to today's date
        DateTime inputTimeWithCurrentDate = DateTime(
          now.year,
          now.month,
          now.day,
          parsedTimeLocal.hour,
          parsedTimeLocal.minute,
        );

        DateTime startTime =
            inputTimeWithCurrentDate.subtract(const Duration(minutes: 60));
        DateTime endTime =
            inputTimeWithCurrentDate.add(const Duration(minutes: 30));

        return now.isAfter(startTime) && now.isBefore(endTime);
      }

      // Regular time check if it's today
      if (isToday) {
        DateTime inputTimeWithCurrentDate = DateTime(
          now.year,
          now.month,
          now.day,
          parsedTimeLocal.hour,
          parsedTimeLocal.minute,
        );

        DateTime startTime =
            inputTimeWithCurrentDate.subtract(const Duration(minutes: 60));
        DateTime endTime =
            inputTimeWithCurrentDate.add(const Duration(minutes: 30));

        return now.isAfter(startTime) && now.isBefore(endTime);
      }

      return false; // If the timeString is not today and not around midnight
    } catch (e) {
      print('Error parsing time string: $e');
      return false;
    }
  }
}

class RequestAndCancelButtons extends StatelessWidget {
  const RequestAndCancelButtons({
    super.key,
    required this.myRidesModelData,
    required this.controller,
  });

  final MyRidesModelData myRidesModelData;
  final MyRidesOneTimeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GreenPoolButton(
          onPressed: () {
            controller.moveToRequests(myRidesModelData);
          },
          width: 144.kw,
          height: 40.kh,
          padding: EdgeInsets.all(8.kh),
          fontSize: 14.kh,
          borderColor: Get.find<HomeController>().isPinkModeOn.value
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
          labelColor: Get.find<HomeController>().isPinkModeOn.value
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
          label: Strings.request,
        ),
        GreenPoolButton(
          onPressed: () {
            controller.checkCancellationCount(myRidesModelData);
          },
          width: 144.kw,
          height: 40.kh,
          padding: EdgeInsets.all(8.kh),
          fontSize: 14.kh,
          isBorder: true,
          borderColor: Get.find<HomeController>().isPinkModeOn.value
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
          labelColor: Get.find<HomeController>().isPinkModeOn.value
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
          label: Strings.cancelRide,
        ),
      ],
    );
  }
}
