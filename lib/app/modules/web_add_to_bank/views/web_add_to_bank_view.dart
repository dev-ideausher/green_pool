import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/services/dio/endpoints.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../routes/app_pages.dart';
import '../controllers/web_add_to_bank_controller.dart';

class WebAddToBankView extends GetView<WebAddToBankController> {
  const WebAddToBankView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: GreenPoolAppBar(
      //   title: Text(Strings.aboutGp),
      // ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const GpProgress()
              : WebViewWidget(
                  key: key,
                  controller: WebViewController()
                    ..loadRequest(Uri.parse(controller.stripeRedirectUrl ?? ""))
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setNavigationDelegate(NavigationDelegate(
                      onUrlChange: (change) async {
                        if (change.url!.endsWith("onBoardingSuccess") ||
                            change.url!.endsWith(
                                "tab=wallet-details&active=addToBank")) {
                          print(change.url);
                          Get.until(
                              (route) => Get.currentRoute == Routes.WALLET);
                        } else if (change.url!.endsWith("link-expiry")) {
                          Get.until(
                              (route) => Get.currentRoute == Routes.WALLET);
                        }
                      },
                    )),
                ),
        ),
      ),
    );
  }
}
