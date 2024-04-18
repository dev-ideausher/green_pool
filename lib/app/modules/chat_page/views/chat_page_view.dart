import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/profile/controllers/profile_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../components/gp_progress.dart';
import '../controllers/chat_page_controller.dart';

class ChatPageView extends GetView<ChatPageController> {
  const ChatPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
        surfaceTintColor: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
        elevation: 1,
        toolbarHeight: 64.kh,
        title: Obx(
          () => Row(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16.kh),
                child: CommonImageView(
                  url: controller.chatArg.value.image,
                  height: 32.kh,
                  width: 32.kh,
                )),
            12.kwidthBox,
            Text(
              controller.chatArg.value.name ?? "",
              style: TextStyleUtil.k14Bold(),
            )
          ]),
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            ImageConstant.svgIconBack,
          ).paddingAll(14.kh),
        ),
      ),
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : Column(
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
                  Expanded(
                      child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.messages.length,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      final isSender = message.senderId == Get.find<GetStorageService>().getUserAppId;
                      return Container(
                        padding: EdgeInsets.only(left: 14.kw, right: 14.kw, top: 10.kh, bottom: 10.kh),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isSender) // Receiver's image
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.kh),
                                    child: CommonImageView(
                                      url: controller.chatArg.value.image,
                                      height: 32.kh,
                                      width: 32.kh,
                                    )),
                              ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15.0.kh)),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message.message ?? "",
                                          style: TextStyleUtil.k14Regular(),
                                        ),
                                        4.kheightBox, // Add some space between message and time
                                        Text(
                                          DateFormat.jm().format(message.timestamp), // Replace with actual time
                                          style: TextStyleUtil.k10Regular(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSender) // Sender's image
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.kh),
                                    child: CommonImageView(
                                      url: Get.find<GetStorageService>().profilePicUrl,
                                      height: 32.kh,
                                      width: 32.kh,
                                    )),
                              ),
                          ],
                        ),
                      );
                    },
                  )),
                  GreenPoolTextField(
                    controller: controller.eMsg,
                    hintText: 'Write a message',
                    suffix: InkWell(onTap: () => controller.sendMsg(), child: SvgPicture.asset(ImageConstant.svgIconSend)),
                  ).paddingOnly(bottom: 40.kh)
                ],
              ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
