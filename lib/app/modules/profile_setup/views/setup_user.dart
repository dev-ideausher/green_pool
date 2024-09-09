import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/components/upload_id.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/common_image_view.dart';
import '../../../components/upload_add_picture.dart';
import '../../../components/richtext_heading.dart';
import '../controllers/profile_setup_controller.dart';

class SetupUser extends GetView<ProfileSetupController> {
  const SetupUser({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileSetupController());
    return SingleChildScrollView(
      child: Form(
        key: controller.userFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => AddPictureView(
                          onPressedGallery: () {
                            controller.getProfileImage(ImageSource.gallery);
                          },
                          onPressedSelfie: () {
                            controller.getProfileImage(ImageSource.camera);
                          },
                        )),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Obx(
                          () => controller.isProfileImagePicked.value
                              ? Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(44.kh),
                                      child: CommonImageView(
                                        file: controller
                                            .selectedProfileImagePath.value!,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: controller.imageNotUploaded.value
                                          ? Border.all(color: ColorUtil.kError2)
                                          : null),
                                  child: SvgPicture.asset(
                                      ImageConstant.svgSetupProfilePic),
                                ),
                        ),
                        SvgPicture.asset(ImageConstant.svgSetupAdd),
                      ],
                    ).paddingOnly(bottom: 12.kh, top: 32.kh),
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
              hintText: Strings.enterName,
              controller: controller.fullName,
              validator: (value) => controller.nameValidator(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen),
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.emailAddress)
                .paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.emailID,
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => controller.validateEmail(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              suffix: controller.readOnlyEmail
                  ? const SizedBox()
                  : SvgPicture.asset(ImageConstant.svgProfileEditPen),
              readOnly: controller.readOnlyEmail,
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.phoneNumber)
                .paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.enterPhoneNumber,
              prefix: Text(
                "+1",
                style: TextStyleUtil.k14Regular(
                  color: ColorUtil.kBlack03,
                ),
              ),
              controller: controller.phoneNumber,
              validator: (value) => controller.phoneNumberValidator(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              readOnly: !controller.readOnlyEmail,
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.gender).paddingOnly(bottom: 8.kh),
            Obx(
              () => GreenPoolTextField(
                hintText: Strings.selectGender,
                controller: controller.gender,
                validator: (value) => controller.validateGender(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                readOnly: true,
                suffix: controller.isGenderListExpanded.value
                    ? const Icon(Icons.arrow_drop_up)
                    : const Icon(Icons.arrow_drop_down),
                onTap: () {
                  controller.isGenderListExpanded.toggle();
                },
              ).paddingOnly(
                  bottom: controller.isGenderListExpanded.value ? 4.kh : 16.kh),
            ),
            Obx(
              () => Visibility(
                visible: controller.isGenderListExpanded.value,
                child: SizedBox(
                  height: 120.kh,
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.kh),
                    ),
                    color: ColorUtil.kGreyColor,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.genderList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.kh, color: ColorUtil.kNeutral7)),
                              borderRadius: BorderRadius.circular(8.kh)),
                          child: RadioListTile<String>(
                                  title: Text(controller.genderList[index]),
                                  value: controller.genderList[index],
                                  groupValue: controller.gender.text,
                                  fillColor: const WidgetStatePropertyAll(
                                      ColorUtil.kSecondary01),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.gender.text = value;
                                      controller.isGenderListExpanded.value =
                                          false;
                                    }
                                  })
                              .paddingSymmetric(
                                  horizontal: 8.kh, vertical: 4.kh),
                        );
                      },
                    ),
                  ),
                ).paddingOnly(bottom: 16.kh),
              ),
            ),
            RichTextHeading(text: Strings.cityProvince)
                .paddingOnly(bottom: 8.kh),
            Obx(
              () => GreenPoolTextField(
                hintText: Strings.selectCity,
                controller: controller.city,
                validator: (value) => controller.validateCity(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                suffix: controller.isCityListExpanded.value
                    ? const Icon(Icons.arrow_drop_up)
                    : const Icon(Icons.arrow_drop_down),
                onPressedSuffix: () {
                  controller.isCityListExpanded.toggle();
                  controller.addCityNames(controller.city.text);
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
                          padding: EdgeInsets.zero,
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
                                  fillColor: const WidgetStatePropertyAll(
                                      ColorUtil.kSecondary01),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.city.text =
                                          controller.cityNames[index];
                                      controller.isCityListExpanded.value =
                                          false;
                                    }
                                  }),
                            );
                          }),
                    )).paddingOnly(bottom: 16.kh),
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
                    text: '*',
                    style: TextStyleUtil.k14Regular(color: ColorUtil.kError3),
                  ),
                  TextSpan(
                    text: Strings.above18,
                    style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: Strings.selectYourDateOfBirth,
              suffix: SvgPicture.asset(ImageConstant.svgIconCalendar),
              controller: controller.formattedDateOfBirth,
              readOnly: true,
              onTap: () {
                controller.setDate(context);
              },
              validator: (value) => controller.validateDOB(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ).paddingOnly(bottom: 16.kh),
            RichTextHeading(text: Strings.idVerification)
                .paddingOnly(bottom: 8.kh),
            GestureDetector(
              onTap: () => Get.to(() => UploadIDView(
                    onPressedGallery: () {
                      controller.getIDImage(ImageSource.gallery);
                    },
                    onPressedSelfie: () {
                      controller.getIDImage(ImageSource.camera);
                    },
                  )),
              child: Obx(
                () => Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 68.kh, horizontal: 76.kw),
                  decoration: BoxDecoration(
                      border: controller.isIDPicked.value
                          ? null
                          : controller.imageNotUploaded.value
                              ? Border.all(color: ColorUtil.kError2)
                              : null,
                      color: ColorUtil.kGreyColor,
                      borderRadius: BorderRadius.circular(8.kh)),
                  child: controller.isIDPicked.value
                      ? Image.file(
                          controller.selectedIDImagePath.value!,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(ImageConstant.svgIconUpload)
                                .paddingOnly(right: 8.kw),
                            Text(
                              Strings.uploadId,
                              style: TextStyleUtil.k14Regular(
                                  color: ColorUtil.kBlack03),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            GreenPoolButton(
              onPressed: () => controller.checkUserValidations(),
              label: Strings.proceed,
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ),
      ),
    );
  }
}
