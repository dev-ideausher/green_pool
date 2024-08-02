import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import '../../../../generated/assets.dart';
import '../controllers/help_support_controller.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GreenPoolAppBar(
        title: Text(Strings.helpAndSupport),
      ),
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : Padding(
                padding:
                    EdgeInsets.only(left: 16.kw, right: 16.kw, bottom: 80.kh),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.getYourAnsHere,
                      style: TextStyleUtil.k16Bold(),
                    ).paddingOnly(bottom: 8.kh),
                    GreenPoolTextField(
                      hintText: Strings.howCanWeHelpYou,
                      suffix: const Icon(
                        Icons.chevron_right,
                        color: ColorUtil.kBlack01,
                      ),
                      prefix: const Icon(
                        Icons.search,
                        color: ColorUtil.kBlack02,
                      ),
                    ).paddingOnly(bottom: 8.kh),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.helpModel.length,
                        itemBuilder: (context, index) {
                          final group = controller.helpModel[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    group.category?.title ?? "",
                                    style: TextStyleUtil.k18Bold(),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1.kh,
                                      color: ColorUtil.kNeutral2,
                                    ).paddingOnly(left: 8.kw),
                                  ),
                                ],
                              ).paddingOnly(bottom: 20.kh),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: group.quesAns?.length,
                                itemBuilder: (context, itemsIndex) {
                                  final item = group.quesAns![itemsIndex];
                                  final key = '${index}_$itemsIndex';
                                  return Obx(
                                    () => ListTile(
                                      title: Text(
                                        item?.question ?? "",
                                        style: TextStyleUtil.k18Bold(),
                                      ),
                                      subtitle: Visibility(
                                        visible: controller
                                                .isExpandedMap[key]?.value ??
                                            false,
                                        child: Text(item?.answer ?? ""),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          controller.showHide(
                                              index, itemsIndex);
                                        },
                                        icon: Icon(
                                          controller.isExpandedMap[key]
                                                      ?.value ??
                                                  false
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                        ),
                                      ),
                                      // Add more UI components for displaying additional information if needed
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(bottom: 22.0.kh, left: 16.kw, right: 16.kw),
          child: Card(
            elevation: 0.1,
            color: Colors.white.withOpacity(0.8),
            child: ListTile(
              onTap: () => controller.navigateToChatPage(),
              leading: SvgPicture.asset(Assets.svgChatbox),
              title: Text(Strings.chatWithOurExperts),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
      ),
    );
  }
}
