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
                      border: controller.vehicleImageNotUploaded.value
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
              validator: (p0) => controller.validateModel(p0),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Type').paddingOnly(bottom: 8.kh),
            GreenPoolDropDown(
              hintText: 'Select vehicle type',
              validator: (p0) => controller.validateVehicleType(p0),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              items: [
                DropdownMenuItem(
                    value: "Hatchback",
                    child: Text(
                      "Hatchback",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Coupe",
                    child: Text(
                      "Coupe",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Convertible",
                    child: Text(
                      "Convertible",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Sedan",
                    child: Text(
                      "Sedan",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "SUV",
                    child: Text(
                      "SUV",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Truck",
                    child: Text(
                      "Truck",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Van",
                    child: Text(
                      "Van",
                      style: TextStyleUtil.k14Regular(),
                    )),
              ],
              onChanged: (val) {
                controller.type.value = val.toString();
              },
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Color').paddingOnly(bottom: 8.kh),
            GreenPoolDropDown(
              hintText: 'Select vehicle color',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (p0) => controller.validateColor(p0),
              items: [
                DropdownMenuItem(
                    value: "Silver",
                    child: Text(
                      "Silver",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Black",
                    child: Text(
                      "Black",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "White",
                    child: Text(
                      "White",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Dark Grey",
                    child: Text(
                      "Dark Grey",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Light Grey",
                    child: Text(
                      "Light Grey",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Red",
                    child: Text(
                      "Red",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Blue",
                    child: Text(
                      "Blue",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Light Blue",
                    child: Text(
                      "Light Blue",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Dark Blue",
                    child: Text(
                      "Dark Blue",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "Brown",
                    child: Text(
                      "Brown",
                      style: TextStyleUtil.k14Regular(),
                    )),
              ],
              onChanged: (val) {
                controller.color.value = val.toString();
              },
            ).paddingOnly(bottom: 16.kh),
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
            GreenPoolButton(
              // onPressed: () async => await controller.vehicleDetailsAPI(),
              onPressed: () async => await controller.checkVehicleValidations(),
              label: 'Proceed',
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ),
      ),
    );
  }
}
