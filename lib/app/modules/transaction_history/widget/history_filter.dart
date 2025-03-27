import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import 'package:green_pool/generated/locales.g.dart';

import '../controllers/transaction_history_controller.dart';

class HistoryFilter extends GetView<TransactionHistoryController> {
  const HistoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.kh),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.app_filterBy.tr,
              style: TextStyleUtil.k24Heading600()),

          10.kheightBox,

          // Toggle Buttons
          Obx(() => Row(
                children: [
                  _toggleButton(
                      LocaleKeys.app_month.tr, controller.isMonthSelected.value,
                      () {
                    controller.toggleFilter(true);
                  }),
                  10.kwidthBox,
                  _toggleButton(
                      LocaleKeys.app_year.tr, !controller.isMonthSelected.value,
                      () {
                    controller.toggleFilter(false);
                  }),
                ],
              )),

          20.kheightBox,

          // Month or Year Selection Grid
          Obx(() => controller.isMonthSelected.value
              ? _buildMonthGrid()
              : _buildYearGrid()),
        ],
      ),
    );
  }

  // Toggle Button Widget
  Widget _toggleButton(String text, bool isSelected, VoidCallback onTap) {
    final isPinkModeOn = Get.find<GetStorageService>().isPinkMode;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.kw, vertical: 8.kh),
        decoration: BoxDecoration(
          color: isSelected
              ? isPinkModeOn
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01
              : ColorUtil.kNeutral4.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.kh),
          border: isSelected
              ? null
              : Border.all(color: ColorUtil.kNeutral4, width: 1.kh),
        ),
        child: Row(
          children: [
            Icon(isSelected ? Icons.check_circle : Icons.circle_outlined,
                size: isSelected ? 16.kh : 12.kh,
                color: isSelected
                    ? isPinkModeOn
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01
                    : Colors.black),
            5.kwidthBox,
            Text(text,
                style: isSelected
                    ? TextStyleUtil.k16Bold()
                    : TextStyleUtil.k14Bold()),
          ],
        ),
      ),
    );
  }

  // Month Grid
  Widget _buildMonthGrid() {
    final isPinkModeOn = Get.find<GetStorageService>().isPinkMode;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: controller.months.length,
      itemBuilder: (context, index) {
        String month = controller.months[index];
        return GestureDetector(
          onTap: () => controller.selectMonth(month),
          child: Obx(() => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.selectedMonth.value == month
                      ? isPinkModeOn
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.kh),
                ),
                child: Text(
                  month,
                  style: TextStyleUtil.k14Semibold(
                    color: controller.selectedMonth.value == month
                        ? ColorUtil.kWhiteColor
                        : ColorUtil.kBlack01,
                  ),
                ),
              )),
        );
      },
    );
  }

  // Year Grid
  Widget _buildYearGrid() {
    final isPinkModeOn = Get.find<GetStorageService>().isPinkMode;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: controller.years.length,
      itemBuilder: (context, index) {
        int year = controller.years[index];
        return GestureDetector(
          onTap: () => controller.selectYear(year),
          child: Obx(() => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.selectedYear.value == year
                      ? isPinkModeOn
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.kh),
                ),
                child: Text(
                  year.toString(),
                  style: TextStyleUtil.k14Semibold(
                    color: controller.selectedYear.value == year
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              )),
        );
      },
    );
  }
}
