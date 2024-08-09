import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/services/dio/endpoints.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
                    ..loadRequest(Uri.parse(Endpoints.stripeBankUrl ?? ""))
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setNavigationDelegate(NavigationDelegate(
                      onPageFinished: (url) {
                        // controller.isLoading.value = false;
                      },
                      onUrlChange: (change) async {
                        if (change.url!.startsWith(
                            "https://api.greenpool.ca/v1/payment/stripe/callback?scope=read_write&code=")) {
                          controller.transferToBankAccount(
                              change.url?.split("code=").last ?? "");
                        }
                        /*else {
                          Get.until(
                            (route) => Get.currentRoute == Routes.WALLET,
                          );
                        */
                      },
                    )),
                ),
        ),
      ),
    );
  }
}
