import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../modules/home/controllers/home_controller.dart';
import '../services/colors.dart';
import '../services/text_style_util.dart';

class AmenityTileWidget extends StatelessWidget {
  final String text, image;
  final bool? value;
  final bool? toggleSwitch;
  final Function(bool)? onChanged;
  const AmenityTileWidget({
    super.key,
    this.value,
    this.onChanged,
    this.toggleSwitch,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    return Row(
      children: [
        SvgPicture.asset(
          image,
          colorFilter: ColorFilter.mode(
              isPinkModeOn
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
              BlendMode.srcIn),
        ).paddingOnly(right: 8.kw),
        Text(
          text,
          style: TextStyleUtil.k14Semibold(),
        ),
        const Expanded(child: SizedBox()),
        toggleSwitch ?? true
            ? Transform.scale(
                scale: 0.8.kh,
                child: Switch(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: value ?? false,
                  // value: controller.switchStates[index].value,
                  onChanged: onChanged,
                  // onChanged: (value) {
                  //   controller.toggleSwitch(index);
                  // },
                  inactiveThumbColor: ColorUtil.kNeutral1,
                  inactiveTrackColor: isPinkModeOn
                      ? ColorUtil.kSecondaryPinkMode
                      : ColorUtil.kPrimary05,
                  activeTrackColor: isPinkModeOn
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  trackOutlineWidth: const MaterialStatePropertyAll(0),
                  thumbColor:
                      const MaterialStatePropertyAll(ColorUtil.kWhiteColor),
                  trackOutlineColor:
                      const MaterialStatePropertyAll(ColorUtil.kNeutral1),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
