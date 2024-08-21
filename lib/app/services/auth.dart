// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'snackbar.dart';
import 'storage.dart';
import 'dart:developer';
import 'dialog_helper.dart';

class AuthService extends GetxService {
  final _facebookLogin = FacebookAuth.instance;
  AuthCredential? _pendingCredential;
  final auth = FirebaseAuthenticationService();
  final _firebaseAuth = FirebaseAuth.instance;

  // google() async {
  //   //TODO: do the required setup mentioned in https://pub.dev/packages/google_sign_in
  //   final result = await auth.signInWithGoogle().then((value) async {
  //     await handleGetContact();
  //   });

  //   print('Google : ${await result.user?.getIdToken()}');
  // }
  Future<bool> google() async {
    DialogHelper.showLoading();
    bool status = false;
    await auth.signInWithGoogle().then((value) async {
      if (!value.hasError) {
        await handleGetContact();

        print("display name: ${_firebaseAuth.currentUser?.displayName}");
        print("user phone number: ${_firebaseAuth.currentUser?.phoneNumber}");
        print("user email: ${_firebaseAuth.currentUser?.email}");

        status = true;
      } else {
        showMySnackbar(msg: value.errorMessage!);
      }
    });
    DialogHelper.hideDialog();
    return status;
  }

  apple() async {
    //TODO: do the required setup mentioned in https://pub.dev/packages/sign_in_with_apple
    final result = await auth
        .signInWithApple(
            //TODO: add your own handler id from firebase console
            appleRedirectUri:
                'https://stacked-firebase-auth-test.firebaseapp.com/__/auth/handler',
            appleClientId: '')
        .then((value) async {
      await handleGetContact();
    });
    Get.find<GetStorageService>().setUserName = result.user?.fullName;
    print('Apple : ${await result.user?.getIdToken()}');
  }

  loginEmailPass({required String email, required String pass}) async {
    final result = await auth
        .loginWithEmail(email: email, password: pass)
        .then((value) async {
      await handleGetContact();
    });
    print('EmailPass : ${await result.user?.getIdToken()}');
  }

  createEmailPass({required String email, required String pass}) async {
    final result = await auth
        .createAccountWithEmail(email: email, password: pass)
        .then((value) async {
      await handleGetContact();
    });
    print('EmailPass : ${await result.user?.getIdToken()}');
  }

//phone number with country code

  mobileOtp({required String phoneno}) async {
    await auth.requestVerificationCode(
      phoneNumber: phoneno,
      timeout: const Duration(seconds: 120),
      onCodeSent: (verificationID) => print('verificationId: $verificationID'),
    );
  }

  Future<bool> verifyMobileOtp({required String otp}) async {
    // DialogHelper.showLoading();
    bool status = false;
    Completer<bool> completer = Completer<bool>();

    try {
      await auth.authenticateWithOtp(otp).then((value) async {
        if (!value.hasError) {
          await handleGetContact();
          status = true;
          completer.complete(status);
          // print('Mobile Otp : ${await value.user?.getIdToken()}');
        } else {
          showMySnackbar(msg: value.errorMessage!);
        }
      });
    } catch (error) {
      showMySnackbar(
          msg:
              "Verification Error: Unable to verify your mobile number. Please try again");
      // showMySnackbar(msg: error.toString());
      completer.completeError(error);
    }

    // DialogHelper.hideDialog();
    return status;
  }

  facebook() async {
    //TODO: do the required setup mentioned in https://pub.dev/packages/flutter_facebook_auth
    final result = await signInWithFacebook().then((value) async {
      await handleGetContact();
    });
    print('Facebook : ${await result.user?.getIdToken()}');
  }

  Future<FirebaseAuthenticationResult> signInWithFacebook() async {
    try {
      LoginResult fbLogin = await _facebookLogin.login();
      // log?.v('Facebook Sign In complete. \naccessToken:${accessToken.token}');

      final OAuthCredential facebookCredentials =
          FacebookAuthProvider.credential(fbLogin.accessToken!.token);

      var result =
          await _firebaseAuth.signInWithCredential(facebookCredentials);

      // Link the pending credential with the existing account
      if (_pendingCredential != null) {
        await result.user?.linkWithCredential(_pendingCredential!);
      }

      return FirebaseAuthenticationResult(user: result.user);
    } catch (e) {
      // log?.e(e);
      return FirebaseAuthenticationResult.error(errorMessage: e.toString());
    }
  }

  Future<void> handleGetContact() async {
    final mytoken = await _firebaseAuth.currentUser!.getIdToken(true);
    final fireUid = _firebaseAuth.currentUser!.uid;
    final userName = _firebaseAuth.currentUser?.displayName;
    // final userPhoneNumber = _firebaseAuth.currentUser?.phoneNumber;
    final userEmail = _firebaseAuth.currentUser?.email;

    // Get.find<GetStorageService>().isLoggedIn = true;
    Get.find<GetStorageService>().encjwToken = mytoken!;
    Get.find<GetStorageService>().setFirebaseUid = fireUid;
    Get.find<GetStorageService>().setUserName = userName ?? "";
    Get.find<GetStorageService>().emailId = userEmail ?? "";
    log(Get.find<GetStorageService>().encjwToken);
    debugPrint('i am user id${Get.find<GetStorageService>().getFirebaseUid}');
  }

  Future<void> logOutUser() async {
    DialogHelper.showLoading();
    // erase the user's token and data in GetStorageService
    Get.find<GetStorageService>().logout();
    Get.find<GetStorageService>().isLoggedIn = false;
    // firbase logout
    auth.logout();
    // navigate to login page
    // await Get.offAll(Routes.ONBOARDING);
    await DialogHelper.hideDialog();
  }
}
