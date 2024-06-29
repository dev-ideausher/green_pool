import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../controllers/verification_done_controller.dart';

class VerificationDoneView extends GetView<VerificationDoneController> {
  const VerificationDoneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 500.kh,
                  width: 100.w,
                ),
                ConfettiWidget(
                  confettiController: controller.confettiController,
                  shouldLoop: false,
                  blastDirection: -pi / 2,
                  emissionFrequency: 0.01,
                ),
                SvgPicture.asset(
                  ImageConstant.svgCompleteTick,
                  height: 110.kh,
                  width: 110.kw,
                ),
                Positioned(
                  top: 390.kh,
                  child: Text(
                    "Woohoo!",
                    style: TextStyleUtil.k24Heading700(),
                  ),
                ),
                Positioned(
                    top: 440.kh,
                    child: Text(
                      "Verification is successful!\nPlease continue to your profile.",
                      style:
                          TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          GreenPoolButton(
            onPressed: controller.fromNavBar == false
                ? () {
                    controller.isDriver
                        ? Get.offNamed(Routes.PROFILE_SETUP, arguments: {
                            'fromNavBar': false,
                            'postRideModel': controller.postRideModel.value,
                            'fullName': controller.fullName
                          })
                        : Get.offNamed(Routes.RIDER_PROFILE_SETUP, arguments: {
                            'fromNavBar': false,
                            'findRideModel': controller.findRideModel.value,
                            'fullName': controller.fullName
                          });
                  }
                : () {
                    Get.dialog(
                      useSafeArea: true,
                      barrierDismissible: false,
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(16.kh),
                          height: 172.kh,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: ColorUtil.kWhiteColor,
                            borderRadius: BorderRadius.circular(8.kh),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'You would like to continue as Rider or Driver?',
                                style: TextStyleUtil.k18Bold(
                                  color: ColorUtil.kBlack04,
                                ),
                                textAlign: TextAlign.center,
                              ).paddingOnly(bottom: 40.kh),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GreenPoolButton(
                                    onPressed: () {
                                      Get.back();
                                      Get.offNamed(Routes.RIDER_PROFILE_SETUP,
                                          arguments: {
                                            'fromNavBar': controller.fromNavBar,
                                            'fullName': controller.fullName
                                          });
                                    },
                                    height: 40.kh,
                                    width: 130.kw,
                                    label: 'Rider',
                                    fontSize: 14.kh,
                                    padding: const EdgeInsets.all(8),
                                  ),
                                  GreenPoolButton(
                                    onPressed: () {
                                      Get.back();
                                      Get.offNamed(Routes.PROFILE_SETUP,
                                          arguments: {
                                            'fromNavBar': controller.fromNavBar,
                                            'fullName': controller.fullName
                                          });
                                    },
                                    height: 40.kh,
                                    width: 130.kw,
                                    label: 'Driver',
                                    fontSize: 14.kh,
                                    padding: const EdgeInsets.all(8),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
            label: "Continue",
          ).paddingOnly(bottom: 40.kh),
        ],
      ),
    ));
  }
}
