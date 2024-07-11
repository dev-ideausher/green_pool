import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../components/richtext_heading.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../post_ride_step_one/views/greenpool_chip.dart';
import '../controllers/post_ride_step_two_controller.dart';

class RecurringTripView extends GetView<PostRideStepTwoController> {
  const RecurringTripView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select the days and time, specifying  am (morning) or pm (afternoon)',
          style: TextStyleUtil.k16Semibold(
              fontSize: 16.kh, color: ColorUtil.kBlack02),
        ).paddingOnly(top: 24.kh, bottom: 16.kh),
        const RichTextHeading(text: 'Day').paddingOnly(bottom: 8.kh),
        Obx(
          () => Row(
            // recurring days selection
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GreenPoolChip(
                  controller: controller,
                  radius: 8.kh,
                  label: const SizedBox(),
                  textPadding: 0.0.kh,
                  padding: EdgeInsets.all(0.kh),
                  labelText: 'Mon',
                  selected: controller.isMonday.value,
                  onPressed: () {
                    controller.isMonday.value = !controller.isMonday.value;
                    controller.isMonday.value
                        ? controller.addDays(1)
                        : controller.removeDays(1);
                    controller.setActiveStateCarpoolSchedule();
                  }),
              GreenPoolChip(
                  controller: controller,
                  radius: 8.kh,
                  label: const SizedBox(),
                  textPadding: 0.0.kh,
                  padding: EdgeInsets.all(0.kh),
                  labelText: 'Tue',
                  selected: controller.isTuesday.value,
                  onPressed: () {
                    controller.isTuesday.value = !controller.isTuesday.value;
                    controller.isTuesday.value
                        ? controller.addDays(2)
                        : controller.removeDays(2);
                    controller.setActiveStateCarpoolSchedule();
                  }),
              GreenPoolChip(
                  controller: controller,
                  radius: 8.kh,
                  label: const SizedBox(),
                  textPadding: 0.0.kh,
                  padding: EdgeInsets.all(0.kh),
                  labelText: 'Wed',
                  selected: controller.isWednesday.value,
                  onPressed: () {
                    controller.isWednesday.value =
                        !controller.isWednesday.value;
                    controller.isWednesday.value
                        ? controller.addDays(3)
                        : controller.removeDays(3);
                    controller.setActiveStateCarpoolSchedule();
                  }),
              GreenPoolChip(
                  controller: controller,
                  radius: 8.kh,
                  label: const SizedBox(),
                  textPadding: 0.0.kh,
                  padding: EdgeInsets.all(0.kh),
                  labelText: 'Thu',
                  selected: controller.isThursDay.value,
                  onPressed: () {
                    controller.isThursDay.value = !controller.isThursDay.value;
                    controller.isThursDay.value
                        ? controller.addDays(4)
                        : controller.removeDays(4);
                    controller.setActiveStateCarpoolSchedule();
                  }),
              GreenPoolChip(
                  controller: controller,
                  radius: 8.kh,
                  label: const SizedBox(),
                  textPadding: 0.0.kh,
                  padding: EdgeInsets.all(0.kh),
                  labelText: 'Fri ',
                  selected: controller.isFriday.value,
                  onPressed: () {
                    controller.isFriday.value = !controller.isFriday.value;
                    controller.isFriday.value
                        ? controller.addDays(5)
                        : controller.removeDays(5);
                    controller.setActiveStateCarpoolSchedule();
                  }),
              GreenPoolChip(
                  controller: controller,
                  radius: 8.kh,
                  label: const SizedBox(),
                  textPadding: 0.0.kh,
                  padding: EdgeInsets.all(0.kh),
                  labelText: 'Sat',
                  selected: controller.isSaturday.value,
                  onPressed: () {
                    controller.isSaturday.value = !controller.isSaturday.value;
                    controller.isSaturday.value
                        ? controller.addDays(6)
                        : controller.removeDays(6);
                    controller.setActiveStateCarpoolSchedule();
                  }),
              GreenPoolChip(
                  controller: controller,
                  radius: 8.kh,
                  label: const SizedBox(),
                  textPadding: 0.0.kh,
                  padding: EdgeInsets.all(0.kh),
                  labelText: 'Sun',
                  selected: controller.isSunday.value,
                  onPressed: () {
                    controller.isSunday.value = !controller.isSunday.value;
                    controller.isSunday.value
                        ? controller.addDays(7)
                        : controller.removeDays(7);
                    controller.setActiveStateCarpoolSchedule();
                  }),
            ],
          ).paddingOnly(bottom: 8.kh),
        ),
        Text(
          'Time',
          style: TextStyleUtil.k14Semibold(),
        ),
        GreenPoolTextField(
          hintText: 'Select Time',
          controller: controller.selectedRecurringTime,
          onTap: () {
            controller.setRecurringTime(context);
          },
          readOnly: true,
        ).paddingOnly(top: 8.kh, bottom: 16.kh),
      ],
    );
  }
}
