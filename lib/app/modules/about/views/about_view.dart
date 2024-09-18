import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: GreenPoolAppBar(
      //   title: Text(Strings.aboutGp),
      // ),
      body: SafeArea(
        child: WebViewWidget(
            key: key,
            controller: WebViewController()
              ..loadRequest(Uri.parse("https://carpooll.com/aboutus" ?? ""))
              ..setJavaScriptMode(JavaScriptMode.unrestricted)),
      ),
    );
  }
}
