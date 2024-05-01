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
import '../../../services/colors.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/gp_util.dart';
import '../../../services/text_style_util.dart';

class ProfileSetupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool fromNavBar = false;
  final pageIndex = 0.obs;
  String name = '';
  Rx<File?> selectedProfileImagePath = Rx<File?>(null);
  Rx<File?> selectedIDImagePath = Rx<File?>(null);
  Rx<File?> selectedVehicleImagePath = Rx<File?>(null);
  RxBool isProfileImagePicked = false.obs;
  RxBool isIDPicked = false.obs;
  RxBool isVehicleImagePicked = false.obs;
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController(
      text: Get.find<AuthService>().auth.currentUser?.phoneNumber);
  // TextEditingController gender = TextEditingController();
  RxString gender = 'Prefer not to say'.obs;
  RxString selectedCity = 'Brampton'.obs;
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
    fromNavBar = Get.arguments;
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

  void updateSelectedCity(String city) {
    selectedCity.value = city;
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
            primaryColor: Get.find<HomeController>().isSwitched.value
                ? ColorUtil.kPrimaryPinkMode
                : ColorUtil.kPrimary01,
            // Define the color scheme for the date picker
            colorScheme: ColorScheme.light(
              // Define the primary color for the date picker
              primary: Get.find<HomeController>().isSwitched.value
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01,
              // Define the background color for the date picker
              surface: ColorUtil.kWhiteColor,
              // Define the on-primary color for the date picker
              onPrimary: ColorUtil.kBlack01,
              secondary: Get.find<HomeController>().isSwitched.value
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
        contentType: MediaType.parse(idMediaType),
        filename: path.basename(pickedIDFile.path),
      ),
    });
    log("profile setup user data: $userData");

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
        if (fromNavBar) {
          Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
        } else {
          Get.until((route) => Get.currentRoute == Routes.POST_RIDE);
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
      return showMySnackbar(msg: 'Please fill in all the details');
    } else {
      if (isProfileImagePicked.value != true || isIDPicked.value != true) {
        return showMySnackbar(msg: 'Please upload the required images');
      } else {
        userFormKey.currentState!.save();
        await userDetailsAPI();
      }
    }
  }

  checkVehicleValidations() async {
    final isValid = vehicleFormKey.currentState!.validate();

    if (!isValid) {
      return showMySnackbar(msg: 'Please fill in all the details');
    } else {
      if (selectedVehicleImagePath.value!.path.isEmpty) {
        return showMySnackbar(msg: 'Please upload the required images');
      } else {
        vehicleFormKey.currentState!.save();
        await vehicleDetailsAPI();
      }
    }
  }

  List<DropdownMenuItem<Object>> citiesDropdownItems = [
    DropdownMenuItem<Object>(
      value: "Toronto",
      child: Text(
        "Toronto",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Montreal",
      child: Text(
        "Montreal",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Vancouver",
      child: Text(
        "Vancouver",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Calgary",
      child: Text(
        "Calgary",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Edmonton",
      child: Text(
        "Edmonton",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Ottawa",
      child: Text(
        "Ottawa",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Mississauga",
      child: Text(
        "Mississauga",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Winnipeg",
      child: Text(
        "Winnipeg",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Quebec City",
      child: Text(
        "Quebec City",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Hamilton",
      child: Text(
        "Hamilton",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Brampton",
      child: Text(
        "Brampton",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Surrey",
      child: Text(
        "Surrey",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Halifax",
      child: Text(
        "Halifax",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Laval",
      child: Text(
        "Laval",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Markham",
      child: Text(
        "Markham",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Vaughan",
      child: Text(
        "Vaughan",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Gatineau",
      child: Text(
        "Gatineau",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Saskatoon",
      child: Text(
        "Saskatoon",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Longueuil",
      child: Text(
        "Longueuil",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Kitchener",
      child: Text(
        "Kitchener",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Burnaby",
      child: Text(
        "Burnaby",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Windsor",
      child: Text(
        "Windsor",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Regina",
      child: Text(
        "Regina",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Richmond",
      child: Text(
        "Richmond",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Oakville",
      child: Text(
        "Oakville",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Burlington",
      child: Text(
        "Burlington",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Barrie",
      child: Text(
        "Barrie",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Sherbrooke",
      child: Text(
        "Sherbrooke",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Saguenay",
      child: Text(
        "Saguenay",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Levis",
      child: Text(
        "Levis",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Abbotsford",
      child: Text(
        "Abbotsford",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Coquitlam",
      child: Text(
        "Coquitlam",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Trois-Rivieres",
      child: Text(
        "Trois-Rivieres",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "St. Catharines",
      child: Text(
        "St. Catharines",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Guelph",
      child: Text(
        "Guelph",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Cambridge",
      child: Text(
        "Cambridge",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Whitby",
      child: Text(
        "Whitby",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Kelowna",
      child: Text(
        "Kelowna",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Ajax",
      child: Text(
        "Ajax",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Langley",
      child: Text(
        "Langley",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Saanich",
      child: Text(
        "Saanich",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Terrebonne",
      child: Text(
        "Terrebonne",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Milton",
      child: Text(
        "Milton",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "St. John's",
      child: Text(
        "St. John's",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Thunder Bay",
      child: Text(
        "Thunder Bay",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Waterloo",
      child: Text(
        "Waterloo",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Delta",
      child: Text(
        "Delta",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Chatham-Kent",
      child: Text(
        "Chatham-Kent",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Red Deer",
      child: Text(
        "Red Deer",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Strathcona County",
      child: Text(
        "Strathcona County",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Brantford",
      child: Text(
        "Brantford",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Saint-Jean-sur-Richelieu",
      child: Text(
        "Saint-Jean-sur-Richelieu",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Cape Breton",
      child: Text(
        "Cape Breton",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Lethbridge",
      child: Text(
        "Lethbridge",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Clarington",
      child: Text(
        "Clarington",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Pickering",
      child: Text(
        "Pickering",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Nanaimo",
      child: Text(
        "Nanaimo",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Sudbury",
      child: Text(
        "Sudbury",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "North Vancouver",
      child: Text(
        "North Vancouver",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Brossard",
      child: Text(
        "Brossard",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Repentigny",
      child: Text(
        "Repentigny",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Newmarket",
      child: Text(
        "Newmarket",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Chilliwack",
      child: Text(
        "Chilliwack",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Maple Ridge",
      child: Text(
        "Maple Ridge",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Peterborough",
      child: Text(
        "Peterborough",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Kawartha Lakes",
      child: Text(
        "Kawartha Lakes",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Drummondville",
      child: Text(
        "Drummondville",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Saint-Jerome",
      child: Text(
        "Saint-Jerome",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Prince George",
      child: Text(
        "Prince George",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Moncton",
      child: Text(
        "Moncton",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Sault Ste. Marie",
      child: Text(
        "Sault Ste. Marie",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "North Bay",
      child: Text(
        "North Bay",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Medicine Hat",
      child: Text(
        "Medicine Hat",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Norfolk County",
      child: Text(
        "Norfolk County",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Georgina",
      child: Text(
        "Georgina",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
    DropdownMenuItem<Object>(
      value: "Grande Prairie",
      child: Text(
        "Grande Prairie",
        style: TextStyleUtil.k14Regular(),
      ),
    ),
  ];
}
