import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/terms_conditions_controller.dart';

class TermsAndConditionsView extends GetView<TermsConditionsController> {
  const TermsAndConditionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.termsAmbersentConditions),
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
                            "https://carpooll.com/terms-conditions" ??
                                ""))
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..setNavigationDelegate(NavigationDelegate(
                          onPageFinished: (url) {
                            controller.isLoading.value = false;
                          },
                          onUrlChange: (change) async {},
                        )),
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
