import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../components/richtext_heading.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/user_details_controller.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  const UserDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.userDetails),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.getProfileImage(ImageSource.gallery);
                    },
                    child: Hero(
                      tag: "profilePic",
                      transitionOnUserGestures: true,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Obx(
                            () => Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child:
                                  controller.isProfilePicUpdated?.value ?? false
                                      ? ClipOval(
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(50.kh),
                                            child: Image.file(controller
                                                    .selectedProfileImagePath
                                                    ?.value ??
                                                File('')),
                                          ),
                                        )
                                      : ClipOval(
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(50.kh),
                                            child: CommonImageView(
                                              height: 50.kh,
                                              width: 50.kw,
                                              url: Get.find<GetStorageService>()
                                                      .profilePicUrl ??
                                                  '',
                                            ),
                                          ),
                                        ),
                            ),
                          ),
                          SvgPicture.asset(
                            Get.find<HomeController>().isPinkModeOn?.value ??
                                    false
                                ? ImageConstant.svgPinkSetupAdd
                                : ImageConstant.svgSetupAdd,
                          ),
                        ],
                      ).paddingOnly(bottom: 12.kh, top: 32.kh),
                    ),
                  ),
                  Text(
                    Strings.takeOrUploadProfilePic,
                    style: TextStyleUtil.k16Regular(color: ColorUtil.kNeutral4),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 40.kh),
            RichTextHeading(text: Strings.fullName).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.fullName,
              controller: controller.nameTextController,
              suffix: SvgPicture.asset(
                ImageConstant.svgProfileEditPen,
                colorFilter: ColorFilter.mode(
                  Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  BlendMode.srcIn,
                ),
              ),
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.emailAddress)
                .paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.emailID,
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailTextController,
              suffix: SvgPicture.asset(
                ImageConstant.svgProfileEditPen,
                colorFilter: ColorFilter.mode(
                  Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  BlendMode.srcIn,
                ),
              ),
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.phoneNumber)
                .paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.phoneNumber,
              controller: controller.phoneTextController,
              prefix: Text(
                "+1",
                style: TextStyleUtil.k14Regular(
                  color: ColorUtil.kBlack03,
                ),
              ),
              readOnly: true,
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.gender).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.gender,
              controller: controller.genderTextController,
              readOnly: true,
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.cityProvince)
                .paddingOnly(bottom: 8.kh),
            Obx(
              () => GreenPoolTextField(
                hintText: Strings.selectCity,
                controller: controller.city,
                suffix: controller.isCityListExpanded.value
                    ? const Icon(Icons.arrow_drop_up)
                    : const Icon(Icons.arrow_drop_down),
                onPressedSuffix: () {
                  controller.isCityListExpanded.toggle();
                  controller.addCityNames("");
                },
                onchanged: (value) {
                  controller.addCityNames(value ?? "");
                },
              ).paddingOnly(
                  bottom: controller.isCityListExpanded.value ? 4.kh : 16.kh),
            ),
            Obx(
              () => Visibility(
                visible: controller.isCityListExpanded.value,
                child: SizedBox(
                  height: controller.cityNames.length == 1
                      ? 70.kh
                      : (controller.cityNames.length * 70.kh)
                          .clamp(70.kh, 120.kh),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.kh),
                    ),
                    color: ColorUtil.kGreyColor,
                    child: ListView.builder(
                        itemCount: controller.cityNames.length ?? 0,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.kh,
                                        color: ColorUtil.kNeutral7)),
                                borderRadius: BorderRadius.circular(8.kh)),
                            child: RadioListTile<String>(
                              title: Text(controller.cityNames[index]),
                              groupValue: controller.city.text,
                              value: controller.cityNames[index],
                              fillColor: WidgetStatePropertyAll(
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary2PinkMode
                                      : ColorUtil.kSecondary01),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.city.text =
                                      controller.cityNames[index];
                                  controller.isCityListExpanded.value = false;
                                }
                              },
                            ),
                          );
                        }),
                  ),
                ).paddingOnly(bottom: 16.kh),
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: Strings.dateOfBirth,
                    style: TextStyleUtil.k14Semibold(),
                  ),
                  TextSpan(
                    text: Strings.above18,
                    style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.dob,
              controller: controller.dobTextController,
              readOnly: true,
            ).paddingOnly(bottom: 16.kh),
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
                  child: controller.isIDPicUpdated?.value == true
                      ? Image.file(
                          controller.selectedIDImagePath?.value ?? File(''))
                      : CommonImageView(
                          url: Get.find<HomeController>()
                                  .userInfo
                                  .value
                                  .data
                                  ?.idPic
                                  ?.url ??
                              '',
                        ),
                ),
              ),
            ),
            Obx(
              () => GreenPoolButton(
                onPressed: () {
                  controller.updateDetailsAPI();
                },
                isLoading: controller.saveBtnLoading.value,
                label: Strings.save,
              ).paddingOnly(top: 40.kh, bottom: 16.kh),
            ),
            GreenPoolButton(
              onPressed: () => controller.deleteAccountAPI(),
              isBorder: true,
              borderColor: ColorUtil.kSecondary01,
              borderWidth: 2.kh,
              label: Strings.deleteAccount,
              labelColor: ColorUtil.kSecondary01,
            ).paddingOnly(bottom: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
