import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/components/richtext_heading.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/origin/controllers/origin_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../services/custom_button.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/post_ride_controller.dart';

class PostRideView extends GetView<PostRideController> {
  const PostRideView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Post a Ride'),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RichTextHeading(text: 'Origin').paddingOnly(top: 32.kh),
          GreenPoolTextField(
            hintText: 'Enter origin address',
            onchanged: (v) {
              controller.setActiveStatePostRideView();
              print("is active value : ${controller.isActive.value}");
            },
            onTap: () {
              Get.toNamed(Routes.ORIGIN, arguments: LocationValues.origin);
            },
            controller: controller.originTextController,
            readOnly: true,
            prefix: Icon(
              Icons.location_on,
              size: 24.kh,
              color: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
            ),
          ).paddingOnly(top: 8.kh, bottom: 16.kh),
          const RichTextHeading(text: 'Destination'),
          GreenPoolTextField(
            hintText: 'Enter a destination',
            onchanged: (v) {
              controller.setActiveStatePostRideView();
              print("is active value : ${controller.isActive.value}");
            },
            onTap: () {
              Get.toNamed(Routes.ORIGIN, arguments: LocationValues.destination);
            },
            controller: controller.destinationTextController,
            readOnly: true,
            prefix: Icon(
              Icons.location_on,
              size: 24.kh,
              color: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
            ),
          ).paddingOnly(top: 8.kh, bottom: 16.kh),
          Text(
            'Add stops',
            style: TextStyleUtil.k14Semibold(),
          ),
          GreenPoolTextField(
            hintText: 'Add stops',
            onTap: () {
              Get.toNamed(Routes.ORIGIN, arguments: LocationValues.addStop1);
            },
            controller: controller.stop1TextController,
            readOnly: true,
            prefix: Icon(
              Icons.add_circle,
              size: 20.kh,
              color: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
            ),
            suffix: SvgPicture.asset(
              ImageConstant.svgIconReorder,
              colorFilter: ColorFilter.mode(
                  Get.find<ProfileController>().isSwitched.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  BlendMode.srcIn),
            ),
          ).paddingOnly(top: 8.kh, bottom: 16.kh),
          GreenPoolTextField(
            hintText: 'Add stops',
            onTap: () {
              Get.toNamed(Routes.ORIGIN, arguments: LocationValues.addStop2);
            },
            controller: controller.stop2TextController,
            readOnly: true,
            prefix: Icon(
              Icons.add_circle,
              size: 20.kh,
              color: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
            ),
            suffix: SvgPicture.asset(
              ImageConstant.svgIconReorder,
              colorFilter: ColorFilter.mode(
                  Get.find<ProfileController>().isSwitched.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  BlendMode.srcIn),
            ),
          ).paddingOnly(top: 8.kh, bottom: 16.kh),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GreenPoolButton(
                onPressed: () => controller.decideRouting(),
                padding: const EdgeInsets.all(0),
                // isActive: controller.isActive.value,
                // isActive:
                //     controller.originTextController.value.text.isNotEmpty &&
                //             controller.destinationTextController.value.text
                //                 .isNotEmpty
                //         ? controller.isActive.value
                //         : controller.isActive.value,
                label: 'Next',
                fontSize: 14.kh,
                width: 120.kw,
                height: 40.kh,
              ).paddingSymmetric(vertical: 40.kh),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}
