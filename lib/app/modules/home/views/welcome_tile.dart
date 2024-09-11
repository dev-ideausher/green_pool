import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';

class WelcomeTile extends StatelessWidget {
  const WelcomeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      final storageService = Get.find<GetStorageService>();
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
                        text: storageService.isLoggedIn &&
                                storageService.profileStatus
                            ? " ${Get.find<GetStorageService>().getUserName.split(" ").first ?? "..."},"
                            : "",
                        style: TextStyleUtil.k24Heading700(
                            color: storageService.isPinkMode
                                ? ColorUtil.kPrimaryPinkMode
                                : ColorUtil.kPrimary01),
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 4.kh),
              ),
              Text(Strings.whatWouldYouLikeToDoToday,
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04))
            ],
          ),
          Visibility(
            visible: storageService.isLoggedIn,
            child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.NOTIFICATIONS);
                  controller.newMsgReceived.value = false;
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    SvgPicture.asset(ImageConstant.svgIconNoti),
                    Obx(
                      () => Visibility(
                        visible: controller.newMsgReceived.value,
                        child: Container(
                          height: 10.kh,
                          width: 10.kw,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: ColorUtil.kError2),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ).paddingSymmetric(vertical: 40.kh);
    });
  }
}
