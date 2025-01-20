import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../components/richtext_heading.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/vehicle_details_controller.dart';

class VehicleDetailsView extends GetView<VehicleDetailsController> {
  const VehicleDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.vehicleDetails),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichTextHeading(text: Strings.vehiclePhoto)
                .paddingOnly(top: 32.kh, bottom: 8.kh),
            GestureDetector(
              onTap: () {
                controller.getVehicleImage(ImageSource.gallery);
              },
              child: Obx(() => Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 68.kh, horizontal: 76.kw),
                  decoration: BoxDecoration(
                      color: ColorUtil.kGreyColor,
                      borderRadius: BorderRadius.circular(8.kh)),
                  child: controller.isVehiclePicUpdated?.value == true
                      ? CommonImageView(
                          file: controller.selectedVehicleImagePath?.value ??
                              File(''),
                        )
                      : CommonImageView(
                          url:
                              "${controller.vehicleInfoModel!.vehiclePic!.url}"))),
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.model).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.enterVehicleModel,
              controller: controller.modelTextController,
              onchanged: (value) {
                if (value != null) {
                  controller.isBtnActive.value = true;
                }
              },
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen,
                  colorFilter: ColorFilter.mode(
                      Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn)),
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.type).paddingOnly(bottom: 8.kh),
            Obx(
              () => GreenPoolTextField(
                hintText: Strings.selectVehicleType,
                controller: controller.type,
                suffix: controller.isTypeListExpanded.value
                    ? const Icon(Icons.arrow_drop_up)
                    : const Icon(Icons.arrow_drop_down),
                readOnly: true,
                onTap: () {
                  controller.isTypeListExpanded.toggle();
                },
              ).paddingOnly(
                  bottom: controller.isTypeListExpanded.value ? 0 : 16.kh),
            ),
            Obx(
              () => Visibility(
                visible: controller.isTypeListExpanded.value,
                child: SizedBox(
                  height: 240.kh,
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.kh),
                          bottomRight: Radius.circular(8.kh)),
                    ),
                    color: ColorUtil.kGreyColor,
                    child: ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.kh,
                                        color: ColorUtil.kNeutral7)),
                                borderRadius: BorderRadius.circular(8.kh)),
                            child: RadioListTile<String>(
                              title: Text(controller.typeList[index]),
                              value: controller.typeList[index],
                              groupValue: controller.type.text,
                              fillColor: WidgetStatePropertyAll(
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary2PinkMode
                                      : ColorUtil.kSecondary01),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.type.text =
                                      controller.typeList[index];
                                  controller.isTypeListExpanded.value = false;
                                  controller.isBtnActive.value = true;
                                }
                              },
                            ),
                          );
                        }),
                  ),
                ).paddingOnly(bottom: 16.kh),
              ),
            ),
            RichTextHeading(text: Strings.color).paddingOnly(bottom: 8.kh),
            Obx(
              () => GreenPoolTextField(
                hintText: Strings.selectVehicleColor,
                controller: controller.color,
                suffix: controller.isColorListExpanded.value
                    ? const Icon(Icons.arrow_drop_up)
                    : const Icon(Icons.arrow_drop_down),
                readOnly: true,
                onTap: () {
                  controller.isColorListExpanded.toggle();
                },
              ).paddingOnly(
                  bottom: controller.isColorListExpanded.value ? 0 : 16.kh),
            ),
            Obx(
              () => Visibility(
                visible: controller.isColorListExpanded.value,
                child: SizedBox(
                  height: 240.kh,
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.kh),
                          bottomRight: Radius.circular(8.kh)),
                    ),
                    color: ColorUtil.kGreyColor,
                    child: ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.kh,
                                        color: ColorUtil.kNeutral7)),
                                borderRadius: BorderRadius.circular(8.kh)),
                            child: RadioListTile<String>(
                              title: Text(controller.colorList[index]),
                              value: controller.colorList[index],
                              groupValue: controller.color.text,
                              fillColor: WidgetStatePropertyAll(
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary2PinkMode
                                      : ColorUtil.kSecondary01),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.color.text =
                                      controller.colorList[index];
                                  controller.isColorListExpanded.value = false;
                                  controller.isBtnActive.value = true;
                                }
                              },
                            ),
                          );
                        }),
                  ),
                ).paddingOnly(bottom: 16.kh),
              ),
            ),
            RichTextHeading(text: Strings.year).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.enterYear,
              controller: controller.yearTextController,
              onchanged: (value) {
                if (value != null) {
                  controller.isBtnActive.value = true;
                }
              },
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen,
                  colorFilter: ColorFilter.mode(
                      Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn)),
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.licensePlate)
                .paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.licensePlate,
              controller: controller.licenseTextController,
              onchanged: (value) {
                if (value != null) {
                  controller.isBtnActive.value = true;
                }
              },
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen,
                  colorFilter: ColorFilter.mode(
                      Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn)),
            ).paddingOnly(bottom: 8.kh),
            RichTextHeading(text: Strings.idVerification)
                .paddingOnly(bottom: 8.kh),
            GestureDetector(
              onTap: () {
                controller.getIDImage(ImageSource.gallery);
              },
              child: Obx(
                () => Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 68.kh, horizontal: 76.kw),
                  decoration: BoxDecoration(
                    color: ColorUtil.kGreyColor,
                    borderRadius: BorderRadius.circular(8.kh),
                  ),
                  child: //if no ID image was uploaded then pick image
                      Get.find<GetStorageService>()
                                  .idVerificationPicUrl
                                  .isEmpty &&
                              !controller.isIDPicUpdated.value
                          ? const UploadIdImage()
                          //if pick was uploaded then show uploaded pic or if new pic is being uploaded then show that
                          : controller.isIDPicUpdated.value == true
                              ? Image.file(
                                  controller.selectedIDImagePath?.value ??
                                      File(''))
                              : CommonImageView(
                                  url: Get.find<GetStorageService>()
                                      .idVerificationPicUrl,
                                ),
                ),
              ),
            ),
            Obx(
              () => GreenPoolButton(
                onPressed: () {
                  controller.updateData();
                },
                label: Strings.save,
                isActive: controller.isBtnActive.value,
                isLoading: controller.btnLoading.value,
              ).paddingSymmetric(vertical: 40.kh),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

class UploadIdImage extends StatelessWidget {
  const UploadIdImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(ImageConstant.svgIconUpload).paddingOnly(right: 8.kw),
        Text(
          Strings.uploadId,
          style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
        ),
      ],
    );
  }
}
