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
import '../../../components/upload_id.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../../components/upload_add_picture.dart';
import '../controllers/rider_profile_setup_controller.dart';

class RiderProfileSetupView extends GetView<RiderProfileSetupController> {
  const RiderProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RiderProfileSetupController());
    return Scaffold(
      appBar: GreenPoolAppBar(
        leading: const SizedBox(),
        appBarSize: 8.kh,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.userFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.profileSetup,
                style: TextStyleUtil.k32Heading700(),
              ).paddingOnly(bottom: 4.kh, top: 16.kh),
              Text(
                Strings.editProfileDetails,
                style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
              ).paddingOnly(bottom: 40.kh),
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
                            () => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: controller.isProfileImagePickedCheck
                                                .value &&
                                            (controller.selectedProfileImagePath
                                                        .value?.path ??
                                                    "")
                                                .isEmpty
                                        ? Colors.red
                                        : Colors.transparent,
                                    style: BorderStyle.solid),
                              ),
                              child: controller.isProfileImagePicked.value
                                  ? ClipOval(
                                      child: SizedBox.fromSize(
                                          size: Size.fromRadius(44.kh),
                                          child: CommonImageView(
                                            file: controller
                                                .selectedProfileImagePath
                                                .value!,
                                          )),
                                    )
                                  : SvgPicture.asset(
                                      ImageConstant.svgSetupProfilePic),
                            ),
                          ),
                          SvgPicture.asset(ImageConstant.svgSetupAdd),
                        ],
                      ).paddingOnly(bottom: 12.kh),
                    ),
                    Text(
                      Strings.takeOrUploadProfilePic,
                      style:
                          TextStyleUtil.k16Regular(color: ColorUtil.kNeutral4),
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
                hintText: Strings.enterEmailId,
                controller: controller.email,
                validator: (value) => controller.validateEmail(value),
                keyboardType: TextInputType.emailAddress,
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
                controller: controller.phoneNumber,
                prefix: Text(
                  "+1",
                  style: TextStyleUtil.k14Regular(
                    color: ColorUtil.kBlack03,
                  ),
                ),
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
                  // onPressedSuffix: () {
                  //   controller.isGenderListExpanded.toggle();
                  // },
                  onTap: () {
                    controller.isGenderListExpanded.toggle();
                  },
                ).paddingOnly(
                    bottom:
                        controller.isGenderListExpanded.value ? 4.kh : 16.kh),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isGenderListExpanded.value,
                  child: SizedBox(
                    height: 120.kh,
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.kh,
                                        color: ColorUtil.kNeutral7)),
                                borderRadius: BorderRadius.circular(8.kh)),
                            child: ListTile(
                              title: Text(controller.genderList[index]),
                              onTap: () {
                                controller.gender.text =
                                    controller.genderList[index];
                                controller.isGenderListExpanded.value = false;
                              },
                            ),
                          );
                        }),
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
                    controller.addCityNames(controller.city.value.text);
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
                    height: 120.kh,
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
                            child: ListTile(
                              title: Text(controller.cityNames[index]),
                              selectedColor: ColorUtil.kPrimary01,
                              onTap: () {
                                controller.city.text =
                                    controller.cityNames[index];
                                controller.isCityListExpanded.value = false;
                              },
                            ),
                          );
                        }),
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
                      text: '*',
                      style: TextStyleUtil.k14Regular(color: ColorUtil.kError3),
                    ),
                    TextSpan(
                      text: Strings.above18,
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: Strings.enterDateOfBirth,
                controller: controller.formattedDateOfBirth,
                readOnly: true,
                validator: (value) => controller.validateDOB(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onTap: () => controller.setDate(context),
                suffix: SvgPicture.asset(ImageConstant.svgIconCalendar),
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
                    padding: EdgeInsets.symmetric(
                        vertical: 68.kh, horizontal: 76.kw),
                    decoration: BoxDecoration(
                        color: ColorUtil.kGreyColor,
                        border: Border.all(
                          color: controller.isIDPickedCheck.value &&
                                  (controller.selectedIDImagePath.value?.path ??
                                          "")
                                      .isEmpty
                              ? Colors.red
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(8.kh)),
                    child: Obx(
                      () => controller.isIDPicked.value
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
              ),
              Obx(
                () => GreenPoolButton(
                  onPressed: () => controller.checkUserValidations(),
                  label: Strings.proceed,
                  isLoading: controller.isBtnLoading.value,
                ).paddingSymmetric(vertical: 40.kh),
              ),
            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ),
      ),
    );
  }
}
