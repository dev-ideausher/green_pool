import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../components/richtext_heading.dart';
import '../../../components/upload_vehicle_picture.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../controllers/vehicle_setup_controller.dart';

class VehicleSetupView extends GetView<VehicleSetupController> {
  const VehicleSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.vehicleSetup),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.kw),
        child: SingleChildScrollView(
          child: Form(
            key: controller.vehicleFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichTextHeading(text: Strings.vehiclePhoto)
                    .paddingOnly(top: 32.kh, bottom: 8.kh),
                GestureDetector(
                  onTap: () => Get.to(() => VehiclePictureView(
                        onPressedGallery: () {
                          controller.getVehicleImage(ImageSource.gallery);
                        },
                        onPressedSelfie: () {
                          controller.getVehicleImage(ImageSource.camera);
                        },
                      )),
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 68.kh, horizontal: 76.kw),
                      decoration: BoxDecoration(
                          border: controller.isVehicleImagePicked.value
                              ? null
                              : controller.vehicleImageNotUploaded.value
                                  ? Border.all(color: ColorUtil.kError2)
                                  : null,
                          color: ColorUtil.kGreyColor,
                          borderRadius: BorderRadius.circular(8.kh)),
                      child: controller.isVehicleImagePicked.value
                          ? Image.file(
                              controller.selectedVehicleImagePath.value!,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageConstant.svgIconUpload)
                                    .paddingOnly(right: 8.kw),
                                Text(
                                  Strings.uploadPhoto,
                                  style: TextStyleUtil.k14Regular(
                                      color: ColorUtil.kBlack03),
                                ),
                              ],
                            ),
                    ),
                  ),
                ).paddingOnly(bottom: 16.kh),
                RichTextHeading(text: Strings.model).paddingOnly(bottom: 8.kh),
                GreenPoolTextField(
                  hintText: Strings.enterVehicleModel,
                  controller: controller.model,
                  validator: (p0) => controller.validateModel(p0),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ).paddingOnly(bottom: 16.kh),
                RichTextHeading(text: Strings.type).paddingOnly(bottom: 8.kh),
                Obx(
                  () => GreenPoolTextField(
                    hintText: Strings.selectVehicleType,
                    controller: controller.type,
                    validator: (value) => controller.validateVehicleType(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    suffix: controller.isTypeListExpanded.value
                        ? const Icon(Icons.arrow_drop_up)
                        : const Icon(Icons.arrow_drop_down),
                    readOnly: true,
                    onTap: () {
                      controller.isTypeListExpanded.toggle();
                    },
                  ).paddingOnly(
                      bottom:
                          controller.isTypeListExpanded.value ? 4.kh : 16.kh),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isTypeListExpanded.value,
                    child: SizedBox(
                      height: 120.kh,
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.kh),
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
                                  fillColor: const WidgetStatePropertyAll(
                                      ColorUtil.kSecondary01),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.type.text =
                                          controller.typeList[index];
                                      controller.isTypeListExpanded.value =
                                          false;
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
                    validator: (value) => controller.validateColor(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    suffix: controller.isColorListExpanded.value
                        ? const Icon(Icons.arrow_drop_up)
                        : const Icon(Icons.arrow_drop_down),
                    readOnly: true,
                    onTap: () {
                      controller.isColorListExpanded.toggle();
                    },
                  ).paddingOnly(
                      bottom:
                          controller.isColorListExpanded.value ? 4.kh : 16.kh),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isColorListExpanded.value,
                    child: SizedBox(
                      height: 120.kh,
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.kh),
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
                                  fillColor: const WidgetStatePropertyAll(
                                      ColorUtil.kSecondary01),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.color.text =
                                          controller.colorList[index];
                                      controller.isColorListExpanded.value =
                                          false;
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
                  controller: controller.year,
                  validator: (p0) => controller.validateYear(p0),
                  keyboardType: const TextInputType.numberWithOptions(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ).paddingOnly(bottom: 16.kh),
                RichTextHeading(text: Strings.licensePlate)
                    .paddingOnly(bottom: 8.kh),
                GreenPoolTextField(
                  hintText: Strings.licensePlate,
                  controller: controller.licencePlate,
                  validator: (p0) => controller.validateLicensePlate(p0),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                GreenPoolButton(
                  onPressed: () async =>
                      await controller.checkVehicleValidations(),
                  label: Strings.proceed,
                ).paddingSymmetric(vertical: 40.kh),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
