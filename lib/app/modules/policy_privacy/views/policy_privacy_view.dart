import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/gp_progress.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/policy_privacy_controller.dart';

class PolicyPrivacyView extends GetView<PolicyPrivacyController> {
  const PolicyPrivacyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.privacyPolicy),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const GpProgress()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(                    
                    controller.policyText,
                    style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                  ).paddingOnly(top: 32.kh),
                ],
              ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
