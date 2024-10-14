import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../components/gp_progress.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../res/strings.dart';
import '../controllers/policy_cancellation_controller.dart';

class PolicyCancellationView extends GetView<PolicyCancellationController> {
  const PolicyCancellationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.driverCancellationPolicy),
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
                            "https://carpooll.com/cancellation-policy" ??
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
