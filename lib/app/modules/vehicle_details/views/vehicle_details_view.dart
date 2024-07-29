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
            RichTextHeading(text: Strings.vehiclePhoto)
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
            RichTextHeading(text: Strings.model).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.enterVehicleModel,
              controller: controller.modelTextController,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen,
                  colorFilter: ColorFilter.mode(
                      Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn)),
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.type).paddingOnly(bottom: 8.kh),
            GreenPoolDropDown(
              hintText: '${controller.vehicleInfoModel?.type}',
              color: ColorUtil.kBlack01,
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
              onChanged: (v) {
                controller.vehicletypeValue.value = v.toString();
              },
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.color).paddingOnly(bottom: 8.kh),
            GreenPoolDropDown(
              hintText: '${controller.vehicleInfoModel?.color}',
              color: ColorUtil.kBlack01,
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
              onChanged: (v) {
                controller.colorValue.value = v.toString();
              },
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.year).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.enterYear,
              controller: controller.yearTextController,
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
              label: Strings.save,
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
