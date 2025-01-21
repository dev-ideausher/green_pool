import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/post_ride_step_two/controllers/post_ride_step_two_controller.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';

class AmenitiesList extends GetView<PostRideStepTwoController> {
  const AmenitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(
        () => Column(
          children: [
            AmenityTile(
                text: LocaleKeys.app_appreciatesConversation.tr,
                image: ImageConstant.svgAmenities1,
                value: controller.appreciatesConversation.value,
                onChanged: (val) {
                  controller.appreciatesConversation.value = val;
                }),
            AmenityTile(
              text: LocaleKeys.app_enjoysMusic.tr,
              image: ImageConstant.svgAmenities2,
              value: controller.enjoysMusic.value,
              onChanged: (val) {
                controller.enjoysMusic.value = val;
              },
            ),
            AmenityTile(
              text: LocaleKeys.app_smokeFree.tr,
              image: ImageConstant.svgAmenities3,
              value: controller.smokeFree.value,
              onChanged: (val) {
                controller.smokeFree.value = val;
              },
            ),
            AmenityTile(
              text: LocaleKeys.app_petFriendly.tr,
              image: ImageConstant.svgAmenities4,
              value: controller.petFriendly.value,
              onChanged: (val) {
                controller.petFriendly.value = val;
              },
            ),
            AmenityTile(
              text: LocaleKeys.app_winterTires.tr,
              image: ImageConstant.svgAmenities5,
              value: controller.winterTires.value,
              onChanged: (val) {
                controller.winterTires.value = val;
              },
            ),
            AmenityTile(
              text: LocaleKeys.app_coolingOrHeating.tr,
              image: ImageConstant.svgAmenities6,
              value: controller.coolingOrHeating.value,
              onChanged: (val) {
                controller.coolingOrHeating.value = val;
              },
            ),
            AmenityTile(
              text: LocaleKeys.app_babySeat.tr,
              image: ImageConstant.svgAmenities7,
              value: controller.babySeat.value,
              onChanged: (val) {
                controller.babySeat.value = val;
              },
            ),
            AmenityTile(
              text: LocaleKeys.app_heatedSeats.tr,
              image: ImageConstant.svgAmenities8,
              value: controller.heatedSeats.value,
              onChanged: (val) {
                controller.heatedSeats.value = val;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AmenityTile extends AmenitiesList {
  final String text, image;
  final bool? value;
  final bool? toggleSwitch;
  final Function(bool)? onChanged;
  const AmenityTile({
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
              controller.isPinkMode.value
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
              )
            : const SizedBox(),
      ],
    );
  }
}
