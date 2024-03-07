import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/dropdown_textfield.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../components/richtext_heading.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/vehicle_details_controller.dart';

class VehicleDetailsView extends GetView<VehicleDetailsController> {
  const VehicleDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Vehicle Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RichTextHeading(text: 'Vehicle Photo')
                .paddingOnly(top: 32.kh, bottom: 8.kh),
            GestureDetector(
              // onTap: () => Get.to(const VehiclePictureView()),
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 68.kh, horizontal: 76.kw),
                  decoration: BoxDecoration(
                      color: ColorUtil.kGreyColor,
                      borderRadius: BorderRadius.circular(8.kh)),
                  child: Image(
                      image: NetworkImage(
                          "${Get.find<ProfileController>().userInfo.value.data?.vehicleDetails?[0]!.vehiclePic!.url}"))),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Model').paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Get.find<ProfileController>()
                      .userInfo
                      .value
                      .data
                      ?.vehicleDetails?[0]
                      ?.model ??
                  'Enter Vehicle model',
              readOnly: true,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen,
                  colorFilter: ColorFilter.mode(
                      Get.find<ProfileController>().isSwitched.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn)),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Type').paddingOnly(bottom: 8.kh),
            GreenPoolDropDown(
              hintText: Get.find<ProfileController>()
                      .userInfo
                      .value
                      .data
                      ?.vehicleDetails?[0]
                      ?.type ??
                  'Select vehicle type',
              items: [
                DropdownMenuItem(
                    value: "1",
                    child: Text(
                      "Hatchback",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "2",
                    child: Text(
                      "Coupe",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "3",
                    child: Text(
                      "Convertible",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "4",
                    child: Text(
                      "Sedan",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "5",
                    child: Text(
                      "SUV",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "6",
                    child: Text(
                      "Truck",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "7",
                    child: Text(
                      "Van",
                      style: TextStyleUtil.k14Regular(),
                    )),
              ],
              onChanged: (v) {},
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Color').paddingOnly(bottom: 8.kh),
            GreenPoolDropDown(
              hintText: Get.find<ProfileController>()
                      .userInfo
                      .value
                      .data
                      ?.vehicleDetails?[0]
                      ?.color ??
                  'Select car color',
              items: [
                DropdownMenuItem(
                    value: "1",
                    child: Text(
                      "Silver",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "2",
                    child: Text(
                      "Black",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "3",
                    child: Text(
                      "White",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "4",
                    child: Text(
                      "Dark Grey",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "5",
                    child: Text(
                      "Light Grey",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "6",
                    child: Text(
                      "Red",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "7",
                    child: Text(
                      "Blue",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "8",
                    child: Text(
                      "Light Blue",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "9",
                    child: Text(
                      "Dark Blue",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "10",
                    child: Text(
                      "Brown",
                      style: TextStyleUtil.k14Regular(),
                    )),
              ],
              onChanged: (v) {},
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Year').paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Get.find<ProfileController>()
                      .userInfo
                      .value
                      .data
                      ?.vehicleDetails?[0]
                      ?.year
                      .toString() ??
                  'Enter year',
              readOnly: true,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen,
                  colorFilter: ColorFilter.mode(
                      Get.find<ProfileController>().isSwitched.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn)),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'License Plate')
                .paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Get.find<ProfileController>()
                      .userInfo
                      .value
                      .data
                      ?.vehicleDetails?[0]
                      ?.licencePlate ??
                  'License plate',
              readOnly: true,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen,
                  colorFilter: ColorFilter.mode(
                      Get.find<ProfileController>().isSwitched.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn)),
            ),
            GreenPoolButton(
              onPressed: () => Get.back(),
              label: 'Save',
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
