import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/post_ride/controllers/post_ride_controller.dart';
import 'package:green_pool/app/modules/profile_setup/views/review_picture.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;
import '../../../services/auth.dart';
import '../../../services/dio/api_service.dart';

class ProfileSetupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final pageIndex = 0.obs;
  String name = '';
  Rx<File?> selectedProfileImagePath = Rx<File?>(null);
  Rx<File?> selectedIDImagePath = Rx<File?>(null);
  Rx<File?> selectedVehicleImagePath = Rx<File?>(null);
  RxBool isProfileImagePicked = false.obs;
  RxBool isIDPicked = false.obs;
  RxBool isVehicleImagePicked = false.obs;
  TextEditingController fullName = TextEditingController(
      text: Get.find<AuthService>().auth.currentUser?.displayName);
  TextEditingController email = TextEditingController(
      text: Get.find<AuthService>().auth.currentUser?.email);
  TextEditingController phoneNumber = TextEditingController(
      text: Get.find<AuthService>().auth.currentUser?.phoneNumber);
  // TextEditingController gender = TextEditingController();
  RxString gender = 'Prefer not to say'.obs;
  TextEditingController city = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController formattedDateOfBirth = TextEditingController();
  late TabController tabBarController;

  //for vehicle
  TextEditingController model = TextEditingController();
  // TextEditingController color = TextEditingController();
  // TextEditingController type = TextEditingController();
  RxString color = "Silver".obs;
  RxString type = "Sedan".obs;
  TextEditingController year = TextEditingController();
  TextEditingController licencePlate = TextEditingController();

  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> vehicleFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => PostRideController());
    tabBarController = TabController(length: 2, vsync: this);
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
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
    );

    if (pickedDate != null) {
      String formattedDate = pickedDate.toString().split(" ")[0];
      dateOfBirth.text = formattedDate;
      formattedDateOfBirth.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  getProfileImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedProfileImagePath.value = File(pickedFile.path);
      update();
      Get.to(() => ReviewPictureView(
            imagePath: selectedProfileImagePath.value!,
          ));
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  getIDImage(ImageSource imageSource) async {
    final pickedIDFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedIDFile != null) {
      selectedIDImagePath.value = File(pickedIDFile.path);
      isIDPicked.value = true;
      Get.back();
      update();
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  getVehicleImage(ImageSource imageSource) async {
    final pickedVehicleFile =
        await ImagePicker().pickImage(source: imageSource);
    if (pickedVehicleFile != null) {
      selectedVehicleImagePath.value = File(pickedVehicleFile.path);
      isVehicleImagePicked.value = true;
      Get.back();
      update();
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  Future<void> userDetailsAPI() async {
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

    final userData = dio.FormData.fromMap({
      'fullName': fullName.text,
      'email': email.text,
      'phone': phoneNumber.text,
      'gender': gender.value,
      'city': city.text,
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

    //TODO: how can i save full name to display
    try {
      final responses = await APIManager.userDetails(body: userData);
      showMySnackbar(msg: responses.data['message']);
      Get.find<GetStorageService>().setUserName = fullName.text;
      Get.find<GetStorageService>().setProfileStatus = true;
      tabBarController.index = 1;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> vehicleDetailsAPI() async {
    final File pickedVehicleFile = File(selectedVehicleImagePath.value!.path);
    String extension = pickedVehicleFile.path.split('.').last;
    String mediaType;

    if (extension == 'jpg' || extension == 'jpeg') {
      mediaType = 'image/jpeg';
    } else if (extension == 'png') {
      mediaType = 'image/png';
    } else {
      mediaType = 'application/octet-stream';
    }

    final vehicleData = dio.FormData.fromMap({
      'driverId': Get.find<GetStorageService>().getUserAppId,
      'model': model.text,
      'type': type.value,
      'color': color.value,
      'year': year.text,
      'licencePlate': licencePlate.text,
      'vehiclePic': await dio.MultipartFile.fromFile(
        pickedVehicleFile.path,
        contentType: MediaType.parse(mediaType),
        filename: path.basename(pickedVehicleFile.path),
      )
    });

    if (Get.find<GetStorageService>().profileStatus == true) {
      try {
        await APIManager.postVehicleDetails(body: vehicleData);
        showMySnackbar(msg: "Data filled successfully");
        Get.find<HomeController>().userInfoAPI();
        // Get.offNamed(Routes.CARPOOL_SCHEDULE, arguments: isDriver);
        Get.until((route) => Get.currentRoute == Routes.POST_RIDE);
      } catch (e) {
        throw Exception(e);
      }
    } else {
      showMySnackbar(msg: 'Please fill in user details');
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

    // Check if the value contains a valid country code and phone number
    final RegExp phoneExp = RegExp(r'^\+(\+1|91)?[0-9]{10,11}$');
    if (!phoneExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null; // Return null if the value is valid
  }

  String? validateGender(Object? value) {
    if (value == null) {
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

  String? validateModel(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your model';
    }

    // Check if the value contains only letters (and optionally spaces)
    final RegExp nameExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter a valid model';
    }

    return null;
  }

  String? validateVehicleType(Object? value) {
    if (value == null) {
      return 'Please select your Vehicle type';
    }
    return null;
  }

  String? validateColor(Object? value) {
    if (value == null) {
      return 'Please select your Vehicle colour';
    }
    return null;
  }

  String? validateYear(String? value) {
    if (value == null || value.isEmpty || value.length > 4) {
      return 'Please enter a correct year';
    }

    // Check if value consists only of digits
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Year must contain only digits';
    }

    // Parse the value to an integer
    int year;
    try {
      year = int.parse(value);
    } catch (e) {
      return 'Invalid year format';
    }

    // Check if the year is within a valid range
    if (year < 1000 || year > 9999) {
      return 'Please enter a correct year';
    }

    return null;
  }

  String? validateLicensePlate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a correct license number';
    }

    // Check if value consists only of letters and digits and has a maximum length of 7
    if (!RegExp(r'^[a-zA-Z0-9]{1,7}$').hasMatch(value)) {
      return 'License plate must contain only letters and numbers';
    }

    return null;
  }

  checkUserValidations() async {
    final isValid = userFormKey.currentState!.validate();

    if (!isValid &&
        isProfileImagePicked.value != true &&
        isIDPicked.value != true) {
      return showMySnackbar(msg: 'Please fill in all the details');
    } else {
      userFormKey.currentState!.save();
      await userDetailsAPI();
    }
  }

  checkVehicleValidations() async {
    final isValid = vehicleFormKey.currentState!.validate();

    if (!isValid && selectedVehicleImagePath.value!.path.isEmpty) {
      return showMySnackbar(msg: 'Please fill in all the details');
    } else {
      vehicleFormKey.currentState!.save();
      await vehicleDetailsAPI();
    }
  }
}
