import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/driver_cofirm_request_model.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/common_image_view.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/gp_util.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_rides_request_controller.dart';

class BookingConfirmBottom extends StatelessWidget {
  DriverConfirmRequestModelData? driverRideData;

  BookingConfirmBottom({super.key, required this.driverRideData});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(24.kh),
        //TODO: height and drag indicator
        // height: 610.kh,
        width: 100.w,
        decoration: BoxDecoration(color: ColorUtil.kWhiteColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(40.kh), topRight: Radius.circular(40.kh))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  Strings.bookingConfirmed,
                  style: TextStyleUtil.k18Heading600(),
                ).paddingOnly(bottom: 24.kh),
              ),
              Center(
                child: SvgPicture.asset(
                  ImageConstant.svgCompleteTick,
                  height: 64.kh,
                  width: 64.kw,
                ).paddingOnly(bottom: 16.kh),
              ),
              Center(
                child: Text(
                  "${Strings.bookingId} ${(driverRideData?.Id ?? "")}",
                  textAlign: TextAlign.center,
                  style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                ),
              ),
              const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
              Text(
                Strings.riderDetails,
                style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
              ).paddingOnly(bottom: 16.kh),
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(20.kh),
                        child: CommonImageView(url: "${driverRideData?.rideDetails?[0]?.riderDetails?[0]?.profilePic?.url}"),
                      ),
                    ),
                  ).paddingOnly(right: 8.kw),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${driverRideData?.rideDetails?[0]?.riderDetails?[0]?.fullName}",
                        style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                      ).paddingOnly(bottom: 8.kh),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                ImageConstant.svgIconCalendarTime,
                                colorFilter:
                                    ColorFilter.mode(Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01, BlendMode.srcIn),
                              ).paddingOnly(right: 4.kw),
                              Text(
                                // '07 July 2023, 3:00pm',
                                "${driverRideData?.rideDetails?[0]?.date.toString().split("T")[0]}  ${driverRideData?.rideDetails?[0]?.time}",
                                style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack02),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16.kh,
                                color: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                              ),
                              FutureBuilder<String>(
                                future: GpUtil.calculateDistance(
                                    startLat: Get.find<HomeController>().latitude.value,
                                    startLong: Get.find<HomeController>().longitude.value,
                                    endLat: driverRideData?.rideDetails?[0]?.origin?.coordinates?.last ?? 0.0,
                                    endLong: driverRideData?.rideDetails?[0]?.origin?.coordinates?.first ?? 0.0),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Text("..."); // Show a loading indicator while fetching data
                                  } else if (snapshot.hasError) {
                                    // return Text('Error: ${snapshot.error}');
                                    return Text(
                                      Strings.na,
                                      style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack02),
                                    );
                                  } else {
                                    return Text(
                                      snapshot.data.toString(),
                                      style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack02),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const GreenPoolDivider().paddingOnly(bottom: 16.kh),
              OriginToDestination(
                      origin: "${driverRideData?.rideDetails?[0]?.origin?.name}", destination: "${driverRideData?.rideDetails?[0]?.destination?.name}", needPickupText: false)
                  .paddingOnly(bottom: 8.kh),
              const GreenPoolDivider().paddingOnly(top: 8.kh, bottom: 40.kh),
              GreenPoolButton(
                  label: Strings.continueText,
                  onPressed: () {
                    Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
                  }),
              GreenPoolButton(
                  label: Strings.cancelRequest,
                  isBorder: true,
                  onPressed: () {
                    Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
                  }).paddingOnly(top: 16.kh),
            ],
          ),
        ));
  }
}
