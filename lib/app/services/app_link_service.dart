import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    if (_latestUri == uri) {
      debugPrint(
          'Skipping duplicate deep link detected within a short time: $uri');
      return;
    }

    // Set the latest URI temporarily
    _latestUri = uri;
    debugPrint('Processing deep link: $uri');

    // ✅ Check if user is logged in before proceeding
    if (!Get.find<GetStorageService>().isLoggedIn) {
      debugPrint('User not logged in. Redirecting to onboarding page.');
      Get.offAllNamed(Routes.ONBOARDING);
      clearLatestUriAfterDelay();
      return;
    }

    // Extract 'data' parameter from the URL
    final String? data = uri.queryParameters['data'];

    if (data != null) {
      switch (data) {
        case "chats":
          debugPrint('Navigating to MESSAGES with data: $data');
          Get.toNamed(Routes.POST_RIDE_STEP_ONE);
          break;

        case "booking":
          debugPrint(
              'Navigating to BOOKING_DETAILS_PAGE with bookingId: $data');
          Get.toNamed(Routes.POST_RIDE_STEP_ONE);
          // Get.toNamed(
          //   Routes.BOOKING_DETAILS_PAGE,
          //   arguments: BookingDetailArgModel(Id: id),
          // );
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
