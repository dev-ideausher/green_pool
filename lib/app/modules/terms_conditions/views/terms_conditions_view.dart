import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../controllers/terms_conditions_controller.dart';

class TermsAndConditionsView extends GetView<TermsConditionsController> {
  const TermsAndConditionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  GreenPoolAppBar(
        title: Text(Strings.termsAmbersentConditions),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const GpProgress()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(                      
                      controller.termsText,
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                    ).paddingOnly(top: 32.kh),
                  ],
                ).paddingSymmetric(horizontal: 16.kw),
              ),
      ),
    );
  }
}
