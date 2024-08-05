import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/map_driver_confirm_request/controllers/map_driver_confirm_request_controller.dart';
import 'package:green_pool/app/modules/map_driver_confirm_request/views/map_driver_confirm_request_view.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/generated/assets.dart';

import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
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
                          ? CommonImageView(svgPath: Assets.svgPinkModegirl)
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
                                border: Border.all(
                                    color: ColorUtil.kNeutral10,
                                    width: 0.3.kh)),
                            child: Column(
                              children: [
                                ListTile(
                                    visualDensity:
                                        const VisualDensity(horizontal: -4),
                                    contentPadding: EdgeInsets.zero,
                                    leading: Container(
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
                                    title: Text(
                                      "${controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.riderDetails?[0]?.fullName}",
                                      style: TextStyleUtil.k16Semibold(
                                          fontSize: 16.kh),
                                    ),
                                    subtitle: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              ImageConstant.svgIconCalendarTime,
                                              colorFilter: ColorFilter.mode(
                                                  Get.find<HomeController>()
                                                          .isPinkModeOn
                                                          .value
                                                      ? ColorUtil
                                                          .kPrimary3PinkMode
                                                      : ColorUtil.kSecondary01,
                                                  BlendMode.srcIn),
                                            ).paddingOnly(right: 4.kw),
                                            Text(
                                              // '07 July 2023, 3:00pm',
                                              "${GpUtil.getDateFormat( controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.time ?? "")}  ${GpUtil.convertUtcToLocal(controller.confirmRequestModel.value.data?[index]?.rideDetails?[0]?.time ?? "")}",
                                              style: TextStyleUtil.k12Regular(
                                                  color: ColorUtil.kBlack02),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16.kh,
                                              color: Get.find<HomeController>()
                                                      .isPinkModeOn
                                                      .value
                                                  ? ColorUtil.kPrimary3PinkMode
                                                  : ColorUtil.kSecondary01,
                                            ),
                                            FutureBuilder<String>(
                                              future: GpUtil.calculateDistance(
                                                  startLat: controller.latitude,
                                                  startLong:
                                                      controller.longitude,
                                                  endLat: controller
                                                          .confirmRequestModel
                                                          .value
                                                          .data?[index]
                                                          ?.rideDetails?[0]
                                                          ?.origin
                                                          ?.coordinates
                                                          ?.last ??
                                                      controller.latitude,
                                                  endLong: controller
                                                          .confirmRequestModel
                                                          .value
                                                          .data?[index]
                                                          ?.rideDetails?[0]
                                                          ?.origin
                                                          ?.coordinates
                                                          ?.first ??
                                                      controller.longitude),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Text(
                                                      "..."); // Show a loading indicator while fetching data
                                                } else if (snapshot.hasError) {
                                                  // return Text('Error: ${snapshot.error}');
                                                  return Text(
                                                    Strings.na,
                                                    style: TextStyleUtil
                                                        .k12Regular(
                                                            color: ColorUtil
                                                                .kBlack02),
                                                  );
                                                } else {
                                                  return Text(
                                                    snapshot.data.toString(),
                                                    style: TextStyleUtil
                                                        .k12Regular(
                                                            color: ColorUtil
                                                                .kBlack02),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: SizedBox(
                                      height: 24.kh,
                                      width: 24.kh,
                                      child: InkWell(
                                          onTap: () => controller
                                              .openMessageConfirm(controller
                                                  .confirmRequestModel
                                                  .value
                                                  .data![index]),
                                          child: CommonImageView(
                                            svgPath: Assets.svgChat,
                                          )),
                                    )),
                                /* Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () =>controller.openMessageConfirm(controller.confirmRequestModel.value.data![index] ),
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.kh), border: Border.all(color: ColorUtil.kSecondary01)),
                                      child: Text(
                                        Strings.message,
                                        style: TextStyleUtil.k12Semibold(),
                                      ).paddingSymmetric(vertical: 4.kh, horizontal: 16.kw),
                                    ),
                                  ).paddingSymmetric(vertical: 8.kh),
                                ),*/
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
                                              .acceptRidersRequestAPI(controller
                                                  .confirmRequestModel
                                                  .value
                                                  .data?[index]);
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
