import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../components/socials.dart';
import '../../create_account/controllers/create_account_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateAccountController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
            key: controller.loginKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyleUtil.k32Heading700(),
                ).paddingOnly(top: 48.kh, bottom: 4.kh),
                Text(
                  'Enter your login details',
                  style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
                ).paddingOnly(bottom: 40.kh),
                Text(
                  'Phone Number',
                  style: TextStyleUtil.k14Semibold(),
                ).paddingOnly(bottom: 8.kh),
                GreenPoolTextField(
                  hintText: 'Enter here',
                  controller: controller.phoneNumberController,
                  validator: (value) => controller.phoneNumberValidator(value),
                  onchanged: (v) {},
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: true,
                  prefix: CountryCodePicker(
                    onChanged: (countryCode) {
                      controller.countryCode = countryCode.dialCode ?? "+1";
                    },
                    padding: const EdgeInsets.all(0),
                    initialSelection: 'CA',
                    countryFilter: const ['CA', 'IN'],
                    showFlag: true,
                    searchDecoration: InputDecoration(
                      focusColor: ColorUtil.kNeutral6,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.kh)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.kh)),
                    ),
                  ),
                ).paddingOnly(bottom: 12.kh),
                //

                GreenPoolButton(
                  onPressed: () async {
                    // await controller.otpAuth();
                    await controller.checkLogin();
                  },
                  label: 'Login',
                  // isActive: controller.isActive.value,
                ).paddingSymmetric(vertical: 40.kh),

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
                      'Or  login with',
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
                ).paddingOnly(bottom: 40.kh),
                Socials(
                  onPressedGoogle: () {
                    //TODO: googleAuth
                    controller.googleAuth();
                  },
                ).paddingOnly(bottom: 76.kh),
                const Expanded(child: SizedBox()),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Don\'t have an account? \n',
                            style: TextStyleUtil.k14Regular(
                                color: ColorUtil.kBlack04)),
                        TextSpan(
                          text: 'Create an account',
                          style: TextStyleUtil.k14Regular(
                              color: ColorUtil.kSecondary01),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.offNamed(Routes.CREATE_ACCOUNT,
                                arguments: controller.isDriver),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ).paddingOnly(bottom: 24.kh),
                ),
              ],
            ).paddingSymmetric(horizontal: 16.kw),
          ),
        ));
  }
}
