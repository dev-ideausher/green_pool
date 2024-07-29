import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/dropdown_textfield.dart';
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
                GreenPoolDropDown(
                  hintText: Strings.selectVehicletype,                  
                  validator: (p0) => controller.validateVehicleType(p0),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: [
                    DropdownMenuItem(
                        value: Strings.hatchBack,
                        child: Text(
                          Strings.hatchBack,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.coupe,
                        child: Text(
                          Strings.coupe,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.convertible,
                        child: Text(
                          Strings.convertible,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.sedan,
                        child: Text(
                          Strings.sedan,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.SUV,
                        child: Text(
                          Strings.SUV,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.truck,
                        child: Text(
                          Strings.truck,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.van,
                        child: Text(
                          Strings.van,
                          style: TextStyleUtil.k14Regular(),
                        )),
                  ],
                  onChanged: (val) {
                    controller.type.value = val.toString();
                  },
                ).paddingOnly(bottom: 16.kh),
                RichTextHeading(text: Strings.color).paddingOnly(bottom: 8.kh),
                GreenPoolDropDown(
                  hintText: Strings.selectVehicleColor,                  
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (p0) => controller.validateColor(p0),
                  items: [
                    DropdownMenuItem(
                        value: Strings.silver,
                        child: Text(
                          Strings.silver,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.black,
                        child: Text(
                          Strings.black,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.white,
                        child: Text(
                          Strings.white,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.darkgrey,
                        child: Text(
                          Strings.darkgrey,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.lightGrey,
                        child: Text(
                          Strings.lightGrey,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.red,
                        child: Text(
                          Strings.red,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.blue,
                        child: Text(
                          Strings.blue,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.lightBlue,
                        child: Text(
                          Strings.lightBlue,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.darkBlue,
                        child: Text(
                          Strings.darkBlue,
                          style: TextStyleUtil.k14Regular(),
                        )),
                    DropdownMenuItem(
                        value: Strings.brown,
                        child: Text(
                          Strings.brown,
                          style: TextStyleUtil.k14Regular(),
                        )),
                  ],
                  onChanged: (val) {
                    controller.color.value = val.toString();
                  },
                ).paddingOnly(bottom: 16.kh),
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
                  // onPressed: () async => await controller.vehicleDetailsAPI(),
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
