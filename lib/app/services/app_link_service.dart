import 'dart:developer';

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

  /// Initialize deep links and listen for incoming URIs
  Future<void> initDeepLinks() async {
    try {
      // Get the initial link when the app is launched (cold start)
      _latestUri = await _appLinks.getInitialLink();
      if (_latestUri != null) {
        handleIncomingDeepLink(_latestUri!);
      }

      // Listen for new links while the app is running (warm start or background)
      _appLinks.uriLinkStream.listen((Uri? uri) {
        log('Deep link received: $uri');
        if (uri != null) {
          handleIncomingDeepLink(uri);
        }
      }, onError: (err) {
        debugPrint('Error listening for deep links: $err');
      });
    } catch (e) {
      debugPrint('Failed to initialize deep links: $e');
    }
  }

  /// Handle incoming deep link and navigate using GetX with parameters
  void handleIncomingDeepLink(Uri uri) async {
    // Prevent immediate duplicate processing (e.g., during cold start + background resume)
    /*if (_latestUri == uri) {
      debugPrint(
          'Skipping duplicate deep link detected within a short time: $uri');
      return;
    }*/

    // Set the latest URI temporarily
    _latestUri = uri;
    debugPrint('Processing deep link: $uri');

    // ✅ Check if user is logged in before proceeding
    if (!Get.find<GetStorageService>().isLoggedIn) {
      debugPrint('User not logged in. Redirecting to onboarding page.');
      Get.offAllNamed(Routes.ONBOARDING);
      showMySnackbar(msg: LocaleKeys.app_pleaseLoginOrSignUp.tr);
      clearLatestUriAfterDelay();
      return;
    }

    // Extract 'data' parameter from the URL
    final Map<String, String> decodedData = uri.queryParameters;
    final String? data = decodedData['data'];
    final String? rideId = decodedData['rideId'];

    if (data != null) {
      switch (data) {
        case "chats":
          debugPrint('Navigating to MESSAGES with data: $data');
          Get.find<HomeController>().changeTabIndex(2);
          break;

        case "booking":
          //also fetch driverId or userId to match with the stored app id and navigate acoordingly
          debugPrint('Navigating to MY_RIDES_DETAILS with data: $data');
          debugPrint('Navigating to MY_RIDES_DETAILS with bookingId: $rideId');
          Get.toNamed(Routes.RIDE_INVITE_SCREEN,
              arguments: {"driverRideId": rideId ?? ""});
          break;

        default:
          debugPrint('Unknown type in deep link. Redirecting to MAIN_PAGE.');
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
          break;
      }
    } else {
      debugPrint(
          'Missing or invalid data parameter. Redirecting to MAIN_PAGE.');
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
    }

    // Clear the latest URI after navigation is handled to allow new clicks
    clearLatestUriAfterDelay();
  }

// ✅ Clear URI after a short delay to prevent blocking legitimate clicks
  void clearLatestUriAfterDelay() {
    Future.delayed(const Duration(seconds: 1), () {
      _latestUri = null;
    });
  }
}
