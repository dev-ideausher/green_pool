import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/routes/app_pages.dart';

import '../../../services/dio/endpoints.dart';
import '../controllers/web_add_pay_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebAddPayView extends GetView<WebAddPayController> {
  const WebAddPayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            controller.addAmountModel.value.url ?? ""))
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..setNavigationDelegate(NavigationDelegate(
                          onPageFinished: (url) {
                            controller.isLoading.value = false;
                          },
                          onUrlChange: (change) async {
                            if (change.url!.endsWith("paymentSuccess") ||
                                change.url!.endsWith(
                                    "profile-settings?tab=wallet-details")) {
                              Get.until(
                                (route) => Get.currentRoute == Routes.WALLET,
                              );
                            } else if (change.url!
                                .startsWith("paymentCancelled")) {
                              Get.until(
                                (route) => Get.currentRoute == Routes.WALLET,
                              );
                            }
                          },
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
