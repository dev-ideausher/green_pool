import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/route_widget.dart';
import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/common_image_view.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';
import '../../../utils/date_utils.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_rides_one_time_controller.dart';

class DriverTile extends StatelessWidget {
  MyRidesModelData myRidesModelData;

  DriverTile({super.key, required this.myRidesModelData});

  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    final pendingReq = (myRidesModelData.riderRequestCount ?? 0);
    return GetBuilder<MyRidesOneTimeController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          controller.viewDetails(myRidesModelData);
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(16.kh),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _driverInfo(),

                  12.kheightBox,
                  //-------------------- if rider has done "Find a Ride" and has not selected any time ----------------

                  myRidesModelData.time == ""
                      ? const SizedBox()
                      : Row(
                          children: [
                            SvgPicture.asset(
                              ImageConstant.svgIconCalendarTime,
                              colorFilter: ColorFilter.mode(
                                  isPinkModeOn
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                                  BlendMode.srcIn),
                            ).paddingOnly(right: 4.kw),
                            Text(
                              DateTimeUtils.getDateFormat(
                                  myRidesModelData.time ?? ""),
                              style: TextStyleUtil.k12Regular(
                                  color: ColorUtil.kBlack03),
                            ),
                          ],
                        ).paddingOnly(bottom: 8.kh),
                  const GreenPoolDivider(),
                  RouteWidget(
                      needPickUp: false,
                      origin: myRidesModelData.origin?.name ??
                          LocaleKeys.app_pickup.tr,
                      stop1: myRidesModelData.stops?[0]?.name ?? "",
                      stop2: myRidesModelData.stops?[1]?.name ?? "",
                      destination: myRidesModelData.destination?.name ??
                          LocaleKeys.app_destination.tr),
                  const GreenPoolDivider().paddingOnly(bottom: 16.kh),
                  myRidesModelData.isStarted == true
                      ? _viewDetailsBtn(controller)
                      : myRidesModelData.date == "" ||
                              myRidesModelData.date == null
                          ? _actionsOne(controller, isPinkModeOn)
                          : isWithinTimeRange(myRidesModelData.time ?? "")
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GreenPoolButton(
                                        onPressed: myRidesModelData.isCompleted!
                                            ? () {}
                                            : () {
                                                controller.startRide(
                                                    myRidesModelData);
                                              },
                                        width: 144.kw,
                                        height: 40.kh,
                                        padding: EdgeInsets.all(8.kh),
                                        fontSize: 14.kh,
                                        label: (myRidesModelData.isCompleted ??
                                                false)
                                            ? LocaleKeys.app_rideCompleted.tr
                                            : (myRidesModelData
                                                        .postsInfo?.isEmpty ??
                                                    false)
                                                ? LocaleKeys.app_requests.tr
                                                : LocaleKeys.app_startRide.tr),
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
                                      borderColor: isPinkModeOn
                                          ? ColorUtil.kPrimary3PinkMode
                                          : ColorUtil.kSecondary01,
                                      labelColor: isPinkModeOn
                                          ? ColorUtil.kPrimary3PinkMode
                                          : ColorUtil.kSecondary01,
                                      label: LocaleKeys.app_cancelRide.tr,
                                    ),
                                  ],
                                )
                              : RequestAndCancelButtons(
                                  myRidesModelData: myRidesModelData,
                                  controller: controller,
                                  isPinkModeOn: isPinkModeOn,
                                ),
                ],
              ),
            ).paddingOnly(bottom: 16.kh),
            Visibility(
              visible: pendingReq > 0,
              child: _requestCount(isPinkModeOn),
            ),
          ],
        ),
      );
    });
  }

  ListTile _driverInfo() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
          height: 40.kh,
          width: 40.kw,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100.kh),
              child: CommonImageView(
                  url: Get.find<GetStorageService>().profilePicUrl))),
      title: Text(Get.find<GetStorageService>().getUserName,
          style: TextStyleUtil.k16Bold()),
      subtitle: Text(
        // GpUtil.getDateFormat(myRidesModelData.date) ??
        ((myRidesModelData.time ?? "") == ""
            ? ""
            : DateTimeUtils.convertUtcToLocal(myRidesModelData.time ?? "")),
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
              int profilePicCount = myRidesModelData.postsInfo?.length ?? 0;

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
    );
  }

  GreenPoolButton _viewDetailsBtn(MyRidesOneTimeController controller) {
    return GreenPoolButton(
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
        label: LocaleKeys.app_viewDetails.tr);
  }

  Row _actionsOne(MyRidesOneTimeController controller, bool isPinkModeOn) {
    //view details and cancel button
    return Row(
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
          borderColor: isPinkModeOn
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
          labelColor: isPinkModeOn
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
          label: LocaleKeys.app_viewDetails.tr,
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
          borderColor: isPinkModeOn
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
          labelColor: isPinkModeOn
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
          label: LocaleKeys.app_cancelRide.tr,
        ),
      ],
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
          "${myRidesModelData.riderRequestCount}",
          style: TextStyleUtil.k12Regular(),
        ),
      ),
    );
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
      debugPrint('Error parsing time string: $e');
      return false;
    }
  }
}

class RequestAndCancelButtons extends StatelessWidget {
  const RequestAndCancelButtons({
    super.key,
    required this.myRidesModelData,
    required this.controller,
    required this.isPinkModeOn,
  });

  final MyRidesModelData myRidesModelData;
  final MyRidesOneTimeController controller;
  final bool isPinkModeOn;

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
          borderColor: isPinkModeOn
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
          color:
              isPinkModeOn ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
          labelColor:
              isPinkModeOn ? ColorUtil.kBlack01 : ColorUtil.kSecondary01,
          label: LocaleKeys.app_request.tr,
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
          borderColor: isPinkModeOn
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
          labelColor: isPinkModeOn
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
          label: LocaleKeys.app_cancelRide.tr,
        ),
      ],
    );
  }
}
