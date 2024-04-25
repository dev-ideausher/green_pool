import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

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
      appBar: const GreenPoolAppBar(
        title: Text('File Dispute'),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'File a dispute if either party causes any issue to the other party',
              style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
            ).paddingOnly(top: 32.kh, bottom: 24.kh),
            Text(
              'Enter Booking Id',
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: '${controller.bookingId}',
              readOnly: true,
              hintColor: ColorUtil.kBlack01,
            ).paddingOnly(bottom: 16.kh),
            Text(
              'Dispute Description',
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: 'Enter text here',
              controller: controller.descriptionTextController,
              maxLines: 4,
            ).paddingOnly(bottom: 16.kh),
            Text(
              'Upload Images (optional)',
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 16.kh),
            GestureDetector(
              onTap: () {
                controller.getImage(ImageSource.gallery);
              },
              child: Obx(
                () => Container(
                  height: 80.kh,
                  width: 80.kw,
                  padding: controller.isImageSelected.value
                      ? EdgeInsets.all(0.kh)
                      : EdgeInsets.all(30.kh),
                  decoration: BoxDecoration(
                      color: ColorUtil.kGreyColor,
                      borderRadius: BorderRadius.circular(8.kh)),
                  child: controller.isImageSelected.value
                      ? Image.file(
                          controller.selectedImagePath.value!,
                        )
                      : SizedBox(
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
            GreenPoolButton(
              onPressed: () {
                controller.fileDisputeAPI();
              },
              label: 'Submit',
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
