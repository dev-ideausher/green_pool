import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/image_constant.dart';
import '../data/user_info_model.dart';
import '../modules/home/controllers/home_controller.dart';
import 'enigma.dart';
import 'push_notification_service.dart';

class GetStorageService extends GetxService {
  static final _runData = GetStorage('runData');

  static const String _isLogin = 'isLogin';
  static const String _token = 'jwToken';
  static const String _themeMode = 'themeMode';
  static const String _locationsName = 'locationsName';
  static const String _isDriver = 'isDriver';
  static const String _isPinkMode = 'isPinkMode';
  static const String _profileStatus = 'profileStatus';
  static const String _firebaseUid = 'firebaseUid';
  static const String _userName = 'userName';
  static const String _emailId = 'emailId';
  static const String _city = 'city';
  static const String _gender = 'gender';
  static const String _dateOfBirth = 'dateOfBirth';
  static const String _phoneNumber = 'phoneNumber';
  static const String _profilePicUrl = 'profilePicUrl';
  static const String _idVerificationPicUrl = 'idVerificationPicUrl';
  static const String _userAppId = 'userAppId';
  static const String _supportChatRoomId = 'supportChatRoomId';
  static const String _accSuspended = 'accSuspended';
  static const String _hasTappedAllowLocation = 'hasTappedAllowLocation';
  static const String _hasTappedAllowNotification =
      'hasTappedAllowNotification';
  static const String _appLocale = 'appLocale';
  static const String _locationCache = 'locationCache';
  static const String _cancelCounts = 'cancelCounts';
  static const String _cancellationDate = 'cancellationDate';
  static const String _vehicleStatus = 'vehicleStatus';
  static const String _vehicleModel = 'vehicleModel';
  static const String _vehicleYear = 'vehicleYear';
  static const String _licensePlate = 'licensePlate';
  static const String _vehicleType = 'vehicleType';
  static const String _vehicleColor = 'vehicleColor';
  static const String _vehicleImageUrl = 'vehicleImageUrl';
  final String _subscribedToFcmKey = 'hasSubscribedToFCM';

  Future<GetStorageService> initState() async {
    await GetStorage.init('runData');
    intialiseIfNull();
    return this;
  }

  // we are utilisig encrypt class we decrypt once we read and encrypt before write.

  bool get isLoggedIn =>
      _runData.read(_isLogin) ?? false; // 2:follow system 1:dark 0:light
  set isLoggedIn(bool val) => _runData.write(_isLogin, val);

  int get themeMode =>
      _runData.read(_themeMode) ?? 2; // 2:follow system 1:dark 0:light
  set themeMode(int value) => _runData.write(_themeMode, value);

  void intialiseIfNull() {
    _runData.writeIfNull(_themeMode, 0);
  }

  //!
  File? get profilePic =>
      _runData.read('userAppId') ?? File(ImageConstant.svgSetupProfilePic);
  set setProfilePic(File? val) => _runData.write('userAppId', val);
  //!
  String get encjwToken => decryptAESCryptoJS(_runData.read(_token)) ?? '';
  set encjwToken(String val) => _runData.write(_token, encryptAESCryptoJS(val));
  //!

  String get locationsName => _runData.read(_locationsName) ?? '';
  set locationsName(String val) => _runData.write(_locationsName, val);

  bool get isDriver => _runData.read(_isDriver) ?? false;
  set setDriver(bool val) => _runData.write(_isDriver, val);

  bool get isPinkMode => _runData.read(_isPinkMode) ?? false;
  set isPinkMode(bool val) => _runData.write(_isPinkMode, val);

  bool get profileStatus => _runData.read(_profileStatus) ?? false;
  set profileStatus(bool val) => _runData.write(_profileStatus, val);

  String get getFirebaseUid => _runData.read(_firebaseUid) ?? '';
  set setFirebaseUid(String val) => _runData.write(_firebaseUid, val);

  String get getUserName => _runData.read(_userName) ?? '';
  set setUserName(String val) => _runData.write(_userName, val);

  String get emailId => _runData.read(_emailId) ?? '';
  set emailId(String val) => _runData.write(_emailId, val);

  String get city => _runData.read(_city) ?? '';
  set city(String val) => _runData.write(_city, val);

  String get gender => _runData.read(_gender) ?? '';
  set gender(String val) => _runData.write(_gender, val);

  String get dateOfBirth => _runData.read(_dateOfBirth) ?? '';
  set dateOfBirth(String val) => _runData.write(_dateOfBirth, val);

  String get phoneNumber => _runData.read(_phoneNumber) ?? '';
  set phoneNumber(String val) => _runData.write(_phoneNumber, val);

  String get profilePicUrl => _runData.read(_profilePicUrl) ?? '';
  set profilePicUrl(String val) => _runData.write(_profilePicUrl, val);

  String get idVerificationPicUrl => _runData.read(_idVerificationPicUrl) ?? '';
  set idVerificationPicUrl(String val) =>
      _runData.write(_idVerificationPicUrl, val);

  String? get getUserAppId => _runData.read(_userAppId) ?? '';
  set setUserAppId(String? val) => _runData.write(_userAppId, val);

  String get cancellationDate => _runData.read(_cancellationDate) ?? '';
  set cancellationDate(String val) => _runData.write(_cancellationDate, val);

  int get cancelCounts => _runData.read(_cancelCounts) ?? 0;
  set cancelCounts(int val) => _runData.write(_cancelCounts, val);

  bool get vehicleStatus => _runData.read(_vehicleStatus) ?? false;
  set vehicleStatus(bool val) => _runData.write(_vehicleStatus, val);

  String get vehicleModel => _runData.read(_vehicleModel);
  set vehicleModel(String val) => _runData.write(_vehicleModel, val);

  String get vehicleYear => _runData.read(_vehicleYear);
  set vehicleYear(String val) => _runData.write(_vehicleYear, val);

  String get licensePlate => _runData.read(_licensePlate);
  set licensePlate(String val) => _runData.write(_licensePlate, val);

  String get vehicleType => _runData.read(_vehicleType);
  set vehicleType(String val) => _runData.write(_vehicleType, val);

  String get vehicleColor => _runData.read(_vehicleColor);
  set vehicleColor(String val) => _runData.write(_vehicleColor, val);

  String get vehicleImageUrl => _runData.read(_vehicleImageUrl) ?? '';
  set vehicleImageUrl(String val) => _runData.write(_vehicleImageUrl, val);

  String get getSupportChatRoomId => _runData.read(_supportChatRoomId) ?? '';
  set setSupportChatRoomId(String val) =>
      _runData.write(_supportChatRoomId, val);

  bool get accSuspended => _runData.read(_accSuspended) ?? false;
  set accSuspended(bool val) => _runData.write(_accSuspended, val);

  bool get hasTappedAllowLocation =>
      _runData.read(_hasTappedAllowLocation) ?? false;
  set hasTappedAllowLocation(bool val) =>
      _runData.write(_hasTappedAllowLocation, val);

  bool get hasTappedAllowNotification =>
      _runData.read(_hasTappedAllowNotification) ?? false;
  set hasTappedAllowNotification(bool val) =>
      _runData.write(_hasTappedAllowNotification, val);

  Locale get appLocale {
    String? localeString = _runData.read(_appLocale);
    if (localeString != null) {
      List<String> parts = localeString.split('_');
      return Locale(parts[0], parts.length > 1 ? parts[1] : null);
    }
    return const Locale('en', 'US');
  }

  set appLocale(Locale locale) {
    String localeString = '${locale.languageCode}_${locale.countryCode ?? ''}';
    _runData.write(_appLocale, localeString);
    Get.updateLocale(locale);
  }

  // Methods to manage locationCache
  Map<String, List<dynamic>> get locationCache {
    final jsonString = _runData.read(_locationCache) ?? '{}';
    Map<String, dynamic> decoded = jsonDecode(jsonString);
    return decoded
        .map((key, value) => MapEntry(key, List<dynamic>.from(value)));
  }

  set locationCache(Map<String, List<dynamic>> cache) {
    final jsonString = jsonEncode(cache);
    _runData.write(_locationCache, jsonString);
  }

  void addToLocationCache(String placeId, List<dynamic> locationData) {
    final cache = locationCache; // Get the current cache
    cache[placeId] = locationData; // Add new data
    locationCache = cache; // Update the stored cache
  }

  // to save origin, destination, addStop1, addStop2 and display while posting ride
  // Get location data by type
  String? getLocationByType(String locationType) {
    return _runData.read(locationType);
  }

  // Set location data by type
  void setLocationByType(String locationType, String data) {
    _runData.write(locationType, data);
  }

  bool get hasSubscribedToFCM => _runData.read(_subscribedToFcmKey) ?? false;
  set hasSubscribedToFCM(bool val) => _runData.write(_subscribedToFcmKey, val);

  assignLocally(UserInfoModel userInfo) {
    setUserAppId = userInfo.data?.Id;
    setFirebaseUid = userInfo.data?.firebaseUid ?? "";

    profilePicUrl = userInfo.data?.profilePic?.url ?? "";
    setUserName = userInfo.data?.fullName ?? "";
    emailId = userInfo.data?.email ?? "";
    phoneNumber = userInfo.data?.phone ?? "";
    gender = userInfo.data?.gender ?? "";
    city = userInfo.data?.city ?? "";
    dateOfBirth = userInfo.data?.dob ?? "";
    idVerificationPicUrl = userInfo.data?.idPic?.url ?? "";
    isPinkMode = userInfo.data?.pinkMode ?? false;
    setDriver = userInfo.data?.isDriver ?? false;
    cancelCounts = userInfo.data?.rideCancellationDetails?.count ?? 0;
    cancellationDate =
        userInfo.data?.rideCancellationDetails?.cancellationDate ??
            "2024-07-25T13:27:23.879Z";
    vehicleStatus = userInfo.data?.vehicleStatus ?? false;

    if (userInfo.data?.status == "active") {
      accSuspended = false;
    } else {
      accSuspended = true;
    }
  }

  assignVehicleDetails(UserInfoModel userInfo) {
    vehicleModel = userInfo.data?.vehicleDetails?.firstOrNull?.model ?? "";
    vehicleYear =
        userInfo.data?.vehicleDetails?.firstOrNull?.year.toString() ?? "";
    licensePlate =
        userInfo.data?.vehicleDetails?.firstOrNull?.licencePlate ?? "";
    vehicleType = userInfo.data?.vehicleDetails?.firstOrNull?.type ?? "";
    vehicleColor = userInfo.data?.vehicleDetails?.firstOrNull?.color ?? "";
    vehicleImageUrl =
        userInfo.data?.vehicleDetails?.firstOrNull?.vehiclePic?.url ?? "";
  }

  void logout() {
    Get.find<HomeController>().changeTabIndex(0);
    Get.find<HomeController>().reqsCount.value = 0;
    Get.find<HomeController>().totUnreadMsgs.value = 0;

    isLoggedIn = false;
    hasSubscribedToFCM = false;
    PushNotificationService.unsubFcm(getUserAppId!);

    _runData.remove("runData");
    _runData.erase();
    //userInfo.value.data?.emergencyContactDetails = [];
  }
}
