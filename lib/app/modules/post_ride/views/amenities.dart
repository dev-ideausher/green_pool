import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/post_ride_controller.dart';

class Amenities extends GetView<PostRideController> {
  final String text, image;
  final bool? value;
  final bool? toggleSwitch;
  final Function(bool)? onChanged;
  const Amenities({
    super.key,
    this.value,
    this.onChanged,
    this.toggleSwitch,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          image,
          colorFilter: ColorFilter.mode(
              Get.find<ProfileController>().isSwitched.value
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
                  inactiveTrackColor:
                      Get.find<ProfileController>().isSwitched.value
                          ? ColorUtil.kSecondaryPinkMode
                          : ColorUtil.kPrimary05,
                  activeTrackColor:
                      Get.find<ProfileController>().isSwitched.value
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
