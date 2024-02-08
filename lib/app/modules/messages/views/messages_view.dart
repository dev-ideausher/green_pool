import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../components/greenpool_appbar.dart';
import '../controllers/messages_controller.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Messages'),
        leading: SizedBox(),
      ),
      body: Get.find<GetStorageService>().getLoggedIn
          ? ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Get.toNamed(Routes.CHAT_PAGE),
                  child: Container(
                    padding: EdgeInsets.all(16.kh),
                    decoration: BoxDecoration(
                        color: ColorUtil.kWhiteColor,
                        borderRadius: BorderRadius.circular(8.kh),
                        border: const Border(
                            bottom: BorderSide(color: ColorUtil.kGreyColor))),
                    child: Row(
                      children: [
                        Image.asset(
                          ImageConstant.pngUserSquare,
                        ).paddingOnly(right: 8.kw),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cody Fisher',
                              style: TextStyleUtil.k14Semibold(),
                            ).paddingOnly(bottom: 4.kh),
                            Text(
                              'No worries, I will be there on time.',
                              style: TextStyleUtil.k14Regular(
                                  color: ColorUtil.kBlack03),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        SvgPicture.asset(ImageConstant.svgIconRightArrow),
                      ],
                    ),
                  ).paddingOnly(bottom: 4.kh),
                );
              },
            ).paddingOnly(left: 16.kw, right: 16.kw, top: 32.kh)
          : Center(
              child: Text(
                'Please Login or SignUp',
                style: TextStyleUtil.k24Heading600(),
              ),
            ),
    );
  }
}
