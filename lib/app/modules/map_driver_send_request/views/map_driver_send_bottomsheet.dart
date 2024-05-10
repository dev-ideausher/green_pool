import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';

class MapDriverSendBottomsheet extends StatelessWidget {
  const MapDriverSendBottomsheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(24.kh),
        // height: 317.kh,
        width: 100.w,
        decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.kh),
                topRight: Radius.circular(40.kh))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Booking Confirmed',
                style: TextStyleUtil.k18Heading600(),
              ).paddingOnly(bottom: 32.kh),
              SvgPicture.asset(
                ImageConstant.svgCompleteTick,
                height: 64.kh,
                width: 64.kw,
              ).paddingOnly(bottom: 8.kh),
              Text(
                "Booking Id : #529645488",
                style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
              ),
              const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Rider Details",
                  style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                ).paddingOnly(bottom: 16.kh),
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(20.kh),
                          child: Image.asset(
                            ImageConstant.pngPassenger2,
                          ),
                        ),
                      ),
                    ).paddingOnly(right: 8.kw),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Esther Howard',
                          style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                        ).paddingOnly(bottom: 8.kh),
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
                                  '07 July 2023, 3:00pm',
                                  style: TextStyleUtil.k12Regular(
                                      color: ColorUtil.kBlack02),
                                ),
                              ],
                            ),
                            Row(
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
                                Text(
                                  '2.1 km away',
                                  style: TextStyleUtil.k12Regular(
                                      color: ColorUtil.kBlack02),
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
                Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10.kh,
                          width: 10.kw,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtil.kGreenColor),
                        ).paddingOnly(right: 8.kw),
                        Text(
                          '1100 McIntosh St, Regina',
                          style: TextStyleUtil.k14Regular(
                              color: ColorUtil.kBlack02),
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
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorUtil.kError4),
                          ).paddingOnly(right: 8.kw),
                          Text(
                            '681 Chrislea Rd, Woodbridge',
                            style: TextStyleUtil.k14Regular(
                                color: ColorUtil.kBlack02),
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
                        color: ColorUtil.kBlack04,
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 8.kh),
                const GreenPoolDivider().paddingOnly(bottom: 16.kh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      //rating column
                      children: [
                        Text(
                          'Rating',
                          style: TextStyleUtil.k12Semibold(),
                        ).paddingOnly(bottom: 4.kh),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.kw, vertical: 2.kh),
                          decoration: BoxDecoration(
                            color: Get.find<HomeController>().isPinkModeOn.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kPrimary01,
                            borderRadius: BorderRadius.circular(16.kh),
                          ),
                          child: Row(children: [
                            Icon(
                              Icons.star,
                              color: ColorUtil.kWhiteColor,
                              size: 12.kh,
                            ).paddingOnly(right: 4.kw),
                            Text(
                              '4.5',
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
                          'Ride With',
                          style: TextStyleUtil.k12Semibold(),
                        ).paddingOnly(bottom: 4.kh),
                        Text(
                          '32 people',
                          style: TextStyleUtil.k14Regular(
                              color: ColorUtil.kBlack03),
                        ),
                      ],
                    ),
                    Column(
                      //joined in column
                      children: [
                        Text(
                          'Joined',
                          style: TextStyleUtil.k12Semibold(),
                        ).paddingOnly(bottom: 4.kh),
                        Text(
                          'in 2023',
                          style: TextStyleUtil.k14Regular(
                              color: ColorUtil.kBlack03),
                        ),
                      ],
                    ),
                  ],
                ),
                const GreenPoolDivider().paddingOnly(bottom: 16.kh, top: 8.kh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GreenPoolButton(
                      onPressed: () {},
                      label: 'Accept',
                      fontSize: 14.kh,
                      height: 40.kh,
                      width: 144.kw,
                      padding: EdgeInsets.all(8.kh),
                    ),
                    GreenPoolButton(
                      onPressed: () {},
                      isBorder: true,
                      label: 'Reject',
                      fontSize: 14.kh,
                      height: 40.kh,
                      width: 144.kw,
                      borderColor: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      labelColor: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      padding: EdgeInsets.all(8.kh),
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ));
  }
}
