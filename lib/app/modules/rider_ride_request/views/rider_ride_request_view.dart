import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/home/views/bottom_navigation_view.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_textfield.dart';

import '../../../components/richtext_heading.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/rider_ride_request_controller.dart';

class RiderRideRequestView extends GetView<RiderRideRequestController> {
  const RiderRideRequestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const GreenPoolAppBar(
        title: Text('Post a Ride Request'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RichTextHeading(
            text: 'Origin',
          ).paddingOnly(top: 32.kh),
          GreenPoolTextField(
            hintText: 'Enter origin address',
            onTap: () {
              Get.toNamed(Routes.ORIGIN);
            },
            obscureText: false,
            enabled: true,
            prefix: Icon(
              Icons.location_on,
              size: 24.kh,
              color: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
            ),
          ).paddingOnly(top: 8.kh, bottom: 16.kh),
          const RichTextHeading(
            text: 'Destination',
          ),
          GreenPoolTextField(
            hintText: 'Enter a destination',
            onTap: () {
              Get.toNamed(Routes.DESTINATION);
            },
            obscureText: false,
            prefix: Icon(
              Icons.location_on,
              size: 24.kh,
              color: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
            ),
            enabled: true,
          ).paddingOnly(top: 8.kh, bottom: 16.kh),
          const RichTextHeading(text: 'Departure Date & Time'),
          Row(
            children: [
              SizedBox(
                width: 55.w,
                child: GreenPoolTextField(
                  hintText: 'Enter Date',
                  onTap: () {},
                  prefix: SvgPicture.asset(
                    ImageConstant.svgIconCalendarClear,
                    colorFilter: ColorFilter.mode(
                        Get.find<ProfileController>().isSwitched.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        BlendMode.srcIn),
                  ),
                ).paddingOnly(top: 8.kh, bottom: 16.kh, right: 8.kw),
              ),
              SizedBox(
                width: 35.w,
                child: GreenPoolTextField(
                  hintText: 'Enter Time',
                  prefix: Icon(
                    Icons.access_time_filled,
                    color: Get.find<ProfileController>().isSwitched.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kBlack02,
                    size: 20.kh,
                  ),
                ),
              ),
            ],
          ).paddingOnly(bottom: 16.kh),
          const RichTextHeading(
            text: 'Seats available',
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: 'Enter number of seats',
            prefix: Icon(
              Icons.time_to_leave,
              color: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
            ),
          ),
          Text(
            'Description',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh, top: 16.kh),
          const GreenPoolTextField(
            hintText: 'Enter text here',
            maxLines: 4,
          ),
          const Expanded(child: SizedBox()),
          GreenPoolButton(
            // onPressed: () => Get.toNamed(Routes.RIDER_PROFILE_SETUP),
            onPressed: () => Get.bottomSheet(Container(
              padding: EdgeInsets.all(24.kh),
              width: 100.w,
              decoration: BoxDecoration(
                  color: ColorUtil.kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.kh),
                      topRight: Radius.circular(40.kh))),
              child: Column(
                children: [
                  Text(
                    'Request Posted Successfully !',
                    style: TextStyleUtil.k18Bold(),
                  ).paddingOnly(bottom: 24.kh),
                  SvgPicture.asset(
                          Get.find<ProfileController>().isSwitched.value
                              ? ImageConstant.svgPinkCompleteTick
                              : ImageConstant.svgCompleteTick)
                      .paddingOnly(bottom: 16.kh),
                  Text(
                    'Ride request has been posted\nsuccessfully!\nWill send you the matching ride alert.',
                    style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                    textAlign: TextAlign.center,
                  ).paddingOnly(bottom: 40.kh),
                  GreenPoolButton(
                    onPressed: () =>
                        Get.offAll(() => const BottomNavigationView()),
                    label: 'Continue',
                  ).paddingOnly(bottom: 16.kh),
                  GreenPoolButton(
                    onPressed: () {},
                    label: 'Cancel',
                    labelColor: Get.find<ProfileController>().isSwitched.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kBlack01,
                    isBorder: true,
                    borderColor: Get.find<ProfileController>().isSwitched.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                  ),
                ],
              ),
            )),

            padding: const EdgeInsets.all(0),
            label: 'Post Request',
          ).paddingOnly(bottom: 40.kh),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}
