import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/components/richtext_heading.dart';
import 'package:green_pool/app/components/upload_vehicle_picture.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/dropdown_textfield.dart';
import '../controllers/profile_setup_controller.dart';

class SetupVehicle extends GetView<ProfileSetupController> {
  const SetupVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileSetupController());
    return SingleChildScrollView(
      child: Form(
        key: controller.vehicleFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RichTextHeading(text: 'Vehicle Photo')
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
                  padding:
                      EdgeInsets.symmetric(vertical: 68.kh, horizontal: 76.kw),
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
                              'Upload Photo',
                              style: TextStyleUtil.k14Regular(
                                  color: ColorUtil.kBlack03),
                            ),
                          ],
                        ),
                ),
              ),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Model').paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: 'Enter vehicle model',
              controller: controller.model,
              validator: (value) => controller.validateModel(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Type').paddingOnly(bottom: 8.kh),
            Obx(
              () => GreenPoolTextField(
                hintText: "Select Vehicle Type",
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
                  bottom: controller.isTypeListExpanded.value ? 4.kh : 16.kh),
            ),
            Obx(
              () => Visibility(
                visible: controller.isTypeListExpanded.value,
                child: SizedBox(
                  height: 120.kh,
                  child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.kh, color: ColorUtil.kNeutral7)),
                              borderRadius: BorderRadius.circular(8.kh)),
                          child: ListTile(
                            title: Text(controller.typeList[index]),
                            onTap: () {
                              controller.type.text = controller.typeList[index];
                              controller.isTypeListExpanded.value = false;
                            },
                          ),
                        );
                      }),
                ).paddingOnly(bottom: 16.kh),
              ),
            ),
            const RichTextHeading(text: 'Color').paddingOnly(bottom: 8.kh),
            Obx(
              () => GreenPoolTextField(
                hintText: "Select Vehicle Color",
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
                  bottom: controller.isColorListExpanded.value ? 4.kh : 16.kh),
            ),
            Obx(
              () => Visibility(
                visible: controller.isColorListExpanded.value,
                child: SizedBox(
                  height: 120.kh,
                  child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.kh, color: ColorUtil.kNeutral7)),
                              borderRadius: BorderRadius.circular(8.kh)),
                          child: ListTile(
                            title: Text(controller.colorList[index]),
                            onTap: () {
                              controller.color.text =
                                  controller.colorList[index];
                              controller.isColorListExpanded.value = false;
                            },
                          ),
                        );
                      }),
                ).paddingOnly(bottom: 16.kh),
              ),
            ),
            const RichTextHeading(text: 'Year').paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: 'Enter year',
              controller: controller.year,
              validator: (p0) => controller.validateYear(p0),
              keyboardType: const TextInputType.numberWithOptions(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'License Plate')
                .paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: 'License plate',
              controller: controller.licencePlate,
              validator: (p0) => controller.validateLicensePlate(p0),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Obx(
              () => GreenPoolButton(
                onPressed: () {
                  if (controller.userDetailsFilled) {
                    controller.checkVehicleValidations();
                  } else {
                    controller.tabBarController.index = 0;
                    showMySnackbar(msg: "Please fill in user details");
                  }
                },
                label: 'Proceed',
                isLoading: controller.isVehicleBtnLoading.value,
              ).paddingSymmetric(vertical: 40.kh),
            ),
          ],
        ),
      ),
    );
  }
}
