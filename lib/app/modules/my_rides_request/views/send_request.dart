import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/map_driver_send_request/controllers/map_driver_send_request_controller.dart';
import 'package:green_pool/app/modules/map_driver_send_request/views/map_driver_send_request_view.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import '../../../../generated/assets.dart';
import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/gp_util.dart';
import '../../../services/snackbar.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_rides_request_controller.dart';

class SendRequest extends GetView<MyRidesRequestController> {
  const SendRequest({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => MapDriverSendRequestController(),
    );
    return Obx(
      () => controller.isSendPageLoading.value
          ? const GpProgress()
          : controller.sendRequestModel.value.data!.isEmpty
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
                  ? const MapDriverSendRequestView()
                  : ListView.builder(
                      itemCount:
                          controller.sendRequestModel.value.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(16.kh),
                          decoration: BoxDecoration(
                              color: ColorUtil.kWhiteColor,
                              borderRadius: BorderRadius.circular(8.kh),
                              border: Border.all(
                                  color: ColorUtil.kNeutral10, width: 0.3.kh)),
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
                                              "${controller.sendRequestModel.value.data![index]!.riderDetails?.profilePic?.url}",
                                        ),
                                      ),
                                    ),
                                  ).paddingOnly(right: 8.kw),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                              .sendRequestModel
                                              .value
                                              .data![index]!
                                              .riderDetails!
                                              .fullName
                                              .toString(),
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
                                                    BlendMode.srcIn,
                                                  ),
                                                ).paddingOnly(right: 4.kw),
                                                Text(
                                                  "${GpUtil.getDateFormat(controller.sendRequestModel.value.data![index]?.time ?? "")}  ${GpUtil.convertUtcToLocal(controller.sendRequestModel.value.data![index]?.time ?? "")}",
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
                                                ).paddingOnly(right: 4.kw),
                                                FutureBuilder<String>(
                                                  future:
                                                      GpUtil.calculateDistance(
                                                    startLat:
                                                        controller.latitude,
                                                    startLong:
                                                        controller.longitude,
                                                    endLat: controller
                                                            .sendRequestModel
                                                            .value
                                                            .data?[index]
                                                            ?.origin
                                                            ?.coordinates
                                                            ?.last ??
                                                        controller.latitude,
                                                    endLong: controller
                                                            .sendRequestModel
                                                            .value
                                                            .data?[index]
                                                            ?.origin
                                                            ?.coordinates
                                                            ?.first ??
                                                        controller.longitude,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Text(
                                                          "..."); // Show a loading indicator while fetching data
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                        Strings.na,
                                                        style: TextStyleUtil
                                                            .k12Regular(
                                                                color: ColorUtil
                                                                    .kBlack02),
                                                      );
                                                    } else {
                                                      return Text(
                                                        snapshot.data
                                                            .toString(),
                                                        style: TextStyleUtil
                                                            .k12Regular(
                                                                color: ColorUtil
                                                                    .kBlack02),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ).paddingOnly(right: 4.kw),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ).paddingOnly(bottom: 8.kh),

                              const GreenPoolDivider()
                                  .paddingOnly(bottom: 8.kh),
                              OriginToDestination(
                                      origin:
                                          "${controller.sendRequestModel.value.data![index]?.origin?.name}",
                                      destination:
                                          "${controller.sendRequestModel.value.data![index]?.destination?.name}",
                                      needPickupText: false)
                                  .paddingOnly(bottom: 8.kh),
                              const GreenPoolDivider()
                                  .paddingOnly(bottom: 16.kh),
                              //

                              //
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => controller.openMessage(
                                        controller.sendRequestModel.value
                                            .data![index]!),
                                    child: Container(
                                      height: 38.kh,
                                      width: 134.kw,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40.kh),
                                          border: Border.all(
                                              color: ColorUtil.kSecondary01)),
                                      child: Text(
                                        Strings.message,
                                        style: TextStyleUtil.k12Semibold(),
                                      ),
                                    ),
                                  ).paddingAll(8.kh),
                                  GreenPoolButton(
                                      width: 144.kw,
                                      height: 40.kh,
                                      padding: EdgeInsets.all(8.kh),
                                      fontSize: 14.kh,
                                      label: controller.sendRequestModel.value
                                                  .data![index].requestSent ??
                                              false
                                          ? Strings.sent
                                          : Strings.request,
                                      onPressed: () async {
                                        if (controller.sendRequestModel.value
                                                .data![index].requestSent ??
                                            false) {
                                          showMySnackbar(
                                              msg:
                                                  Strings.reqHasAlreadySent);
                                        } else {
                                          await controller
                                              .sendRequestToRiderAPI(controller
                                                  .sendRequestModel
                                                  .value
                                                  .data![index]);
                                        }
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ).paddingOnly(bottom: 16.kh);
                      },
                    ).paddingOnly(top: 32.kh, left: 16.kw, right: 16.kw),
    );
  }
}
