import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

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
      appBar: const GreenPoolAppBar(
        title: Text('Report a bug'),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Make it easy to tell us about problems so we\ncan fix them quickly and make things better\nfor you!',
            style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
          ).paddingOnly(bottom: 24.kh, top: 32.kh),
          Text(
            'Bug/Feedback',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: 'Enter here',
            controller: controller.bugController,
            onchanged: (val) {
              controller.bugController.text = val.toString();
            },
          ).paddingOnly(bottom: 16.kh),
          Text(
            'Upload Images (optional)',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 16.kh),
          GestureDetector(
            onTap: () => controller.getBugImage(ImageSource.gallery),
            child: Obx(
              () => controller.picUploaded.value
                  ? Container(
                      height: 80.kh,
                      width: 80.kw,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: ColorUtil.kGreyColor,
                          borderRadius: BorderRadius.circular(8.kh)),
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(8.kh),
                        child: Image.file(
                          controller.uploadedPic.value!,
                        ),
                      ),
                    )
                  : Container(
                      height: 80.kh,
                      width: 80.kw,
                      padding: EdgeInsets.all(30.kh),
                      decoration: BoxDecoration(
                          color: ColorUtil.kGreyColor,
                          borderRadius: BorderRadius.circular(8.kh)),
                      child: SvgPicture.asset(
                        ImageConstant.svgIconUploadPhoto,
                      ),
                    ),
            ),
          ),
          const Expanded(child: SizedBox()),
          GreenPoolButton(
            onPressed: () => controller.bugReportAPI(),
            label: 'Submit',
          ).paddingSymmetric(vertical: 40.kh),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}
