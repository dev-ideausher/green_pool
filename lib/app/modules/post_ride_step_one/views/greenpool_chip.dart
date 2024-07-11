import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';

class GreenPoolChip extends StatelessWidget {
  final dynamic controller;
  final String labelText;
  final EdgeInsetsGeometry? padding;
  // final int selectedChipIndex;
  final double? radius, textPadding;
  final bool selected;
  final Widget? label;
  final Function()? onPressed;

  const GreenPoolChip({
    super.key,
    required this.controller,
    this.radius,
    required this.labelText,
    required this.selected,
    this.onPressed,
    this.padding,
    this.label,
    this.textPadding,
  });

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding:
          padding ?? EdgeInsets.symmetric(vertical: 8.kh, horizontal: 16.kw),
      showCheckmark: false,
      backgroundColor: ColorUtil.kBackgroundColor,
      label: Row(
        children: [
          selected
              ? label ??
                  SvgPicture.asset(
                    ImageConstant.svgIconLuggageFilled,
                    colorFilter: ColorFilter.mode(
                        Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kSecondary01
                            : ColorUtil.kWhiteColor,
                        BlendMode.srcIn),
                  )
              : label ?? SvgPicture.asset(ImageConstant.svgIconLuggageFilled),
          Text(labelText).paddingOnly(left: textPadding ?? 4.kw),
        ],
      ),
      disabledColor: Colors.transparent,
      selected: selected,
      onPressed: onPressed,
      side: selected
          ? BorderSide.none
          : const BorderSide(color: ColorUtil.kBlack06),
      labelStyle: selected
          ? TextStyleUtil.k14Regular(
              color: Get.find<HomeController>().isPinkModeOn.value
                  ? ColorUtil.kSecondary01
                  : ColorUtil.kWhiteColor)
          : TextStyleUtil.k14Regular(color: ColorUtil.kSecondary01),
      selectedColor: Get.find<HomeController>().isPinkModeOn.value
          ? ColorUtil.kPrimary3PinkMode
          : ColorUtil.kSecondary01,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 8.kh),
      ),
    );
  }
}