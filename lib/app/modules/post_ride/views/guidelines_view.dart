import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/post_ride/controllers/post_ride_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../profile/controllers/profile_controller.dart';
import '../../terms_conditions/views/terms_conditions_view.dart';

class GuidelinesView extends GetView<PostRideController> {
  const GuidelinesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: SvgPicture.asset(ImageConstant.svgIconBack30),
              ).paddingOnly(top: 16.kh, bottom: 8.kh),
              Text(
                'Guidelines for sharing\na ride',
                style: TextStyleUtil.k32Heading700(),
              ).paddingOnly(bottom: 56.kh),
              GuidelinesCard(
                image: Get.find<ProfileController>().isSwitched.value
                    ? ImageConstant.svgPinkGuideline1
                    : ImageConstant.svgGuideline1,
                title: 'No Cash',
                body:
                    'All fares are settled electronically,\nand payouts occur every Friday.',
              ),
              GuidelinesCard(
                image: Get.find<ProfileController>().isSwitched.value
                    ? ImageConstant.svgPinkGuideline2
                    : ImageConstant.svgGuideline2,
                title: 'Be Trustworthy',
                body:
                    'Only create a trip listing if you are\ncertain you will drive and can arrive\non time.',
              ),
              GuidelinesCard(
                image: Get.find<ProfileController>().isSwitched.value
                    ? ImageConstant.svgPinkGuideline3
                    : ImageConstant.svgGuideline3,
                title: 'Practice safe driving',
                body:
                    'Comply with traffic rules, stay\nfocused, eliminate distractions and\nsecure your seatbelts.',
              ).paddingOnly(bottom: 18.kh),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isChecked.value,
                      activeColor:
                          Get.find<ProfileController>().isSwitched.value
                              ? ColorUtil.kPrimary2PinkMode
                              : ColorUtil.kSecondary01,
                      onChanged: (value) {
                        controller.toggleCheckbox();
                      },
                    ),
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'I consent to these guidelines, the ',
                            style: TextStyleUtil.k12Regular(),
                          ),
                          TextSpan(
                            text: 'Driver Cancellation Policy, ',
                            style: TextStyleUtil.k12Semibold(
                                color: Get.find<ProfileController>()
                                        .isSwitched
                                        .value
                                    ? ColorUtil.kPrimary2PinkMode
                                    : ColorUtil.kSecondary03),
                                    recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Get.to(const TermsAndConditionsView()),
                          ),
                          TextSpan(
                            text: 'Terms of Service,',
                            style: TextStyleUtil.k12Semibold(
                                color: Get.find<ProfileController>()
                                        .isSwitched
                                        .value
                                    ? ColorUtil.kPrimary2PinkMode
                                    : ColorUtil.kSecondary03),
                                    recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Get.to(const TermsAndConditionsView()),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyleUtil.k12Regular(),
                          ),
                          TextSpan(
                            text: 'Privacy policy. ',
                            style: TextStyleUtil.k12Semibold(
                                color: Get.find<ProfileController>()
                                        .isSwitched
                                        .value
                                    ? ColorUtil.kPrimary2PinkMode
                                    : ColorUtil.kSecondary03),
                                    recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Get.to(const TermsAndConditionsView()),
                          ),
                          TextSpan(
                            text:
                                'I acknowledge that my account may face suspension for any violations of these rules.',
                            style: TextStyleUtil.k12Regular(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => GreenPoolButton(
                  onPressed: () => controller.setGuideLines(),
                  isActive: controller.isChecked.value,
                  label: 'Publish Ride',
                ).paddingSymmetric(vertical: 40.kh),
              ),
            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ),
      ),
    );
  }
}

class GuidelinesCard extends StatelessWidget {
  final String image, title, body;
  const GuidelinesCard({
    super.key,
    required this.image,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(image).paddingOnly(right: 16.kw),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyleUtil.k20Heading600(),
            ).paddingOnly(bottom: 8.kh),
            Text(
              body,
              style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
            ),
          ],
        )
      ],
    ).paddingOnly(bottom: 32.kh);
  }
}
