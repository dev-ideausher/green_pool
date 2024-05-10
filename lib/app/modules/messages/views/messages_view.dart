import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/data/chat_arg.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../components/common_image_view.dart';
import '../../../components/greenpool_appbar.dart';
import '../controllers/messages_controller.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MessagesController());
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Messages'),
        leading: SizedBox(),
      ),
      body: Get.find<GetStorageService>().getLoggedIn
          ? Obx(
              () => controller.isLoading.value
                  ? const GpProgress()
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
                            return MessageTile(
                                onTap: () {
                                  Get.toNamed(Routes.CHAT_PAGE,
                                      arguments: ChatArg(
                                          chatRoomId: controller
                                              .messagesModel
                                              .value
                                              .chatRoomIds?[index]
                                              ?.chatRoomId,
                                          id: controller.messagesModel.value
                                              .chatRoomIds?[index]?.Id,
                                          image: controller
                                              .messagesModel
                                              .value
                                              .chatRoomIds?[index]
                                              ?.user2
                                              ?.profilePic
                                              ?.url,
                                          name: controller
                                              .messagesModel
                                              .value
                                              .chatRoomIds?[index]
                                              ?.user2
                                              ?.fullName,
                                          rideId: controller
                                              .messagesModel
                                              .value
                                              .chatRoomIds?[index]
                                              ?.ridePostId));
                                },
                                title:
                                    "${controller.messagesModel.value.chatRoomIds?[index]?.user2?.fullName}",
                                path:
                                    "${controller.messagesModel.value.chatRoomIds?[index]?.user2?.profilePic?.url}",
                                subtitle:
                                    'No worries, I will be there on time.');
                          },
                        ).paddingOnly(left: 16.kw, right: 16.kw, top: 32.kh),
            )
          : Center(
              child: Text(
              "Tap on profile to continue",
              style: TextStyleUtil.k20Heading600(),
            )
              // Text.rich(
              //   TextSpan(
              //     children: [
              //       TextSpan(
              //         text: 'Please  ',
              //         style: TextStyleUtil.k16Regular(),
              //       ),
              //       TextSpan(
              //           text: 'Login  ',
              //           style: TextStyleUtil.k20Heading700(
              //               color: ColorUtil.kPrimary01),
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () => Get.toNamed(Routes.LOGIN, arguments: {
              //                   'isDriver': false,
              //                   'fromNavBar': true
              //                 })),
              //       TextSpan(
              //         text: 'or  ',
              //         style: TextStyleUtil.k16Regular(),
              //       ),
              //       TextSpan(
              //           text: 'SignUp',
              //           style: TextStyleUtil.k20Heading700(
              //               color: ColorUtil.kPrimary01),
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () => Get.toNamed(Routes.CREATE_ACCOUNT,
              //                     arguments: {
              //                       'isDriver': false,
              //                       'fromNavBar': true
              //                     })),
              //     ],
              //   ),
              // ),
              ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String title, path, subtitle;
  final Function() onTap;
  const MessageTile({
    super.key,
    required this.title,
    required this.path,
    required this.onTap,
    required this.subtitle,
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
          style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
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
        trailing: SvgPicture.asset(ImageConstant.svgIconRightArrow),
      ),
    );
  }
}
