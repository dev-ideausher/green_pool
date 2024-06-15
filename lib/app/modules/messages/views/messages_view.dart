import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/data/chat_arg.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../components/common_image_view.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../res/strings.dart';
import '../controllers/messages_controller.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MessagesController());
    controller.getMessageListAPI();
    return Scaffold(
      appBar:
          GreenPoolAppBar(title: Text(Strings.messages), leading: SizedBox()),
      body: Get.find<GetStorageService>().getLoggedIn
          ? Obx(
              () => controller.isLoading.value
                  ? ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 78.kh,
                          child: ListTile(
                            tileColor: ColorUtil.kWhiteColor,
                            onTap: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.kh)),
                            title: Container(
                              height: 10.kh,
                              width: 100.w,
                              child: LinearProgressIndicator(
                                color: ColorUtil.kGreyColor,
                              ),
                            ),
                            subtitle: Container(
                              height: 10.kh,
                              width: 100.w,
                              child: LinearProgressIndicator(
                                color: ColorUtil.kGreyColor,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 24.kw, vertical: 8.kh),
                            leading: SizedBox(
                              height: 40.kh,
                              width: 40.kw,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.kh),
                                  child: LinearProgressIndicator(
                                    color: ColorUtil.kGreyColor,
                                  )),
                            ),
                            trailing: SvgPicture.asset(
                                ImageConstant.svgIconRightArrow),
                          ),
                        );
                      },
                    )
                  : controller.messagesModel.value.chatRoomIds!.isEmpty
                      ? Center(
                          child: Text(
                            "Your future messages will appear here",
                            style: TextStyleUtil.k24Heading600(),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller
                              .messagesModel.value.chatRoomIds!.length,
                          itemBuilder: (context, index) {
                            final message = controller
                                .messagesModel.value.chatRoomIds?[index];
                            final isPinkModeOn =
                                Get.find<HomeController>().isPinkModeOn.value;
                            final messageRead = controller.messagesModel.value
                                        .chatRoomIds?[index]?.unReadCount ==
                                    0 ||
                                controller.messagesModel.value
                                        .chatRoomIds?[index]?.unReadCount ==
                                    null;
                            return MessageTile(
                              onTap: () {
                                controller.getToChatPage(message);
                              },
                              title: controller.messagesModel.value
                                      .chatRoomIds?[index]?.user2?.fullName ??
                                  "",
                              path: controller
                                      .messagesModel
                                      .value
                                      .chatRoomIds?[index]
                                      ?.user2
                                      ?.profilePic
                                      ?.url ??
                                  "",
                              subtitle: message?.lastMessage ?? "",
                              subtitleStyle: messageRead
                                  ? TextStyleUtil.k14Regular(
                                      color: ColorUtil.kBlack03)
                                  : TextStyleUtil.k14Bold(
                                      color: isPinkModeOn
                                          ? ColorUtil.kPrimary3PinkMode
                                          : ColorUtil.kSecondary03),
                              trailing: messageRead
                                  ? SvgPicture.asset(
                                      ImageConstant.svgIconRightArrow)
                                  : Container(
                                      padding: EdgeInsets.all(10.kh),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isPinkModeOn
                                              ? ColorUtil.kPrimaryPinkMode
                                              : ColorUtil.kPrimary01),
                                      child: Text(
                                        "${controller.messagesModel.value.chatRoomIds?[index]?.unReadCount}",
                                        style: TextStyleUtil.k12Bold(),
                                      ),
                                    ),
                            ).paddingOnly(top: 8.kh);
                          },
                        ).paddingOnly(left: 16.kw, right: 16.kw, top: 8.kh),
            )
          : Center(
              child: Text(
              "Tap on profile to continue",
              style: TextStyleUtil.k20Heading600(),
            )),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String title, path, subtitle;
  final Widget trailing;
  final TextStyle? subtitleStyle;
  final Function() onTap;

  const MessageTile({
    super.key,
    required this.title,
    required this.path,
    required this.onTap,
    required this.subtitle,
    required this.trailing,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78.kh,
      child: ListTile(
        tileColor: ColorUtil.kWhiteColor,
        onTap: onTap,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh)),
        title: Text(
          title,
          style: TextStyleUtil.k14Semibold(),
        ),
        subtitle: Text(
          subtitle,
          style: subtitleStyle ??
              TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
          overflow: TextOverflow.ellipsis,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 24.kw, vertical: 8.kh),
        leading: SizedBox(
          height: 40.kh,
          width: 40.kw,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.kh),
            child: CommonImageView(
              url: path,
            ),
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
