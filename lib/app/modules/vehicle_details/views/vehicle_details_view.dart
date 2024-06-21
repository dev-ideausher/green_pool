import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/dropdown_textfield.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../components/richtext_heading.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
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
            const RichTextHeading(text: 'Vehicle Photo')
                .paddingOnly(top: 32.kh, bottom: 8.kh),
            GestureDetector(
              onTap: () {
                controller.getProfileImage(ImageSource.gallery);
              },
              child: Obx(() => Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 68.kh, horizontal: 76.kw),
                  decoration: BoxDecoration(
                      color: ColorUtil.kGreyColor,
                      borderRadius: BorderRadius.circular(8.kh)),
                  child: controller.isVehiclePicUpdated?.value == true
                      ? Image.file(controller.selectedVehicleImagePath?.value ??
                          File(''))
                      : CommonImageView(
                          url:
                              "${controller.vehicleInfoModel!.vehiclePic!.url}"))),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Model').paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: 'Enter Vehicle model',
              controller: controller.modelTextController,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen,
                  colorFilter: ColorFilter.mode(
                      Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn)),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Type').paddingOnly(bottom: 8.kh),
            GreenPoolDropDown(
              hintText: '${controller.vehicleInfoModel?.type}',
              color: ColorUtil.kBlack01,
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
              onChanged: (v) {
                controller.vehicletypeValue.value = v.toString();
              },
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Color').paddingOnly(bottom: 8.kh),
            GreenPoolDropDown(
              hintText: '${controller.vehicleInfoModel?.color}',
              color: ColorUtil.kBlack01,
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
              onChanged: (v) {
                controller.colorValue.value = v.toString();
              },
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Year').paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: 'Enter year',
              controller: controller.yearTextController,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen,
                  colorFilter: ColorFilter.mode(
                      Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn)),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'License Plate')
                .paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: 'License plate',
              controller: controller.licenseTextController,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen,
                  colorFilter: ColorFilter.mode(
                      Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn)),
            ),
            GreenPoolButton(
              onPressed: () {
                controller.updateVehicleDetailsAPI();
              },
              label: 'Save',
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
