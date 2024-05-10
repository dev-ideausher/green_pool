import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/profile_controller.dart';

class ProfileContainer extends GetView<ProfileController> {
  final String image, text;
  final BoxBorder? border;
  final Function()? onTap;
  final Widget? child, info;
  const ProfileContainer({
    super.key,
    required this.image,
    required this.text,
    this.border,
    this.onTap,
    this.child,
    this.info,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.kh),
        decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.circular(8.kh),
            border: border ??
                Border(
                    bottom:
                        BorderSide(color: ColorUtil.kGreyColor, width: 1.kh))),
        child: Row(
          children: [
            Obx(
              () => SvgPicture.asset(
                image,
                colorFilter: ColorFilter.mode(
                    controller.pinkMode.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kPrimary01,
                    BlendMode.srcIn),
              ).paddingOnly(right: 12.kw),
            ),
            Text(
              text,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(right: 4.kw),
            info ?? const SizedBox(),
            const Expanded(child: SizedBox()),
            child ?? SvgPicture.asset(ImageConstant.svgIconRightArrow),
          ],
        ),
      ),
    );
  }
}
