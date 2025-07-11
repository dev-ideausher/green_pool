import 'dart:developer';
/*
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/snackbar.dart';
import '../../generated/locales.g.dart';
import '../modules/home/controllers/home_controller.dart';
import '../routes/app_pages.dart';
import 'storage.dart';

class AppLinkService {
  static final AppLinkService _instance = AppLinkService._internal();

  factory AppLinkService() => _instance;

  AppLinkService._internal();

  final AppLinks _appLinks = AppLinks();
  Uri? _latestUri;

  Future<void> initDeepLinks() async {
    try {
      _latestUri = await _appLinks.getInitialLink();
      if (_latestUri != null) {
        handleIncomingDeepLink(_latestUri!);
      }

      _appLinks.uriLinkStream.listen((Uri? uri) {
        log('Deep link received: $uri');
        if (uri != null) {
          _latestUri = uri;
          handleIncomingDeepLink(uri);
        }
      }, onError: (err) {
        debugPrint('Error listening for deep links: $err');
      });
    } catch (e) {
      debugPrint('Failed to initialize deep links: $e');
    }
  }

  void handleIncomingDeepLink(Uri uri) {
    _latestUri = uri;
    debugPrint('Processing deep link: $uri');

    if (!Get.find<GetStorageService>().isLoggedIn) {
      if ((_latestUri?.host ?? "").contains("carpooll.com")) {
        debugPrint('User not logged in. Redirecting to onboarding page.');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAllNamed(Routes.ONBOARDING);
          showMySnackbar(msg: LocaleKeys.app_pleaseLoginOrSignUp.tr);
        });
      }
      _latestUri = null;
      return;
    }

    final Map<String, String> decodedData = uri.queryParameters;
    final String? data = decodedData['data'];
    final String? rideId = decodedData['rideId'];

    if (data != null) {
      switch (data) {
        case "chats":
          debugPrint('Navigating to MESSAGES with data: $data');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.find<HomeController>().changeTabIndex(2);
          });
          break;

        case "booking":
          debugPrint('Navigating to MY_RIDES_DETAILS with data: $data');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.toNamed(Routes.RIDE_INVITE_SCREEN, arguments: {
              "driverRideId": rideId ?? "",
            });
          });
          break;

        default:
          debugPrint('Unknown type in deep link. Redirecting to MAIN_PAGE.');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
          });
          break;
      }
    } else {
      debugPrint('Missing or invalid data parameter. Redirecting to MAIN_PAGE.');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      });
    }

    _latestUri = null;
  }
}
*/
