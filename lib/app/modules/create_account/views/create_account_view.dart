import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/components/socials.dart';
import 'package:green_pool/app/modules/create_account/views/terms_view.dart';
import 'package:green_pool/app/routes/app_pages.dart';
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
                'Create an account',
                style: TextStyleUtil.k32Heading700(),
              ).paddingOnly(top: 48.kh),
              Text(
                'Enter your details ',
                style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
              ).paddingOnly(bottom: 32.kh),

              //
              Text(
                'Full Name',
                style: TextStyleUtil.k14Semibold(),
              ).paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: 'Enter name',
                controller: controller.fullNameController,
                validator: (value) => controller.nameValidator(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ).paddingOnly(bottom: 12.kh),
              //

              Text(
                'Phone Number',
                style: TextStyleUtil.k14Semibold(),
              ).paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: 'Enter here',
                controller: controller.phoneNumberController,
                validator: (value) => controller.phoneNumberValidator(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                prefix: CountryCodePicker(
                  onChanged: (countryCode) {
                    controller.countryCode = countryCode.dialCode ?? "+1";
                  },
                  padding: const EdgeInsets.all(0),
                  initialSelection: 'CA',
                  showFlag: true,
                  countryFilter: const ['CA', 'IN'],
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

              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isChecked.value,
                      activeColor: ColorUtil.kPrimary01,
                      onChanged: (value) {
                        controller.toggleCheckbox();
                      },
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'I have read and I agree to Green Pool\'s ',
                          style: TextStyleUtil.k12Regular(),
                        ),
                        TextSpan(
                            text: 'Terms and \nconditions',
                            style: TextStyleUtil.k12Semibold(
                                color: ColorUtil.kSecondary03),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(const TermsView())),
                        TextSpan(
                          text: ' and ',
                          style: TextStyleUtil.k12Regular(),
                        ),
                        TextSpan(
                          text: 'Privacy policy',
                          style: TextStyleUtil.k12Semibold(
                              color: ColorUtil.kSecondary03),
                        ),
                      ],
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 32.kh),
              Obx(
                () => GreenPoolButton(
                  onPressed: () async {
                    // await controller.otpAuth();
                    await controller.checkValidation();
                  },
                  isActive: controller.isChecked.value,
                  label: 'Sign Up',
                ).paddingOnly(bottom: 16.kh),
              ),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Already have an account ?',
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kBlack04)),
                      TextSpan(
                          text: ' Login',
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kSecondary01),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.offNamed(Routes.LOGIN,
                                arguments: controller.isDriver)),
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
                    'Or  sign up  with',
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
                onPressedGoogle: () => controller.googleAuth(),
              ).paddingOnly(bottom: 40.kh),
            ],
          ).paddingOnly(left: 16.kw, right: 16.kw),
        ),
      ),
    );
  }
}
