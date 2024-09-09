import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/rider_profile_setup/views/rider_review_pic.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth.dart';
import '../../../services/colors.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../../services/storage.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;

import 'city_list.dart';

class RiderProfileSetupController extends GetxController {
  RxBool isPicked = false.obs;
  RxBool isBtnLoading = false.obs;
  bool fromNavBar = false;
  bool readOnlyEmail = false;
  RxList<String> cityNames = <String>[].obs;
  Rx<File?> selectedProfileImagePath = Rx<File?>(null);
  Rx<File?> selectedIDImagePath = Rx<File?>(null);
  RxBool isProfileImagePicked = false.obs;
  RxBool isProfileImagePickedCheck = false.obs;
  RxBool isIDPicked = false.obs;
  RxBool isIDPickedCheck = false.obs;
  TextEditingController fullName = TextEditingController(
      text: Get.find<AuthService>().auth.currentUser?.displayName);
  TextEditingController email = TextEditingController(
      text: Get.find<AuthService>().auth.currentUser?.email);
  TextEditingController phoneNumber = TextEditingController(
      text: Get.find<GetStorageService>()
              .phoneNumber
              .toString()
              .split("+1")
              .last ??
          "");
  TextEditingController gender = TextEditingController();
  RxBool isGenderListExpanded = false.obs;
  RxList<String> genderList =
      <String>["Male", "Female", "Prefer not to say"].obs;

  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController formattedDateOfBirth = TextEditingController();
  TextEditingController city = TextEditingController();
  RxBool isCityListExpanded = false.obs;

  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();

  final Rx<FindRideModel> findRideModel = FindRideModel().obs;

  @override
  void onInit() {
    super.onInit();
    try {
      fromNavBar = Get.arguments['fromNavBar'];
      findRideModel.value = Get.arguments['findRideModel'];
      fullName.text = Get.arguments['fullName'];
    } catch (e) {
      fromNavBar = Get.arguments['fromNavBar'];
      fullName.text = Get.arguments['fullName'];
    }
    if (Get.find<GetStorageService>().emailId != "") {
      readOnlyEmail = true;
    } else {
      readOnlyEmail = false;
    }
  }

  // void updateSelectedCity(String city) {
  //   selectedCity.value = city;
  // }

  Future<void> setDate(BuildContext context) async {
    DateTime lastDate = DateTime.now()
        .subtract(const Duration(days: 18 * 365)); // Subtracting 18 years

    DateTime initialDate =
        DateTime.now().isAfter(lastDate) ? lastDate : DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: lastDate,
      initialDate: initialDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Define the custom theme for the date picker
          data: ThemeData(
            // Define the primary color
            primaryColor: Get.find<HomeController>().isPinkModeOn.value
                ? ColorUtil.kPrimaryPinkMode
                : ColorUtil.kPrimary01,
            // Define the color scheme for the date picker
            colorScheme: ColorScheme.light(
              // Define the primary color for the date picker
              primary: Get.find<HomeController>().isPinkModeOn.value
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01,
              // Define the background color for the date picker
              surface: ColorUtil.kWhiteColor,
              // Define the on-primary color for the date picker
              onPrimary: ColorUtil.kBlack01,
              secondary: Get.find<HomeController>().isPinkModeOn.value
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01,
            ),
          ),
          // Apply the custom theme to the child widget
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = pickedDate.toString().split(" ")[0];
      dateOfBirth.text = formattedDate;
      formattedDateOfBirth.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  getProfileImage(ImageSource imageSource) async {
    XFile? pickedFile = await GpUtil.compressImage(imageSource);
    if (pickedFile != null) {
      selectedProfileImagePath.value = File(pickedFile.path);
      update();
      Get.to(() => RiderReviewPictureView(
            imagePath: selectedProfileImagePath.value!,
          ));
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  getIDImage(ImageSource imageSource) async {
    XFile? pickedIDFile = await GpUtil.compressImage(imageSource);

    if (pickedIDFile != null) {
      selectedIDImagePath.value = File(pickedIDFile.path);
      isIDPicked.value = true;
      Get.back();
      update();
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  //
  Future<void> userDetailsAPI() async {
    isBtnLoading.value = true;
    final storageService = Get.find<GetStorageService>();
    final File pickedImageFile = File(selectedProfileImagePath.value!.path);
    final File pickedIDFile = File(selectedIDImagePath.value!.path);
    String extension = pickedImageFile.path.split('.').last;
    String mediaType;

    if (extension == 'jpg' || extension == 'jpeg') {
      mediaType = 'image/jpeg';
    } else if (extension == 'png') {
      mediaType = 'image/png';
    } else {
      mediaType = 'application/octet-stream';
    }
    String genderValue = "";
    if (gender.text == "Prefer not to say") {
      genderValue = "Other";
    } else {
      genderValue = gender.value.text;
    }

    final userData = dio.FormData.fromMap({
      'fullName': fullName.text,
      'email': email.text,
      'phone': phoneNumber.text,
      'gender': genderValue,
      'city': city.value.text,
      'dob': dateOfBirth.text,
      'profilePic': await dio.MultipartFile.fromFile(
        pickedImageFile.path,
        contentType: MediaType.parse(mediaType),
        filename: path.basename(pickedImageFile.path),
      ),
      'idPic': await dio.MultipartFile.fromFile(
        pickedIDFile.path,
        contentType: MediaType.parse(mediaType),
        filename: path.basename(pickedIDFile.path),
      ),
    });
    log("profile setup user data: $userData");

    try {
      final response = await APIManager.userDetails(body: userData);
      if (response.data['status'] == true) {
        storageService.setUserName = fullName.text;
        storageService.isLoggedIn = true;
        storageService.profileStatus = true;
        Get.offNamed(Routes.EMERGENCY_CONTACTS,
            arguments: {'fromNavBar': fromNavBar, 'isDriver': false},
            parameters: {"profileType": "user"});
        showMySnackbar(msg: "Data saved succesfully.");
        isBtnLoading.value = false;
        Get.find<HomeController>().userInfoAPI();
      } else {
        showMySnackbar(msg: response.data['message'].toString());
        await checkUserValidations();
        isBtnLoading.value = false;
      }
    } catch (e) {
      isBtnLoading.value = false;
      throw Exception(e);
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? nameValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    // Check if the value contains only letters (and optionally spaces)
    final RegExp nameExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter a valid name';
    }

    return null; // Return null if the value is valid
  }

  String? phoneNumberValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Check if the value contains exactly 10 digits
    final RegExp phoneExp = RegExp(r'^[0-9]{10}$');
    if (!phoneExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }

    return null; // Return null if the value is valid
  }

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your city';
    }
    return null;
  }

  String? validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your Date of birth';
    }
    return null;
  }

  checkUserValidations() async {
    final isValid = userFormKey.currentState!.validate();

    if (!isValid) {
      isProfileImagePickedCheck.value = true;
      isIDPickedCheck.value = true;
      return showMySnackbar(msg: 'Please fill in all the details');
    } else {
      if (isProfileImagePicked.value != true || isIDPicked.value != true) {
        isProfileImagePickedCheck.value = true;
        isIDPickedCheck.value = true;
        return showMySnackbar(msg: 'Please upload the required images');
      } else {
        userFormKey.currentState!.save();
        await userDetailsAPI();
      }
    }
  }

  void addCityNames(String value) {
    if (value.isEmpty || value == "") {
      cityNames.value = CityList.cityNames;
    } else {
      isCityListExpanded.value = true;
      cityNames.value = CityList.cityNames.where((city) {
        return city.toLowerCase().contains(value.toLowerCase());
      }).toList();
    }
  }
}
