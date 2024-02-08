import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';

class GreenPoolChip extends StatelessWidget {
  const GreenPoolChip({
    super.key,
    required this.controller,
    required this.selectedChipIndex,
    this.radius,
    required this.labelText,
  });

  final dynamic controller;
  final String labelText;
  final int selectedChipIndex;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RawChip(
        padding: EdgeInsets.symmetric(vertical: 8.kh, horizontal: 16.kw),
        showCheckmark: false,
        backgroundColor: ColorUtil.kBackgroundColor,
        label: Row(
          children: [
            controller.luggageAllowance[selectedChipIndex].value
                ? SvgPicture.asset(
                    ImageConstant.svgIconLuggageFilled,
                    colorFilter: ColorFilter.mode(
                        Get.find<ProfileController>().isSwitched.value
                            ? ColorUtil.kSecondary01
                            : ColorUtil.kWhiteColor,
                        BlendMode.srcIn),
                  )
                : SvgPicture.asset(ImageConstant.svgIconLuggageFilled),
            Text(labelText).paddingOnly(left: 4.kw),
          ],
        ),
        disabledColor: Colors.transparent,
        selected: controller.luggageAllowance[selectedChipIndex].value,
        onPressed: () => controller.setSelected(selectedChipIndex),
        side: controller.luggageAllowance[selectedChipIndex].value
            ? BorderSide.none
            : const BorderSide(color: ColorUtil.kBlack06),
        labelStyle: controller.luggageAllowance[selectedChipIndex].value
            ? TextStyleUtil.k14Regular(
                color: Get.find<ProfileController>().isSwitched.value
                    ? ColorUtil.kSecondary01
                    : ColorUtil.kWhiteColor)
            : TextStyleUtil.k14Regular(color: ColorUtil.kSecondary01),
        selectedColor: Get.find<ProfileController>().isSwitched.value
            ? ColorUtil.kPrimary3PinkMode
            : ColorUtil.kSecondary01,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 8.kh),
        ),
      ),
    );
  }
}
