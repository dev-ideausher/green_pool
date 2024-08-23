import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/common_image_view.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/gp_util.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_rides_confirm_details_controller.dart';

class MyRidesConfirmDetailsView
    extends GetView<MyRidesConfirmDetailsController> {
  const MyRidesConfirmDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.riderDetails),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //details with pick up and drop off
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //for profile pic and rating
                  Container(
                    height: 64.kh,
                    width: 64.kw,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.kh),
                        child: CommonImageView(
                            url:
                                "${controller.riderRideDetails.rideDetails?.first?.riderDetails?[0]?.profilePic?.url}")),
                  )
                      .paddingOnly(bottom: 8.kh)
                      .paddingOnly(right: 16.kw, bottom: 16.kh),
                  //for name and date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              // 'Sam Alexander',
                              "${controller.riderRideDetails.rideDetails?.first?.riderDetails?[0]?.fullName}",
                              style: TextStyleUtil.k16Bold(),
                            ),
                            Obx(
                              () => GreenPoolButton(
                                onPressed: () {
                                  controller.openMessage(controller
                                      .riderRideDetails.rideDetails!.first!);
                                },
                                isLoading: controller.isBtnLoading.value,
                                label: Strings.message,
                                loadingColor: Get.find<HomeController>()
                                        .isPinkModeOn
                                        .value
                                    ? ColorUtil.kPrimary2PinkMode
                                    : ColorUtil.kPrimary01,
                                isBorder: true,
                                width: 96.kw,
                                height: 32.kh,
                                fontSize: 14.kh,
                                padding: const EdgeInsets.all(0),
                              ).paddingOnly(top: 8.kh),
                            ),
                          ],
                        ).paddingOnly(bottom: 8.kh, top: 4.kh),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  ImageConstant.svgIconCalendarTime,
                                  colorFilter: ColorFilter.mode(
                                      Get.find<HomeController>()
                                              .isPinkModeOn
                                              .value
                                          ? ColorUtil.kPrimary3PinkMode
                                          : ColorUtil.kSecondary01,
                                      BlendMode.srcIn),
                                ).paddingOnly(right: 4.kw),
                                Text(
                                  "${GpUtil.getDateFormat(controller.riderRideDetails.rideDetails?.first?.time ?? "")}  ${GpUtil.convertUtcToLocal(controller.riderRideDetails.rideDetails?.first?.time ?? "")}",
                                  style: TextStyleUtil.k12Regular(
                                      color: ColorUtil.kBlack03),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.time_to_leave,
                                  size: 18.kh,
                                  color: Get.find<HomeController>()
                                          .isPinkModeOn
                                          .value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                                ).paddingOnly(right: 8.kw),
                                Text(
                                  "${controller.riderRideDetails.rideDetails?.first?.seatAvailable} seats",
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
              ).paddingOnly(top: 8.kh),
              //middle divider
              const GreenPoolDivider(),
              OriginToDestination(
                      origin:
                          "${controller.riderRideDetails.rideDetails?.first?.origin?.name}",
                      stop1: "",
                      stop2: "",
                      destination:
                          "${controller.riderRideDetails.rideDetails?.first?.destination?.name}",
                      needPickupText: true)
                  .paddingSymmetric(vertical: 8.kh),
              //bottom line
              const GreenPoolDivider(),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                //rating column
                children: [
                  Text(
                    Strings.rating,
                    style: TextStyleUtil.k12Semibold(),
                  ).paddingOnly(bottom: 4.kh),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.kw, vertical: 2.kh),
                    decoration: BoxDecoration(
                      color: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kPrimary01,
                      borderRadius: BorderRadius.circular(16.kh),
                    ),
                    child: Row(children: [
                      Icon(
                        Icons.star,
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kWhiteColor
                            : ColorUtil.kYellowColor,
                        size: 12.kh,
                      ).paddingOnly(right: 4.kw),
                      Text(
                        "${controller.riderRideDetails.rideDetails?.first?.riderDetails?[0]?.rating?.roundToDouble()}",
                        style: TextStyleUtil.k14Regular(),
                      ),
                    ]),
                  ),
                ],
              ),
              Column(
                //ride with column
                children: [
                  Text(
                    Strings.totalRides,
                    style: TextStyleUtil.k12Semibold(),
                  ).paddingOnly(bottom: 4.kh),
                  Text(
                    "${controller.riderRideDetails.rideDetails?.first?.riderDetails?[0]?.totalRides}",
                    style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                  ),
                ],
              ),
              Column(
                //joined in column
                children: [
                  Text(
                    Strings.joined,
                    style: TextStyleUtil.k12Semibold(),
                  ).paddingOnly(bottom: 4.kh),
                  Text(
                    '${Strings.inA} ${controller.riderRideDetails.rideDetails?.first?.riderDetails?.first?.createdAt.toString().split("-")[0]}',
                    style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(vertical: 8.kh),

          const GreenPoolDivider().paddingOnly(bottom: 16.kh),

          Text(
            Strings.description,
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          Wrap(
            children: [
              Text(
                  controller.riderRideDetails.rideDetails?.first?.description ??
                      "NA")
            ],
          ),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GreenPoolButton(
                onPressed: () {
                  controller
                      .acceptRidersRequestAPI(controller.riderRideDetails);
                },
                width: 162.kw,
                label: Strings.accept,
              ),
              GreenPoolButton(
                onPressed: () {
                  controller
                      .rejectRidersRequestAPI(controller.riderRideDetails);
                },
                width: 162.kw,
                label: Strings.reject,
                isBorder: true,
              ),
            ],
          ).paddingOnly(top: 16.kh, bottom: 40.kh),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}
