import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/dropdown_textfield.dart';
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
    print(controller.isProfileImagePickedCheck.value);
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
                'Profile Setup',
                style: TextStyleUtil.k32Heading700(),
              ).paddingOnly(bottom: 4.kh, top: 16.kh),
              Text(
                'Edit your profile details',
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
                                        child: Image.file(
                                          controller
                                              .selectedProfileImagePath.value!,
                                        ),
                                      ),
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
                      'Take or upload profile photo',
                      style:
                          TextStyleUtil.k16Regular(color: ColorUtil.kNeutral4),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 40.kh),
              const RichTextHeading(text: 'Full Name')
                  .paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: 'Enter name',
                controller: controller.fullName,
                validator: (value) => controller.nameValidator(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen),
              ).paddingOnly(bottom: 16.kh),
              const RichTextHeading(text: 'Email Address')
                  .paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: 'Enter Email ID',
                controller: controller.email,
                validator: (value) => controller.validateEmail(value),
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                suffix: controller.readOnlyEmail
                    ? const SizedBox()
                    : SvgPicture.asset(ImageConstant.svgProfileEditPen),
                readOnly: controller.readOnlyEmail,
              ).paddingOnly(bottom: 16.kh),
              const RichTextHeading(text: 'Phone Number')
                  .paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: 'Enter phone number',
                controller: controller.phoneNumber,
                prefix: Text(
                    "+1",
                    style: TextStyleUtil.k14Regular(
                      color: ColorUtil.kBlack03,
                    ),
                  ),
                validator: (value) => controller.phoneNumberValidator(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ).paddingOnly(bottom: 16.kh),
              const RichTextHeading(text: 'Gender').paddingOnly(bottom: 8.kh),
              GreenPoolDropDown(
                hintText: 'Select your Gender',
                validator: (value) => controller.validateGender(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                items: [
                  DropdownMenuItem(
                      value: "Male",
                      child: Text(
                        "Male",
                        style: TextStyleUtil.k14Regular(),
                      )),
                  DropdownMenuItem(
                      value: "Female",
                      child: Text(
                        "Female",
                        style: TextStyleUtil.k14Regular(),
                      )),
                  DropdownMenuItem(
                      value: "Prefer not to say",
                      child: Text(
                        "Prefer not to say",
                        style: TextStyleUtil.k14Regular(),
                      )),
                ],
                onChanged: (val) {
                  controller.gender.text = val.toString();
                },
              ).paddingOnly(bottom: 16.kh),
              const RichTextHeading(text: 'City Province')
                  .paddingOnly(bottom: 8.kh),
              Obx(
                () => GreenPoolTextField(
                  hintText: "Select your City",
                  controller: controller.city,
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
                      text: 'Date of Birth ',
                      style: TextStyleUtil.k14Semibold(),
                    ),
                    TextSpan(
                      text: '*',
                      style: TextStyleUtil.k14Regular(color: ColorUtil.kError3),
                    ),
                    TextSpan(
                      text: '(should be above 18)',
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: 'Enter date of birth',
                controller: controller.formattedDateOfBirth,
                readOnly: true,
                validator: (value) => controller.validateDOB(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onTap: () => controller.setDate(context),
                suffix: SvgPicture.asset(ImageConstant.svgIconCalendar),
              ).paddingOnly(bottom: 16.kh),
              const RichTextHeading(text: 'ID Verification')
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
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 68.kh, horizontal: 76.kw),
                  decoration: BoxDecoration(
                      color: ColorUtil.kGreyColor,
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
                                'Upload ID',
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
                color: ColorUtil.kPrimary01,
                label: 'Proceed',
              ).paddingSymmetric(vertical: 40.kh),
            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ),
      ),
    );
  }
}
