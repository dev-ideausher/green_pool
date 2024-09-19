import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
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
              : Stack(
                  children: [
                    WebViewWidget(
                      key: key,
                      controller: WebViewController()
                        ..loadRequest(
                            Uri.parse(controller.stripeRedirectUrl ?? ""))
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..setNavigationDelegate(NavigationDelegate(
                          onUrlChange: (change) async {
                            if (change.url!.endsWith("onBoardingSuccess") ||
                                change.url!.endsWith(
                                    "tab=wallet-details&active=addToBank")) {
                              print("CHANGE URL: ${change.url}");
                              Get.until(
                                  (route) => Get.currentRoute == Routes.WALLET);
                            }
                          },
                        )),
                    ),
                    controller.isPageLoaded.value
                        ? Center(
                            child: Container(
                                height: 80.kh,
                                width: 80.kh,
                                decoration: BoxDecoration(
                                  color: ColorUtil.kWhiteColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0.kh),
                                  ),
                                ),
                                padding: EdgeInsets.all(12.kh),
                                child: const GpProgress()),
                          )
                        : const Stack(),
                  ],
                ),
        ),
      ),
    );
  }
}
