import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/components/socials.dart';
import 'package:green_pool/app/modules/create_account/views/terms_view.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../controllers/create_account_controller.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  const CreateAccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.createAccount,
                style: TextStyleUtil.k32Heading700(),
              ).paddingOnly(top: 48.kh),
              Text(
                Strings.enterDetails,
                style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
              ).paddingOnly(bottom: 32.kh),

              //
              Text(
                Strings.fullName,
                style: TextStyleUtil.k14Semibold(),
              ).paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: Strings.enterName,
                controller: controller.fullNameController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z\s]')), // Allow only alphabets and spaces
                ],
                keyboardType: TextInputType.name,
                validator: (value) => controller.nameValidator(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ).paddingOnly(bottom: 12.kh),
              //

              Text(
                Strings.phoneNumber,
                style: TextStyleUtil.k14Semibold(),
              ).paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: Strings.enterHere,
                keyboardType: TextInputType.phone,
                controller: controller.phoneNumberController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]')), // Only allow digits (0-9)
                  FilteringTextInputFormatter.deny(
                      RegExp(r'[^\w\s]')), // Deny all special characters
                ],
                validator: (value) => controller.phoneNumberValidator(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                prefix: CountryCodePicker(
                  onChanged: (countryCode) {
                    controller.countryCode = countryCode.dialCode ?? "+1";
                  },
                  padding: const EdgeInsets.all(0),
                  initialSelection: 'CA',
                  showFlag: true,
                  countryFilter: const ['CA', 'IN', 'US'],
                  searchDecoration: InputDecoration(
                    focusColor: ColorUtil.kNeutral6,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.kh)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.kh)),
                  ),
                ),
                onchanged: (String? value) =>
                    controller.phoneNumberController.text = value!,
              ).paddingOnly(bottom: 12.kh),

              //
              // Text(
              //   'Password',
              //   style: TextStyleUtil.k14Semibold(),
              // ).paddingOnly(bottom: 8.kh),
              // Obx(
              //   ()=> GreenPoolTextField(
              //     hintText: 'Enter password here',
              //     suffix: controller.isVisible.value ? Icon(Icons.visibility, size: 20.kh,color: ColorUtil.kSecondary01,) : Icon(Icons.visibility_off_sharp, size: 20.kh,color: ColorUtil.kSecondary01,),
              //     onPressedSuffix: () {
              //       controller.setVisible();
              //     },
              //     obscureText: !controller.isVisible.value,
              //     controller: controller.passwordTextController,
              //     validator: (value) => controller.passwordValidator(value),
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //   ).paddingOnly(bottom: 12.kh),
              // ),
              //

              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isTermsAccepted.value,
                      activeColor: ColorUtil.kSecondary01,
                      onChanged: (value) {
                        controller.toggleCheckbox();
                      },
                    ),
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.readAndAgree,
                            style: TextStyleUtil.k12Regular(),
                          ),
                          TextSpan(
                              text: Strings.termsCondition,
                              style: TextStyleUtil.k12Semibold(
                                  color: ColorUtil.kSecondary03),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => Get.to(() => const TermsView())),
                          TextSpan(
                            text: Strings.and,
                            style: TextStyleUtil.k12Regular(),
                          ),
                          TextSpan(
                              text: Strings.privacyPolicy,
                              style: TextStyleUtil.k12Semibold(
                                  color: ColorUtil.kSecondary03),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => Get.to(() => const TermsView())),
                        ],
                      ),
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 32.kh),
              Obx(
                () => GreenPoolButton(
                  onPressed: () async {
                    await controller.checkValidation();
                  },
                  isActive: controller.isTermsAccepted.value,
                  label: Strings.signUp,
                ).paddingOnly(bottom: 16.kh),
              ),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: Strings.alreadyHaveAcc,
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kBlack04)),
                      TextSpan(
                          text: Strings.spaceLogin,
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kSecondary01),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => controller.moveToLogin()),
                    ],
                  ),
                ).paddingOnly(bottom: 32.kh),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 1.kh,
                      color: ColorUtil.kNeutral2,
                    ).paddingOnly(right: 8.kw),
                  ),
                  Text(
                    Strings.orSignUpWith,
                    style:
                        TextStyleUtil.k12Semibold(color: ColorUtil.kNeutral3),
                  ),
                  Expanded(
                    child: Container(
                      height: 1.kh,
                      color: ColorUtil.kNeutral2,
                    ).paddingOnly(left: 8.kw),
                  ),
                ],
              ).paddingOnly(bottom: 24.kh),
              Socials(
                onPressedGoogle: () {
                  controller.googleAuth();
                },
                onPressedFacebook: () {
                  controller.facebookAuth();
                },
                onPressedApple: () {
                  controller.appleAuth();
                },
              ).paddingOnly(bottom: 40.kh),
            ],
          ).paddingOnly(left: 16.kw, right: 16.kw),
        ),
      ),
    );
  }
}
