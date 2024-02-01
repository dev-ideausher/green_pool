import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/profile/controllers/profile_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../controllers/chat_page_controller.dart';

class ChatPageView extends GetView<ChatPageController> {
  const ChatPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.find<ProfileController>().isSwitched.value
            ? ColorUtil.kPrimaryPinkMode
            : ColorUtil.kPrimary01,
        surfaceTintColor: Get.find<ProfileController>().isSwitched.value
            ? ColorUtil.kPrimaryPinkMode
            : ColorUtil.kPrimary01,
        elevation: 1,
        toolbarHeight: 64.kh,
        title: Row(children: [
          Image.asset(
            ImageConstant.pngUserSquare,
            height: 32.kh,
          ).paddingOnly(right: 8.kw),
          Text(
            'Cody Fisher',
            style: TextStyleUtil.k14Bold(),
          )
        ]),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            ImageConstant.svgIconBack,
          ).paddingAll(14.kh),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Today',
                  style: TextStyleUtil.k14Regular(),
                ),
                Text(
                  '6 Nov 2023',
                  style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack04),
                )
              ],
            ).paddingOnly(top: 8.kh),
          ),
          const Expanded(child: SizedBox()),
          GreenPoolTextField(
            hintText: 'Write a message',
            suffix: SvgPicture.asset(ImageConstant.svgIconSend),
          ).paddingOnly(bottom: 40.kh)
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}
