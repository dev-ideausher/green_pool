import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
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
        appBar: GreenPoolAppBar(
            title: Text(Strings.messages), leading: const SizedBox()),
        body: Obx(
          () => RefreshIndicator(
            backgroundColor: ColorUtil.kWhiteColor,
            color: Get.find<HomeController>().isPinkModeOn.value
                ? ColorUtil.kPrimary3PinkMode
                : ColorUtil.kPrimary01,
            key: controller.refreshIndicatorKey,
            onRefresh: () async {
              await controller.refreshMessageListAPI();
            },
            child: controller.isLoading.value
                ? ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        // height: 78.kh,
                        child: ListTile(
                          tileColor: ColorUtil.kWhiteColor,
                          onTap: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.kh)),
                          title: SizedBox(
                            height: 10.kh,
                            width: 100.w,
                            child: const LinearProgressIndicator(
                              color: ColorUtil.kGreyColor,
                            ),
                          ),
                          subtitle: SizedBox(
                            height: 10.kh,
                            width: 100.w,
                            child: const LinearProgressIndicator(
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
                                child: const LinearProgressIndicator(
                                  color: ColorUtil.kGreyColor,
                                )),
                          ),
                          trailing:
                              SvgPicture.asset(ImageConstant.svgIconRightArrow),
                        ),
                      ).paddingOnly(top: 8.kh);
                    },
                  ).paddingOnly(left: 16.kw, right: 16.kw, top: 8.kh)
                : controller.messagesModel.value.chatRoomIds!.isEmpty
                    ? Center(
                        child: Text(
                          Strings.yourFutureMsgsWillApearHere,
                          style: TextStyleUtil.k24Heading600(),
                          textAlign: TextAlign.center,
                        ),
                      ).paddingSymmetric(horizontal: 16.kw)
                    : ListView.builder(
                        itemCount:
                            controller.messagesModel.value.chatRoomIds!.length,
                        itemBuilder: (context, index) {
                          final message = controller
                              .messagesModel.value.chatRoomIds?[index];
                          final isPinkModeOn =
                              Get.find<HomeController>().isPinkModeOn.value;
                          final messageRead = controller.messagesModel.value
                                      .chatRoomIds?[index]?.unReadCount ==
                                  0 ||
                              controller.messagesModel.value.chatRoomIds?[index]
                                      ?.unReadCount ==
                                  null;
                          return MessageTile(
                            onTap: () {
                              controller.getToChatPage(
                                  message, controller.refreshIndicatorKey);
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
          ),
        ));
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
      // height: 78.kh,
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
