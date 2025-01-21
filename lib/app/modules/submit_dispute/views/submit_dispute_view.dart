import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../controllers/submit_dispute_controller.dart';

class SubmitDisputeView extends GetView<SubmitDisputeController> {
  const SubmitDisputeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_fileDispute.tr),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.app_fileIfanyPartyCausesAnyIssue.tr,
              style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
            ).paddingOnly(top: 32.kh, bottom: 24.kh),
            Text(
              LocaleKeys.app_enterBookingId.tr,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: '${controller.bookingId}',
              readOnly: true,
              hintColor: ColorUtil.kBlack01,
            ).paddingOnly(bottom: 16.kh),
            Text(
              LocaleKeys.app_disputeDescription.tr,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: LocaleKeys.app_enterTextHere.tr,
              controller: controller.descriptionTextController,
              maxLines: 4,
              onchanged: (value) {
                controller.handleButtonState(value ?? "");
              },
            ).paddingOnly(bottom: 16.kh),
            Text(
              LocaleKeys.app_uploadImages.tr,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 16.kh),
            GestureDetector(
              onTap: () {
                controller.getImage(ImageSource.gallery);
              },
              child: Obx(
                () => controller.isImageSelected.value
                    ? SizedBox(
                        width: 80.w,
                        height: 200.kh,
                        child: GridView.builder(
                            itemCount: controller.selectedImages.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 16.kh,
                                    mainAxisSpacing: 16.kh),
                            itemBuilder: (context, index) {
                              if (index ==
                                  controller.selectedImages.length + 1) {
                                return Container(
                                  height: 80.kh,
                                  width: 80.kw,
                                  padding: controller.isImageSelected.value
                                      ? EdgeInsets.all(0.kh)
                                      : EdgeInsets.all(30.kh),
                                  decoration: BoxDecoration(
                                      color: ColorUtil.kGreyColor,
                                      borderRadius:
                                          BorderRadius.circular(8.kh)),
                                  child: SizedBox(
                                    height: 20.kh,
                                    width: 20.kw,
                                    child: SvgPicture.asset(
                                      ImageConstant.svgIconUploadPhoto,
                                    ),
                                  ),
                                );
                              } else {
                                return CommonImageView(
                                  file: controller.selectedImages[index],
                                  height: 30.kh,
                                  width: 30.kw,
                                );
                              }
                            }),
                      )
                    : Container(
                        height: 80.kh,
                        width: 80.kw,
                        padding: controller.isImageSelected.value
                            ? EdgeInsets.all(0.kh)
                            : EdgeInsets.all(30.kh),
                        decoration: BoxDecoration(
                            color: ColorUtil.kGreyColor,
                            borderRadius: BorderRadius.circular(8.kh)),
                        child: SizedBox(
                          height: 20.kh,
                          width: 20.kw,
                          child: SvgPicture.asset(
                            ImageConstant.svgIconUploadPhoto,
                          ),
                        ),
                      ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Obx(
              () => GreenPoolButton(
                onPressed: () {
                  controller.fileDisputeAPI();
                },
                isActive: controller.isActive.value,
                label: LocaleKeys.app_submit.tr,
              ).paddingOnly(bottom: 40.kh),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
