import 'dart:io';

import 'package:get/get.dart';
import 'package:green_pool/app/services/gp_new_version.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'colors.dart';
import 'text_style_util.dart';

///Note:  it will work only if app is released in all contries for particular country additional config is required
mixin class Versionk {
  bool checkedUpdates = false;

  Future<void> handleNewUpdate() async {
    checkedUpdates = false;
    try {
      final newVersion = CarpoollNewVersion(
        // forceAppVersion: kDebugMode ? '10.0.0' : null,
        iOSId: 'com.iu.greenPool',
        androidId: 'com.iu.green_pool',
        // forceAppVersion: '4.0.2'
      );
      final status = await newVersion.getVersionStatus();

      if (status != null) {
        if (int.parse(status.localVersion.split('.')[0]) <
                int.parse(status.storeVersion.split('.')[0]) &&
            status.canUpdate) {
          showUpdateDialog(
              isMandatory: true,
              localver: status.localVersion,
              storever: status.storeVersion,
              releaseNote: status.releaseNotes ?? '',
              appStoreLink: status.appStoreLink);
        } else if (status.canUpdate) {
          showUpdateDialog(
              isMandatory: false,
              localver: status.localVersion,
              storever: status.storeVersion,
              releaseNote: status.releaseNotes ?? '',
              appStoreLink: status.appStoreLink);
          //minor update
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showUpdateDialog(
      {String title = ' New Update!',
      String? localver = '',
      String? storever = '',
      bool isMandatory = true,
      String releaseNote = '',
      required String appStoreLink}) {
    hideDialog();
    Get.defaultDialog(
      titlePadding: EdgeInsets.only(top: 16.kh),
      title: title,
      content: Padding(
        padding: EdgeInsets.only(left: 8.0.kw, right: 8.0.kw, top: 8.0.kw),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /*Lottie.asset(
              'assets/lottiefiles/inAppUpdate.json',
              width: 100.w,
              height: 100,
              fit: BoxFit.fill,
            ),*/
            Text(
              'Yay! there is new update from $localver to $storever',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.kh),
            Text(
              isMandatory ? 'Please update now!' : 'Would you like to update?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.kh),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Release Note:',
                style: TextStyleUtil.k14Regular(
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                releaseNote,
                textAlign: TextAlign.left,
              ),
            ),
            10.kheightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isMandatory
                    ? const SizedBox()
                    : MaterialButton(
                        onPressed: () {
                          hideDialog();
                        },
                        child: const Text(
                          'Later',
                          style: TextStyle(
                            color: ColorUtil.kBlack01,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                ElevatedButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(appStoreLink));
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      ColorUtil.kSecondary01,
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12.kh,
                        ),
                        side: BorderSide(
                          color: Get.find<GetStorageService>().isPinkMode
                              ? ColorUtil.kPrimary3PinkMode
                              : ColorUtil.kSecondary01,
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Update Now',
                    style: TextStyle(
                      color: ColorUtil.kWhiteColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierDismissible: false,
      radius: 10.0,
    );
  }

  //hide loading
  static Future<void> hideDialog() async {
    if (Get.isDialogOpen!) Get.until((route) => !Get.isDialogOpen!);
  }
}
