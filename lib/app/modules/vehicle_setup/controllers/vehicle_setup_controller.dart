import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/post_ride_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/gp_util.dart';
import '../../../services/snackbar.dart';
import '../../../services/storage.dart';
import '../../home/controllers/home_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

class VehicleSetupController extends GetxController {
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

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      postRideModel.value = Get.arguments;
    } catch (e) {
      debugPrint(e.toString());
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

/*    if (Get.find<GetStorageService>().profileStatus == true) {*/
    try {
      await APIManager.postVehicleDetails(body: vehicleData);
      showMySnackbar(msg: "Data filled successfully");
      Get.find<GetStorageService>().setDriver = true;
      Get.find<HomeController>().userInfoAPI();
      // Get.offNamed(Routes.CARPOOL_SCHEDULE, arguments: isDriver);
      Get.offNamed(Routes.POST_RIDE_STEP_TWO, arguments: postRideModel.value);
    } catch (e) {
      throw Exception(e);
    }
    /*} else {
      showMySnackbar(msg: 'Please fill in all the details');
    }*/
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
}
