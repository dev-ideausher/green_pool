import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/storage.dart';

import '../routes/app_pages.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();

    // Add a delay before checking the initial connectivity status
    Future.delayed(const Duration(seconds: 2), _checkInitialConnectivity);

    // Listen for subsequent connectivity changes
    _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  void _checkInitialConnectivity() async {
    try {
      var connectivityResult = await _connectivity.checkConnectivity();
      _updateConnectivityStatus(connectivityResult);
    } catch (e) {
      debugPrint("Error checking initial connectivity: $e");
    }
  }

  void _updateConnectivityStatus(List<ConnectivityResult> connectivityResult) {
    debugPrint('Connectivity changed: $connectivityResult');
    if (Get.context == null) {
      return;
    }

    if (connectivityResult.first == ConnectivityResult.none) {
      _showConnectionDialog();
    } else {
      _dismissDialog();
    }
  }

  void _showConnectionDialog() {
    if (!(Get.isDialogOpen ?? false)) {
      showCupertinoDialog<bool>(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          title: Text("Sorry"),
          content: Text("Check your internet connection and try again."),
          actions: _buildDialogActions(),
        ),
      );
    }
  }

  List<Widget> _buildDialogActions() {
    return [
      _buildCancelButton(),
      _buildRetryButton(),
    ];
  }

  Widget _buildCancelButton() {
    return CupertinoButton(
      child: Text(
        "Cancel",
        textAlign: TextAlign.center,
      ),
      onPressed: () => Get.back(),
    );
  }

  Widget _buildRetryButton() {
    return CupertinoButton(
      child: Text(
        "Retry",
        textAlign: TextAlign.center,
      ),
      onPressed: () {
        if (Get.find<GetStorageService>().isLoggedIn) {
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        } else {
          Get.back();
        }
      },
    );
  }

  void _dismissDialog() {
    if ((Get.isDialogOpen ?? false)) {
      Get.back();
    }
  }
}
