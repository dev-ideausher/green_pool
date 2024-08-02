import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/profile_setup/views/review_picture.dart';
import 'package:green_pool/app/modules/rider_profile_setup/controllers/city_list.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;
import '../../../services/auth.dart';
import '../../../services/colors.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/gp_util.dart';

class ProfileSetupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool fromNavBar = false;
  RxBool isCityListExpanded = false.obs;
  RxList<String> cityNames = <String>[].obs;
  final debouncer = Debouncer(delay: const Duration(milliseconds: 50));
  final pageIndex = 0.obs;
  Rx<File?> selectedProfileImagePath = Rx<File?>(null);
  Rx<File?> selectedIDImagePath = Rx<File?>(null);
  RxBool isProfileImagePicked = false.obs;
  RxBool isIDPicked = false.obs;
  RxBool expandList = false.obs;
  RxBool imageNotUploaded = false.obs;
  bool readOnlyEmail = false;
  TextEditingController fullName = TextEditingController(
      text: Get.find<GetStorageService>().getUserName ?? "");
  TextEditingController email =
      TextEditingController(text: Get.find<GetStorageService>().emailId ?? "");
  TextEditingController phoneNumber = TextEditingController(
      text: Get.find<AuthService>()
          .auth
          .currentUser
          ?.phoneNumber
          .toString()
          .split("+1")
          .last);
  TextEditingController gender = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController formattedDateOfBirth = TextEditingController();
  late TabController tabBarController;

  //for vehicle
  Rx<File?> selectedVehicleImagePath = Rx<File?>(null);
  TextEditingController model = TextEditingController();
  // TextEditingController color = TextEditingController();
  // TextEditingController type = TextEditingController();
  RxBool isVehicleImagePicked = false.obs;
  RxBool vehicleImageNotUploaded = false.obs;
  RxString color = "Silver".obs;
  RxString type = "Sedan".obs;
  TextEditingController year = TextEditingController();
  TextEditingController licencePlate = TextEditingController();

  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> vehicleFormKey = GlobalKey<FormState>();

  final Rx<PostRideModel> postRideModel = PostRideModel().obs;

  @override
  void onInit() {
    super.onInit();
    try {
      fromNavBar = Get.arguments['fromNavBar'];
      postRideModel.value = Get.arguments['postRideModel'];
      fullName.text = Get.arguments['fullName'];
    } catch (e) {
      fromNavBar = Get.arguments['fromNavBar'];
      fullName.text = Get.arguments['fullName'];
    }
    tabBarController = TabController(length: 2, vsync: this);
    if (Get.find<GetStorageService>().emailId != "") {
      readOnlyEmail = true;
    } else {
      readOnlyEmail = false;
    }
  }

  Future<void> setDate(BuildContext context) async {
    DateTime lastDate = DateTime.now().subtract(const Duration(days: 18 * 365));

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
      Get.to(() => ReviewPictureView(
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

  getVehicleImage(ImageSource imageSource) async {
    XFile? pickedVehicleFile = await GpUtil.compressImage(imageSource);
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
    final storageService = Get.find<GetStorageService>();
    final File pickedImageFile = File(selectedProfileImagePath.value!.path);
    final File pickedIDFile = File(selectedIDImagePath.value!.path);
    String extension = pickedImageFile.path.split('.').last;
    String idExtension = pickedIDFile.path.split('.').last;
    String mediaType;
    String idMediaType;

    if (extension == 'jpg' || extension == 'jpeg') {
      mediaType = 'image/jpeg';
    } else if (extension == 'png') {
      mediaType = 'image/png';
    } else {
      mediaType = 'application/octet-stream';
    }
    if (idExtension == 'jpg' || idExtension == 'jpeg') {
      idMediaType = 'image/jpeg';
    } else if (idExtension == 'png') {
      idMediaType = 'image/png';
    } else {
      idMediaType = 'application/octet-stream';
    }

    final userData = dio.FormData.fromMap({
      'fullName': fullName.text,
      'email': email.text,
      'phone': phoneNumber.text,
      'gender': gender.text,
      'city': city.value.text,
      'dob': dateOfBirth.text,
      'profilePic': await dio.MultipartFile.fromFile(
        pickedImageFile.path,
        contentType: MediaType.parse(mediaType),
        filename: path.basename(pickedImageFile.path),
      ),
      'idPic': await dio.MultipartFile.fromFile(
        pickedIDFile.path,
        contentType: MediaType.parse(idMediaType),
        filename: path.basename(pickedIDFile.path),
      ),
    });
    try {
      final response = await APIManager.userDetails(body: userData);
      if (response.data['status']) {
        showMySnackbar(msg: response.data['message']);
        storageService.setUserName = fullName.text;
        storageService.emailId = email.text;
        storageService.profileStatus = true;
        tabBarController.index = 1;
      } else {
        showMySnackbar(msg: response.data['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> vehicleDetailsAPI() async {
    final storageService = Get.find<GetStorageService>();
    final homeController = Get.find<HomeController>();
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

    if (storageService.profileStatus == true) {
      try {
        await APIManager.postWelcomeEmail(emailId: {"email": email.text});
        final response = await APIManager.postVehicleDetails(body: vehicleData);
        if (response.data['status']) {
          showMySnackbar(msg: "Data filled successfully");
          storageService.isLoggedIn = true;
          storageService.setDriver = true;
          Get.offNamed(Routes.EMERGENCY_CONTACTS, arguments: {
            'fromNavBar': fromNavBar,
            'postRideModel': postRideModel.value
          }, parameters: {
            "profileType": "driver"
          });
          homeController.userInfoAPI();
        } else {
          showMySnackbar(msg: response.data['message'].toString());
        }
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

    // Check if the value contains exactly 10 digits
    final RegExp phoneExp = RegExp(r'^[0-9]{10}$');
    if (!phoneExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }

    return null; // Return null if the value is valid
  }

  String? validateGender(Object? value) {
    if (value == null) {
      return 'Please select your gender';
    }
    return null;
  }

  String? validateCity(Object? value) {
    if (value == null) {
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
    if (year < 1990 || year > DateTime.now().year) {
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

    if (!isValid) {
      imageNotUploaded.value = true;
      return showMySnackbar(msg: 'Please fill in all the details');
    } else {
      if (isProfileImagePicked.value != true || isIDPicked.value != true) {
        imageNotUploaded.value = true;
        return showMySnackbar(msg: 'Please upload the required images');
      } else {
        imageNotUploaded.value = false;
        userFormKey.currentState!.save();
        await userDetailsAPI();
      }
    }
  }

  checkVehicleValidations() async {
    final isValid = vehicleFormKey.currentState!.validate();

    if (!isValid) {
      vehicleImageNotUploaded.value = true;
      return showMySnackbar(msg: 'Please fill in all the details');
    } else {
      if (isVehicleImagePicked.value != true) {
        vehicleImageNotUploaded.value = true;
        return showMySnackbar(msg: 'Please upload the required images');
      } else {
        vehicleImageNotUploaded.value = false;
        vehicleFormKey.currentState!.save();
        await vehicleDetailsAPI();
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
