import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/onboarding_controller.dart';
import 'get_started_view.dart';
import 'onboard1_view.dart';
import 'onboard2_view.dart';
import 'onboard3_view.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Obx(
              () => controller.pageIndex.value == 3
                  ? SizedBox(
                      height: 37.kh,
                    ).paddingSymmetric(vertical: 24.kh)
                  : GreenPoolButton(
                      onPressed: () {
                        controller.postController.animateToPage(
                          3,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                        controller.pageIndex.value = 3;
                      },
                      padding: const EdgeInsets.all(0),
                      label: Strings.skip,
                      color: controller.pageIndex.value == 1
                          ? ColorUtil.kSecondaryPinkMode
                          : ColorUtil.kPrimary05,
                      fontSize: 14.kh,
                      width: 77.kw,
                      height: 37.kh,
                    ).paddingSymmetric(vertical: 24.kh, horizontal: 16.kw),
            ),
            Expanded(
              child: PageView(
                controller: controller.postController,
                onPageChanged: (value) {
                  controller.pageIndex.value = value;
                },
                children: const [
                  //these are the pages that you can swipe and view
                  Onboard1View(),
                  Onboard2View(),
                  Onboard3View(),
                  GetStartedView(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: ColorUtil.kBackgroundColor,
        height: 120.kh,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => controller.pageIndex.value == 3
                  ? Center(
                      child: GreenPoolButton(
                        onPressed: () {
                          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
                        },
                        label: Strings.letsGetStarted,
                      ).paddingOnly(bottom: 26.kh, top: 32.kh),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: controller.postController,
                          count: 3,
                          effect: CustomizableEffect(
                            spacing: 16.kw,
                            dotDecoration: DotDecoration(
                                color: controller.pageIndex.value == 1
                                    ? ColorUtil.kSecondaryPinkMode
                                    : ColorUtil.kSecondary05,
                                borderRadius: BorderRadius.circular(100.kh),
                                height: 10.kh,
                                width: 10.kw),
                            activeDotDecoration: DotDecoration(
                              color: controller.pageIndex.value == 1
                                  ? ColorUtil.kPrimary2PinkMode
                                  : ColorUtil.kSecondary01,
                              height: 14.kh,
                              width: 14.kw,
                              borderRadius: BorderRadius.circular(100.kh),
                            ),
                          ),
                        ),
                        GreenPoolButton(
                          onPressed: () {
                            controller.pageIndex.value++;
                            controller.postController.animateToPage(
                              controller.pageIndex.value,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear,
                            );
                          },
                          padding: const EdgeInsets.all(0),
                          color: controller.pageIndex.value == 1
                              ? ColorUtil.kPrimary2PinkMode
                              : ColorUtil.kPrimary01,
                          label: Strings.next,
                          fontSize: 14.kh,
                          width: 120.kw,
                          height: 40.kh,
                        ),
                      ],
                    ).paddingOnly(
                      top: 42.kh, bottom: 36.kh, left: 20.kw, right: 20.kw),
            ),
          ],
        ),
      ),
    );
  }
}
