import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';

class WelcomeTile extends StatelessWidget {
  const WelcomeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: controller.welcomeText.value,
                        style: TextStyleUtil.k24Heading700(),
                      ),
                      TextSpan(
                        text: Get.find<GetStorageService>().isLoggedIn
                            ? " ${controller.userInfo.value.data?.fullName ?? "..."}"
                            : "",
                        style: TextStyleUtil.k24Heading700(
                            color: Get.find<GetStorageService>().isPinkMode
                                ? ColorUtil.kPrimaryPinkMode
                                : ColorUtil.kPrimary01),
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 4.kh),
              )
            ],
          ),
          Visibility(
            visible: Get.find<GetStorageService>().isLoggedIn,
            child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.NOTIFICATIONS);
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Visibility(
                      visible: false, // controller.unReadCount.value > 0,
                      child: Container(
                        height: 10.kh,
                        width: 10.kw,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: ColorUtil.kError2),
                      ),
                    ),
                    SvgPicture.asset(ImageConstant.svgIconNoti),
                  ],
                )),
          ),
        ],
      ).paddingSymmetric(vertical: 40.kh);
    });
  }
}
