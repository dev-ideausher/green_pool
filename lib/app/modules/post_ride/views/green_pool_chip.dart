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
    // required this.selectedChipIndex,
    this.radius,
    required this.labelText,
    required this.selected,
    this.onPressed,
  });

  final dynamic controller;
  final String labelText;
  // final int selectedChipIndex;
  final double? radius;
  final bool selected;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(vertical: 8.kh, horizontal: 16.kw),
      showCheckmark: false,
      backgroundColor: ColorUtil.kBackgroundColor,
      label: Row(
        children: [
          // controller.luggageAllowance[selectedChipIndex].value
          selected
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
      selected: selected,
      // selected: controller.luggageAllowance[selectedChipIndex].value,
      onPressed: onPressed,
      // onPressed: () => controller.setSelected(selectedChipIndex),
      side: selected
          ? BorderSide.none
          : const BorderSide(color: ColorUtil.kBlack06),
      labelStyle: selected
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
    );
  }
}
