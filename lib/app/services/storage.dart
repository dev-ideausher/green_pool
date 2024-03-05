import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:green_pool/app/modules/profile/controllers/profile_controller.dart';

import '../constants/image_constant.dart';
import 'enigma.dart';

class GetStorageService extends GetxService {
  static final _runData = GetStorage('runData');

  Future<GetStorageService> initState() async {
    await GetStorage.init('runData');
    intialiseIfNull();
    // Get.put(ProfileController());
    // Get.find<GetStorageService>().isPinkMode = isPinkMode;
    return this;
  }

  // we are utilisig encrypt class we decrypt once we read and encrypt before write.

  bool get getLoggedIn =>
      _runData.read('isLogin') ?? false; // 2:follow system 1:dark 0:light
  set setLoggedIn(bool val) => _runData.write('isLogin', val);

  int get themeMode =>
      _runData.read('themeMode') ?? 2; // 2:follow system 1:dark 0:light
  set themeMode(int value) => _runData.write('themeMode', value);

  void intialiseIfNull() {
    _runData.writeIfNull('themeMode', 0);
  }

  bool get isDriver => _runData.read('isDriver') ?? false;
  set setDriver(bool val) => _runData.write('isDriver', val);

  bool get isPinkMode => _runData.read('isPinkMode') ?? false;
  set isPinkMode(bool val) => _runData.write('isPinkMode', val);

  bool get profileStatus => _runData.read('profileStatus') ?? false;
  set setProfileStatus(bool val) => _runData.write('profileStatus', val);

  bool get isFemale => _runData.read('isFemale') ?? false;
  set setFemale(bool val) => _runData.write('isFemale', val);

  String get getFirebaseUid => _runData.read('firebaseUid') ?? '';
  set setFirebaseUid(String val) => _runData.write('firebaseUid', val);

  String? get getUserName => _runData.read('userName') ?? '';
  set setUserName(String? val) => _runData.write('userName', val);

  String? get getUserAppId => _runData.read('userAppId') ?? '';
  set setUserAppId(String? val) => _runData.write('userAppId', val);

//!
  File? get profilePic =>
      _runData.read('userAppId') ?? File(ImageConstant.svgSetupProfilePic);
  set setProfilePic(File? val) => _runData.write('userAppId', val);
//!
  String get encjwToken => decryptAESCryptoJS(_runData.read('jwToken')) ?? '';
  set encjwToken(String val) =>
      _runData.write('jwToken', encryptAESCryptoJS(val));

  void logout() {
    _runData.erase();
  }
}
