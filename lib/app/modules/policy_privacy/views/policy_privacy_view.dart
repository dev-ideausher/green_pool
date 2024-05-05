import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
      appBar: const GreenPoolAppBar(
        title: Text('Privacy Policy'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const GpProgress()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "Lorem ipsum dolor sit amet consectetur. Lorem viverra rutrum amet pulvinar dictum aliquam vulputate amet lacus. Dui sit ut tortor egestas nibh nullam egestas. Sed bibendum habitasse eget id. Eu malesuada nulla ac vel sollicitudin proin ut. Lacus faucibus morbi placerat nisi curabitur id donec.\n\n\nNetus vitae nunc mauris fringilla. Nibh nisi pellentesque leo diam gravida. Semper massa laoreet tortor at amet lacus lacus turpis tellus. Arcu eu senectus a pellentesque quisque pretium. Sit nisi in tempor posuere urna aliquam. Pulvinar feugiat ac cursus aliquet convallis imperdiet eget natoque. Tellus leo elementum tristique ut mi venenatis dolor lorem. Morbi morbi vel leo donec erat at mi tristique. Ullamcorper nisi ut tellus nibh ornare velit vulputate ipsum id.\n\n\nArcu eu senectus a pellentesque quisque pretium. Sit nisi in tempor posuere urna aliquam. Pulvinar feugiat ac cursus aliquet convallis imperdiet eget natoque. Tellus leo elementum tristique ut mi venenatis dolor lorem. Morbi morbi vel leo donec erat at mi tristique. Ullamcorper nisi ut tellus nibh ornare velit vulputate ipsum id.",
                    controller.policyText,
                    style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                  ).paddingOnly(top: 32.kh),
                ],
              ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}
