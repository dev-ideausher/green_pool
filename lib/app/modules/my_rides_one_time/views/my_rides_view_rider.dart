import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/my_rides_one_time/controllers/my_rides_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../constants/image_constant.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';

class RiderMyRidesView extends GetView<MyRidesOneTimeController> {
  final int? index;

  const RiderMyRidesView({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.kh),
      decoration: BoxDecoration(
        color: ColorUtil.kWhiteColor,
        borderRadius: BorderRadius.circular(8.kh),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.confirmRequestModel.value.data?[index!]!.confirmByRider != true
              ? const SizedBox()
              : Row(
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
                          child: Image.asset(
                            ImageConstant.pngIconProfilePic,
                          ),
                        ).paddingOnly(bottom: 8.kh),
                        Positioned(
                          top: 52.kh,
                          left: 8.kw,
                          child: Container(
                            width: 48.kw,
                            height: 20.kh,
                            padding: EdgeInsets.symmetric(horizontal: 8.kw),
                            decoration: BoxDecoration(
                                color: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                borderRadius: BorderRadius.circular(16.kh)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kWhiteColor : ColorUtil.kYellowColor,
                                  size: 12.kh,
                                ).paddingOnly(right: 2.kw),
                                Text(
                                  '4.5',
                                  style: TextStyleUtil.k12Semibold(color: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kBlack02 : ColorUtil.kWhiteColor),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Savannah Nguyen',
                                style: TextStyleUtil.k16Bold(),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Fare: ',
                                      style: TextStyleUtil.k14Semibold(color: ColorUtil.kSecondary01),
                                    ),
                                    TextSpan(
                                      text: '\$ ${controller.myRidesModelData.value[index!]?.fair ?? " "}',
                                      style: TextStyleUtil.k16Semibold(fontSize: 16.kh, color: ColorUtil.kSecondary01),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ).paddingOnly(bottom: 8.kh),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageConstant.svgIconCalendarTime,
                                    colorFilter:
                                        ColorFilter.mode(Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01, BlendMode.srcIn),
                                  ).paddingOnly(right: 4.kw),
                                  Text(
                                    // '07 Nov 2023, 3:00pm',
                                    '${controller.myRidesModelData.value[index!]?.date.toString().split("T")[0] ?? " "}  ${controller.myRidesModelData.value?[index!]?.time ?? " "}',
                                    style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.time_to_leave,
                                    size: 18.kh,
                                    color: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                  ).paddingOnly(right: 8.kw),
                                  Text(
                                    '${controller.myRidesModelData.value[index!]?.seatAvailable}',
                                    style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
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

          // time view if not confirmed by rider
          controller.confirmRequestModel.value.data?[index!]!.confirmByRider != true
              ? Row(
                  children: [
                    SvgPicture.asset(
                      ImageConstant.svgIconCalendarTime,
                      colorFilter: ColorFilter.mode(Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01, BlendMode.srcIn),
                    ).paddingOnly(right: 4.kw),
                    Text(
                      // '07 Nov 2023, 3:00pm',
                      '${controller.myRidesModelData.value[index!]?.date.toString().split("T")[0] ?? " "}  ${controller.myRidesModelData.value[index!]?.time ?? " "}',
                      style: TextStyleUtil.k16Bold(),
                    ),
                  ],
                )
              : const SizedBox(),
          //middle divider
          const GreenPoolDivider().paddingOnly(bottom: 16.kh),
          Stack(
            children: [
              Row(
                children: [
                  Container(
                    height: 10.kh,
                    width: 10.kw,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorUtil.kGreenColor),
                  ).paddingOnly(right: 8.kw),
                  Text(
                    // '1100 McIntosh St, Regina',
                    "${controller.myRidesModelData.value[index!]?.origin?.name}",
                    style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                  ),
                ],
              ).paddingOnly(bottom: 30.kh),
              Positioned(
                top: 27.kh,
                child: Row(
                  children: [
                    Container(
                      height: 10.kh,
                      width: 10.kw,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorUtil.kError4),
                    ).paddingOnly(right: 8.kw),
                    Text(
                      // '681 Chrislea Rd, Woodbridge',
                      "${controller.myRidesModelData.value[index!]?.destination?.name}",
                      style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                    ),
                  ],
                ),
              ),
              //line joining red and green dots
              Positioned(
                top: 10.kh,
                left: 4.5.kw,
                child: Container(
                  height: 28.kh,
                  width: 1.kw,
                  color: ColorUtil.kBlack04,
                ),
              ),
            ],
          ).paddingOnly(bottom: 8.kh),
          //bottom line
          const GreenPoolDivider(),
          controller.confirmRequestModel.value.data?[index!]!.confirmByRider != true
              ? Container(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 16.kw, vertical: 8.kh),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.kh), color: ColorUtil.kSecondary01),
                )
              : Row(
                  children: [
                    GreenPoolButton(
                      width: 144.kw,
                      onPressed: () {},
                      isBorder: true,
                      label: 'Cancel Ride',
                      borderColor: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                      labelColor: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                    ),
                  ],
                ),
        ],
      ).paddingOnly(bottom: 16.kh),
    ).paddingOnly(bottom: 16.kh);
  }
}
