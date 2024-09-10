import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/image_constant.dart';
import 'enigma.dart';

class GetStorageService extends GetxService {
  static final _runData = GetStorage('runData');

  Future<GetStorageService> initState() async {
    await GetStorage.init('runData');
    intialiseIfNull();
    return this;
  }

  // we are utilisig encrypt class we decrypt once we read and encrypt before write.

  bool get isLoggedIn =>
      _runData.read('isLogin') ?? false; // 2:follow system 1:dark 0:light
  set isLoggedIn(bool val) => _runData.write('isLogin', val);

  int get themeMode =>
      _runData.read('themeMode') ?? 2; // 2:follow system 1:dark 0:light
  set themeMode(int value) => _runData.write('themeMode', value);

  void intialiseIfNull() {
    _runData.writeIfNull('themeMode', 0);
  }

  // RxList<List<dynamic>> locations = <List<dynamic>>[].obs;

  String get locationsName => _runData.read('locationsName') ?? '';
  set locationsName(String val) => _runData.write('locationsName', val);

  bool get isDriver => _runData.read('isDriver') ?? false;
  set setDriver(bool val) => _runData.write('isDriver', val);

  bool get isPinkMode => _runData.read('isPinkMode') ?? false;
  set isPinkMode(bool val) => _runData.write('isPinkMode', val);

  bool get profileStatus => _runData.read('profileStatus') ?? false;
  set profileStatus(bool val) => _runData.write('profileStatus', val);

  String get getFirebaseUid => _runData.read('firebaseUid') ?? '';
  set setFirebaseUid(String val) => _runData.write('firebaseUid', val);

  String get getUserName => _runData.read('userName') ?? '';
  set setUserName(String val) => _runData.write('userName', val);

  String get emailId => _runData.read('emailId') ?? '';
  set emailId(String val) => _runData.write('emailId', val);

  String get city => _runData.read('city') ?? '';
  set city(String val) => _runData.write('city', val);

  String get gender => _runData.read('gender') ?? '';
  set gender(String val) => _runData.write('gender', val);

  String get dateOfBirth => _runData.read('dateOfBirth') ?? '';
  set dateOfBirth(String val) => _runData.write('dateOfBirth', val);

  String get phoneNumber => _runData.read('phoneNumber') ?? '';
  set phoneNumber(String val) => _runData.write('phoneNumber', val);

  String get profilePicUrl => _runData.read('profilePicUrl') ?? '';
  set profilePicUrl(String val) => _runData.write('profilePicUrl', val);

  String get idVerificationPicUrl =>
      _runData.read('idVerificationPicUrl') ?? '';
  set idVerificationPicUrl(String val) =>
      _runData.write('idVerificationPicUrl', val);

  String? get getUserAppId => _runData.read('userAppId') ?? '';
  set setUserAppId(String? val) => _runData.write('userAppId', val);

  String get getSupportChatRoomId => _runData.read('supportChatRoomId') ?? '';
  set setSupportChatRoomId(String val) =>
      _runData.write('supportChatRoomId', val);

  bool get accSuspended => _runData.read('accSuspended') ?? false;
  set accSuspended(bool val) => _runData.write('accSuspended', val);

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
