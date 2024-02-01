import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../controllers/file_dispute_controller.dart';

class SubmitDispute extends GetView<FileDisputeController> {
  const SubmitDispute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const GreenPoolTextField(
              hintText: 'Enter booking id',
               
            ).paddingOnly(bottom: 16.kh),
            Text(
              'Dispute Description',
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            const GreenPoolTextField(
              hintText: 'Enter text here',
               
              maxLines: 4,
            ).paddingOnly(bottom: 16.kh),
            Text(
              'Upload Images (optional)',
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 16.kh),
            Container(
              height: 80.kh,
              width: 80.kw,
              decoration: BoxDecoration(
                  color: ColorUtil.kGreyColor,
                  borderRadius: BorderRadius.circular(8.kh)),
              child: SizedBox(
                height: 20.kh,
                width: 20.kw,
                child: SvgPicture.asset(
                  //TODO:height
                  ImageConstant.svgIconUploadPhoto,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            GreenPoolButton(
              onPressed: () => Get.back(),
              label: 'Submit',
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
