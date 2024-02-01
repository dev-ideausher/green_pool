import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
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
    Get.lazyPut(()=>RiderProfileSetupController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: SvgPicture.asset(ImageConstant.svgIconBack30),
            ).paddingOnly(top: 16.kh, bottom: 8.kh),
            Text(
              'Add Picture',
              style: TextStyleUtil.k32Heading700(),
            ).paddingOnly(bottom: 4.kh),
            Text(
              'Edit your profile details',
              style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
            ).paddingOnly(bottom: 40.kh),
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(AddPictureView(
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
                        () => controller.isPicked.value
                                     ?Container(
                        decoration: const BoxDecoration(
                        shape: BoxShape.circle,),
                        child: ClipOval(
                        child: SizedBox.fromSize(
                        size: Size.fromRadius(44.kh),
                        child: Image.file(File(controller.selectedProfileImagePath.value),
                                    ),
                    ),
                 ),
                ) : SvgPicture.asset(
                             ImageConstant.svgSetupProfilePic
                            
                            ),
                            
                           
                      ),
                        SvgPicture.asset(ImageConstant.svgSetupAdd),
                      ],
                    ).paddingOnly(bottom: 12.kh),
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
              hintText: 'NAME',
              controller: controller.fullName,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Email Address'),
            GreenPoolTextField(
              hintText: 'Email Id',
              controller: controller.email,
              suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Phone Number'),
             GreenPoolTextField(
              hintText: 'Enter phone number',
              controller: controller.phoneNumber,
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'Gender'),
            GreenPoolDropDown(
              hintText: 'Select your Gender',
              
              items: [
                DropdownMenuItem(
                    value: "1",
                    child: Text(
                      "Male",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "2",
                    child: Text(
                      "Female",
                      style: TextStyleUtil.k14Regular(),
                    )),
                DropdownMenuItem(
                    value: "3",
                    child: Text(
                      "Prefer not to say",
                      style: TextStyleUtil.k14Regular(),
                    )),
              ],
              onChanged: (val) {

              },
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'City Province'),
             GreenPoolTextField(
              //TODO: drop down city
              hintText: 'City',
              controller: controller.city,
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
              //TODO: calender
              hintText: 'D.O.B',
              controller: controller.dateOfBirth,
              suffix: SvgPicture.asset(ImageConstant.svgIconCalendar),
            ).paddingOnly(bottom: 16.kh),
            const RichTextHeading(text: 'ID Verification'),
            GestureDetector(
              onTap: () => Get.to(UploadIDView(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageConstant.svgIconUpload)
                        .paddingOnly(right: 8.kw),
                    Text(
                      'Upload Photo',
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ),
                  ],
                ),
              ),
            ),
            GreenPoolButton(
              onPressed: () => Get.offNamed(Routes.MATCHING_RIDES),
              // onPressed:()=> controller.userDetailsAPI(),
              color: ColorUtil.kPrimary01,
              label: 'Proceed',
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
