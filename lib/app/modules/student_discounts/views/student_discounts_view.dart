import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/image_constant.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/student_discounts_controller.dart';

class StudentDiscountsView extends GetView<StudentDiscountsController> {
  const StudentDiscountsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_studentDiscount.tr),
      ),
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => controller.requestSent.value
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                          blastDirection: -pi / 2,
                          shouldLoop: false,
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
                            LocaleKeys.app_requestSentExclamation.tr,
                            style: TextStyleUtil.k24Heading700(),
                          ),
                        ),
                        Positioned(
                            top: 440.kh,
                            child: Text(
                              LocaleKeys.app_verificationRequestSent.tr,
                              style: TextStyleUtil.k16Regular(
                                  color: ColorUtil.kBlack04),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  GreenPoolButton(
                    onPressed: () {
                      Get.back();
                    },
                    label: LocaleKeys.app_continueText.tr,
                  ).paddingSymmetric(vertical: 40.kh),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: LocaleKeys.app_studentReceive.tr,
                          style: TextStyleUtil.k16Bold(),
                        ),
                        TextSpan(
                          text: LocaleKeys.app_dollar5.tr,
                          style: TextStyleUtil.k18Bold(
                              color:
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kPrimary01),
                        ),
                        TextSpan(
                          text: LocaleKeys.app_discountAfterVerifyingEmail.tr,
                          style: TextStyleUtil.k16Bold(),
                        ),
                      ],
                    ),
                  ).paddingOnly(top: 32.kh, bottom: 24.kh),
                  Text(
                    LocaleKeys.app_school.tr,
                    style: TextStyleUtil.k14Semibold(),
                  ).paddingOnly(bottom: 8.kh),
                  GreenPoolTextField(
                          hintText: LocaleKeys.app_searchForSchool.tr,
                          controller: controller.searchTextController,
                          onchanged: (v) {
                            controller.searchMethod();
                          },
                          prefix: Icon(
                            Icons.search,
                            color: Get.find<HomeController>().isPinkModeOn.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kBlack02,
                          ),
                          onPressedSuffix: () {
                            if (controller.isSelected.value == true) {
                              controller.schoolListAPI('university');
                              controller.isSelected.value = false;
                            } else {
                              controller.isSelected.value = true;
                            }
                          },
                          suffix: controller.isSelected.value
                              ? const Icon(
                                  Icons.chevron_right,
                                  color: ColorUtil.kBlack01,
                                )
                              : const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: ColorUtil.kBlack01,
                                ))
                      .paddingOnly(bottom: 16.kh),
                  Obx(
                    () => controller.isSelected.value
                        ? const SizedBox()
                        : SizedBox(
                            height: 120.kh,
                            child: controller.isLoading.value
                                ? const GpProgress()
                                : ListView.builder(
                                    itemCount:
                                        controller.schoolSugestionList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1.kh,
                                                    color:
                                                        ColorUtil.kNeutral7)),
                                            borderRadius:
                                                BorderRadius.circular(8.kh)),
                                        child: ListTile(
                                          title: Text(controller
                                              .schoolSugestionList[index]
                                              .name!),
                                          onTap: () {
                                            controller
                                                    .searchTextController.text =
                                                controller
                                                    .schoolSugestionList[index]
                                                    .name!;
                                            controller.emailPostFix = controller
                                                    .schoolSugestionList[index]
                                                    .emailPostFix ??
                                                "";
                                            controller.isSelected.value = true;
                                          },
                                        ),
                                      );
                                    }),
                          ).paddingOnly(bottom: 16.kh),
                  ),
                  Text(
                    LocaleKeys.app_studentEmailID.tr,
                    style: TextStyleUtil.k14Semibold(),
                  ).paddingOnly(bottom: 8.kh),
                  GreenPoolTextField(
                    hintText: LocaleKeys.app_enterStudentEmail.tr,
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailTextController,
                    onchanged: (p0) {
                      controller.toggleButton();
                    },
                  ),
                  const Expanded(child: SizedBox()),
                  Obx(
                    () => GreenPoolButton(
                      onPressed: () {
                        controller.checkEmailPostFix();
                      },
                      label: LocaleKeys.app_verifyEmail.tr,
                      isActive: controller.isActive.value,
                    ).paddingSymmetric(vertical: 40.kh),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
