import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/components/upload_id.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/dropdown_textfield.dart';
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
                                      child: Image.file(
                                        controller
                                            .selectedProfileImagePath.value!,
                                      ),
                                    ),
                                  ),
                                )
                              : SvgPicture.asset(
                                  ImageConstant.svgSetupProfilePic),
                        ),
                        SvgPicture.asset(ImageConstant.svgSetupAdd),
                      ],
                    ).paddingOnly(bottom: 12.kh, top: 32.kh),
                  ),
                  Text(
                    'Take or upload profile photo',
                    style: TextStyleUtil.k16Regular(color: ColorUtil.kNeutral4),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 40.kh),
            const RichTextHeading(text: 'Full Name'),
            GreenPoolTextField(
              hintText: 'Enter name',
              controller: controller.fullName,
              validator: (value) => controller.nameValidator(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Email Address'),
            GreenPoolTextField(
              hintText: 'Email ID',
              controller: controller.email,
              validator: (value) => controller.validateEmail(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Phone Number'),
            GreenPoolTextField(
              hintText: 'Enter phone number',
              // initialValue: FirebaseAuth.instance.currentUser?.phoneNumber.toString(),
              controller: controller.phoneNumber,
              validator: (value) => controller.phoneNumberValidator(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Gender'),
            GreenPoolDropDown(
              hintText: 'Select your Gender',
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
              onChanged: (value) {
                controller.gender.text = value.toString();
              },
              validator: (value) => controller.validateGender(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'City Province'),
            GreenPoolTextField(
              //TODO: Drop down city
              hintText: 'Select your city',
              controller: controller.city,
              validator: (value) => controller.validateCity(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ).paddingOnly(bottom: 16.kh),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Date of Birth ',
                    style: TextStyleUtil.k14Semibold(),
                  ),
                  TextSpan(
                    text: '(should be above 18)',
                    style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(
              hintText: 'Select your date of birth',
              suffix: SvgPicture.asset(ImageConstant.svgIconCalendar),
              controller: controller.formattedDateOfBirth,
              readOnly: true,
              onTap: () {
                controller.setDate(context);
              },
              validator: (value) => controller.validateDOB(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'ID Verification'),
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
              label: 'Proceed',
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ),
      ),
    );
  }
}
