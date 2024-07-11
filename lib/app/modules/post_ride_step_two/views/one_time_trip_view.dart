import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../components/richtext_heading.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/text_style_util.dart';
import '../controllers/post_ride_step_two_controller.dart';

class OneTimeTripView extends GetView<PostRideStepTwoController> {
  const OneTimeTripView({super.key});

  @override
  Widget build(BuildContext context) {
    final pickedDate = DateTime.now();
    controller.selectedDate.text = pickedDate.toIso8601String();
    controller.formattedOneTimeDate.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.enterSpecificDateAndTime,
          style: TextStyleUtil.k16Semibold(
              fontSize: 16.kh, color: ColorUtil.kBlack02),
        ).paddingOnly(top: 24.kh, bottom: 16.kh),

        RichTextHeading(text: Strings.date),
        GreenPoolTextField(
            controller: controller.formattedOneTimeDate,
            hintText: Strings.selectDate,
            readOnly: true,
            suffix: SizedBox(
              child: SvgPicture.asset(
                ImageConstant.svgIconCalendar,
                height: 24.kh,
                width: 24.kw,
                colorFilter: ColorFilter.mode(
                    controller.isPinkMode.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                    BlendMode.srcIn),
              ).paddingOnly(right: 16.kw),
            ),
            onTap: () {
              controller
                  .setDate(context)
                  .then((value) => controller.setActiveStateCarpoolSchedule());
            }).paddingOnly(top: 8.kh, bottom: 16.kh),
        RichTextHeading(text: Strings.time),
        GreenPoolTextField(
          hintText: Strings.selectTime,
          controller: controller.selectedTime,
          onTap: () {
            controller.setTime(context);
          },
          readOnly: true,
        ).paddingOnly(top: 8.kh, bottom: 16.kh),

        //RETURN TRIP
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.returnTrip,
              style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
            ),
            Obx(
              () => Transform.scale(
                scale: 0.8.kh,
                child: Switch(
                  value: controller.isReturn.value,
                  onChanged: (value) {
                    controller.isReturn.value = value;
                    controller.setActiveStateCarpoolSchedule();
                  },
                  inactiveThumbColor: ColorUtil.kNeutral1,
                  inactiveTrackColor: controller.isPinkMode.value
                      ? ColorUtil.kSecondaryPinkMode
                      : ColorUtil.kPrimary05,
                  activeTrackColor: controller.isPinkMode.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  trackOutlineWidth: const MaterialStatePropertyAll(0),
                  thumbColor:
                      const MaterialStatePropertyAll(ColorUtil.kWhiteColor),
                  trackOutlineColor:
                      const MaterialStatePropertyAll(ColorUtil.kNeutral1),
                ),
              ),
            ),
          ],
        ),

        //if return trip then this option
        Obx(
          () => controller.isReturn.value
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Strings.selectDateAndTimeOfArrival,
                          style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                        ),
                        Expanded(
                          child: Container(
                            height: 1.kh,
                            color: ColorUtil.kNeutral2,
                          ).paddingOnly(left: 8.kw),
                        ),
                      ],
                    ).paddingSymmetric(vertical: 16.kh),
                    RichTextHeading(text: Strings.date),
                    GreenPoolTextField(
                      hintText: Strings.selectDate,
                      controller: controller.formattedReturnDate,
                      onTap: () {
                        controller.setReturnDate(context);
                      },
                      readOnly: true,
                      suffix: SizedBox(
                        child: SvgPicture.asset(
                          ImageConstant.svgIconCalendar,
                          height: 24.kh,
                          width: 24.kw,
                          colorFilter: ColorFilter.mode(
                              controller.isPinkMode.value
                                  ? ColorUtil.kPrimary3PinkMode
                                  : ColorUtil.kSecondary01,
                              BlendMode.srcIn),
                        ).paddingOnly(right: 16.kw),
                      ),
                    ).paddingOnly(top: 8.kh, bottom: 16.kh),
                    RichTextHeading(text: Strings.time),
                    GreenPoolTextField(
                      hintText: Strings.selectTime,
                      onTap: () {
                        controller.setReturnTime(context);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      readOnly: true,
                      controller: controller.selectedReturnTime,
                    ).paddingOnly(top: 8.kh),
                  ],
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
