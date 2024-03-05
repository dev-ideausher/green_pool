import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/my_rides/views/my_rides_request.dart';
import 'package:green_pool/app/modules/rider_my_rides/views/rider_my_rides_view.dart';

import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';

import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/my_rides_controller.dart';

class MyRidesView extends GetView<MyRidesController> {
  const MyRidesView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyRidesController());
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('My Rides'),
        leading: SizedBox(),
      ),
      body: SafeArea(
        child: Get.find<GetStorageService>().getLoggedIn
            ? Obx(
                () => controller.myRidesModel.value.data == null
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Get.find<ProfileController>().isSwitched.value
                              ? ColorUtil.kPrimary3PinkMode
                              : ColorUtil.kPrimary01,
                        ),
                      )
                    : Column(
                        children: [
                          // Obx(
                          //   () => controller.myRidesModel.value.data![0]?.driverId == ''
                          //       ? const SizedBox()
                          //       : GestureDetector(
                          //           onTap: () => Get.to(() => const RideRequests()),
                          //           child: Container(
                          //             padding: EdgeInsets.all(16.kh),
                          //             decoration: BoxDecoration(
                          //               color: ColorUtil.kWhiteColor,
                          //               borderRadius: BorderRadius.circular(8.kh),
                          //               border: Border(
                          //                   bottom: BorderSide(
                          //                       color: ColorUtil.kNeutral7,
                          //                       width: 1.kh)),
                          //             ),
                          //             child: Row(
                          //               children: [
                          //                 SvgPicture.asset(
                          //                   ImageConstant.svgProfileSettings,
                          //                   colorFilter: ColorFilter.mode(
                          //                       Get.find<ProfileController>()
                          //                               .isSwitched
                          //                               .value
                          //                           ? ColorUtil.kPrimary3PinkMode
                          //                           : ColorUtil.kPrimary01,
                          //                       BlendMode.srcIn),
                          //                 ).paddingOnly(right: 12.kw),
                          //                 Text(
                          //                   'View ride requests',
                          //                   style: TextStyleUtil.k14Semibold(),
                          //                 ),
                          //                 const Expanded(child: SizedBox()),
                          //                 SvgPicture.asset(
                          //                     ImageConstant.svgIconRightArrow),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          // ),
                          Obx(
                            () => Expanded(
                              child: ListView.builder(
                                itemCount:
                                    controller.myRidesModel.value.data?.length,
                                itemBuilder: (context, index) {
                                  return controller.myRidesModel.value
                                              .data![index]?.driverId !=
                                          ''
                                      ? GestureDetector(
                                          onTap: () {
                                            controller.driverRideId.value =
                                                "${controller.myRidesModel.value.data?[index]?.Id}";
                                            Get.to(() => const RideRequests());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(16.kh),
                                            decoration: BoxDecoration(
                                                color: ColorUtil.kWhiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.kh),
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            ColorUtil.kNeutral7,
                                                        width: 2.kh))),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      // '10:30 am',
                                                      controller
                                                              .myRidesModel
                                                              .value
                                                              .data![index]
                                                              ?.time ??
                                                          '00:00',
                                                      style: TextStyleUtil
                                                          .k16Bold(),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: ColorUtil
                                                                      .kPrimary01),
                                                          child: ClipOval(
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: Size
                                                                  .fromRadius(
                                                                      12.kh),
                                                              child:
                                                                  Image.asset(
                                                                ImageConstant
                                                                    .pngPassenger1,
                                                              ),
                                                            ),
                                                          ),
                                                        ).paddingOnly(
                                                            right: 4.kw),
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: ColorUtil
                                                                      .kPrimary01),
                                                          child: ClipOval(
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: Size
                                                                  .fromRadius(
                                                                      12.kh),
                                                              child:
                                                                  Image.asset(
                                                                ImageConstant
                                                                    .pngPassenger2,
                                                              ),
                                                            ),
                                                          ),
                                                        ).paddingOnly(
                                                            right: 4.kw),
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: ColorUtil
                                                                      .kPrimary01),
                                                          child: ClipOval(
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: Size
                                                                  .fromRadius(
                                                                      12.kh),
                                                              child:
                                                                  Image.asset(
                                                                ImageConstant
                                                                    .pngPassenger3,
                                                              ),
                                                            ),
                                                          ),
                                                        ).paddingOnly(
                                                            right: 4.kw),
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: ColorUtil
                                                                      .kPrimary01),
                                                          child: ClipOval(
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: Size
                                                                  .fromRadius(
                                                                      12.kh),
                                                              child:
                                                                  Image.asset(
                                                                ImageConstant
                                                                    .pngPassenger4,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ).paddingOnly(bottom: 8.kh),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      ImageConstant
                                                          .svgIconCalendarTime,
                                                      colorFilter: ColorFilter.mode(
                                                          Get.find<ProfileController>()
                                                                  .isSwitched
                                                                  .value
                                                              ? ColorUtil
                                                                  .kPrimary3PinkMode
                                                              : ColorUtil
                                                                  .kSecondary01,
                                                          BlendMode.srcIn),
                                                    ).paddingOnly(right: 4.kw),
                                                    Text(
                                                      // '07 November 2023',
                                                      controller
                                                              .myRidesModel
                                                              .value
                                                              .data![index]
                                                              ?.date
                                                              ?.split('T')[0] ??
                                                          "DD/MM/YYYY",
                                                      style: TextStyleUtil
                                                          .k12Regular(
                                                              color: ColorUtil
                                                                  .kBlack03),
                                                    ),
                                                  ],
                                                ).paddingOnly(bottom: 8.kh),
                                                Container(
                                                  width: 100.w,
                                                  height: 1.kh,
                                                  color: ColorUtil.kBlack07,
                                                ).paddingOnly(bottom: 16.kh),
                                                Stack(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 10.kh,
                                                          width: 10.kw,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: ColorUtil
                                                                      .kGreenColor),
                                                        ).paddingOnly(
                                                            right: 8.kw),
                                                        Expanded(
                                                          child: Text(
                                                            // '1100 McIntosh St, Regina',
                                                            controller
                                                                    .myRidesModel
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    ?.origin
                                                                    ?.name ??
                                                                'Origin',
                                                            style: TextStyleUtil
                                                                .k14Regular(
                                                                    color: ColorUtil
                                                                        .kBlack02),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ).paddingOnly(
                                                        bottom: 30.kh),
                                                    Positioned(
                                                      top: 27.kh,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 10.kh,
                                                            width: 10.kw,
                                                            decoration: const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: ColorUtil
                                                                    .kError4),
                                                          ).paddingOnly(
                                                              right: 8.kw),
                                                          Text(
                                                            // '681 Chrislea Rd, Woodbridge',
                                                            controller
                                                                    .myRidesModel
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    ?.destination
                                                                    ?.name ??
                                                                'Destination',
                                                            style: TextStyleUtil
                                                                .k14Regular(
                                                                    color: ColorUtil
                                                                        .kBlack02),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 10.kh,
                                                      left: 4.5.kw,
                                                      child: Container(
                                                        height: 28.kh,
                                                        width: 1.kw,
                                                        color:
                                                            ColorUtil.kBlack04,
                                                      ),
                                                    ),
                                                  ],
                                                ).paddingOnly(bottom: 8.kh),
                                                Container(
                                                  width: 100.w,
                                                  height: 1.kh,
                                                  color: ColorUtil.kBlack07,
                                                ).paddingOnly(bottom: 16.kh),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GreenPoolButton(
                                                      onPressed: () {},
                                                      width: 144.kw,
                                                      height: 40.kh,
                                                      padding:
                                                          EdgeInsets.all(8.kh),
                                                      fontSize: 14.kh,
                                                      label: 'Start Ride',
                                                    ),
                                                    GreenPoolButton(
                                                      onPressed: () {},
                                                      width: 144.kw,
                                                      height: 40.kh,
                                                      padding:
                                                          EdgeInsets.all(8.kh),
                                                      fontSize: 14.kh,
                                                      isBorder: true,
                                                      borderColor: Get.find<
                                                                  ProfileController>()
                                                              .isSwitched
                                                              .value
                                                          ? ColorUtil
                                                              .kPrimary3PinkMode
                                                          : ColorUtil
                                                              .kSecondary01,
                                                      labelColor: Get.find<
                                                                  ProfileController>()
                                                              .isSwitched
                                                              .value
                                                          ? ColorUtil
                                                              .kPrimary3PinkMode
                                                          : ColorUtil
                                                              .kSecondary01,
                                                      label: 'Cancel Ride',
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ).paddingOnly(bottom: 16.kh),
                                        )
                                      : const RiderMyRidesView();
                                },
                              ).paddingOnly(top: 32.kh),
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16.kw),
              )
            : Center(
                child: Text(
                  'Please Login or SignUp',
                  style: TextStyleUtil.k24Heading600(),
                ),
              ),
      ),
    );
  }
}
