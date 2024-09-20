import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        () => controller.isLoad.value
            ? const GpProgress()
            : SafeArea(
                child: Stack(
                  children: [
                    WebViewWidget(
                      key: key,
                      controller: WebViewController()
                        ..loadRequest(Uri.parse(
                            "https://web-carpooll.vercel.app/privacy-policy" ??
                                ""))
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..setNavigationDelegate(NavigationDelegate(
                            onPageFinished: (url) {
                              controller.isLoading.value = false;
                            },
                            onUrlChange: (change) async {})),
                    ),
                    controller.isLoading.value
                        ? const GpProgress()
                        : const Stack(),
                  ],
                ),
              ),
      ),
    );
  }
}
