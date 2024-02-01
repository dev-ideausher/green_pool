import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'enigma.dart';

class GetStorageService extends GetxService {
  static final _runData = GetStorage('runData');

  Future<GetStorageService> initState() async {
    await GetStorage.init('runData');
    return this;
  }

  // we are utilisig encrypt class we decrypt once we read and encrypt before write.

  bool get getLoggedIn =>
      _runData.read('isLogin') ?? false; // 2:follow system 1:dark 0:light
  set setLoggedIn(bool val) => _runData.write('isLogin', val);

  bool get isDriver => _runData.read('isDriver') ?? false;
  set setDriver(bool val) => _runData.write('isDriver', val);

  String get getFirebaseUid => _runData.read('firebaseUid') ?? '';
  set setFirebaseUid(String val) => _runData.write('firebaseUid', val);

  String get encjwToken => decryptAESCryptoJS(_runData.read('jwToken')) ?? '';
  set encjwToken(String val) => _runData.write('jwToken', encryptAESCryptoJS(val));

  void logout() {
    _runData.erase();
  }
}
