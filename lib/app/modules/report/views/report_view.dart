import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/richtext_heading.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/common_image_view.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  GreenPoolAppBar(
        title: Text(Strings.reportABug),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.makeItEasyToTellUsAboutProblems,
            style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
          ).paddingOnly(bottom: 24.kh, top: 32.kh),
          RichTextHeading(
            text: Strings.bugslashfeedback,
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: Strings.enterHere,
            controller: controller.bugController,
            onchanged: (val) {
              controller.bugController.text = val.toString();
              controller.handleButtonState(val ?? "");
            },
          ).paddingOnly(bottom: 16.kh),
          Text(
            Strings.uploadImagesOptional,
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 16.kh),
          GestureDetector(
            onTap: () => controller.getBugImage(ImageSource.gallery),
            child: Obx(
              () => controller.picUploaded.value
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
                            if (index == controller.selectedImages.length + 1) {
                              return UploadImage(controller: controller);
                            } else {
                              return CommonImageView(
                                file: controller.selectedImages[index],
                                height: 30.kh,
                                width: 30.kw,
                              );
                            }
                          }),
                    )
                  : UploadImage(controller: controller),
            ),
          ),
          const Expanded(child: SizedBox()),
          Obx(
            () => GreenPoolButton(
              onPressed: () => controller.bugReportAPI(),
              label: Strings.submit,
              isActive: controller.isActive.value,
            ).paddingSymmetric(vertical: 40.kh),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

class UploadImage extends StatelessWidget {
  const UploadImage({
    super.key,
    required this.controller,
  });

  final ReportController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.kh,
      width: 80.kw,
      padding: controller.picUploaded.value
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
    );
  }
}
