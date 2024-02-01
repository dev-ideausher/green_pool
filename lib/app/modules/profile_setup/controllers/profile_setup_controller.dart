import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/add_vehicle_data.dart';
import 'package:green_pool/app/modules/post_ride/controllers/post_ride_controller.dart';
import 'package:green_pool/app/modules/post_ride/views/carpool_schedule_view.dart';
import 'package:green_pool/app/modules/profile_setup/views/review_picture.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import '../../../services/auth.dart';
import '../../../services/dio/api_service.dart';

class ProfileSetupController extends GetxController {
  final pageIndex = 0.obs;
  Rx<File?> selectedProfileImagePath = Rx<File?>(null);
  Rx<File?> selectedIDImagePath = Rx<File?>(null);
  Rx<File?> selectedVehicleImagePath = Rx<File?>(null);
  RxBool isProfileImagePicked = false.obs;
  RxBool isIDPicked = false.obs;
  RxBool isVehicleImagePicked = false.obs;
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  TextEditingController model = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController licencePlate = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => PostRideController());
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  getProfileImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedProfileImagePath.value = File(pickedFile.path);
      update();
      Get.to(ReviewPictureView(
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
      update();
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  Map<String, dynamic> userData = {};

  void updateUserDetails() async {
    userData = {
      'fullName': fullName.text,
      'email': email.text,
      'phone': phoneNumber.text,
      'gender': gender.text,
      'city': city.text,
      'dob': DateTime.now().toString(),
      'profilePic': await dio.MultipartFile.fromFile(
          selectedProfileImagePath.value!.path,
          contentType: MediaType('image',
              selectedProfileImagePath.value?.path.split('.').last ?? ''))
    };
  }

  Future<void> userDetailsAPI() async {
    updateUserDetails();
    log("profile setup user data: $userData");

    try {
      APIManager.userDetails(body: userData).then((value) {
        if (value.data['status']) {
          showMySnackbar(msg: 'Details updated succesfully');
        } else {
          showMySnackbar(msg: 'Error in updating details');
        }
      });
    } catch (e) {
      print("userDetailsAPI error: $e");
    }
  }

  Future<void> vehicleDetailsAPI() async {
    AddVehicleDataVehicleDetails addVehicleDetails =
        AddVehicleDataVehicleDetails();
    AddVehicleDataVehicleDetailsVehiclePic addVehiclePic =
        AddVehicleDataVehicleDetailsVehiclePic();

    addVehiclePic.key = 'VehicleImage';
    addVehiclePic.url =
        selectedVehicleImagePath.value?.path.split('.').last ?? '';

    addVehicleDetails.color = color.text;
    addVehicleDetails.licencePlate = licencePlate.text;
    addVehicleDetails.model = model.text;
    addVehicleDetails.type = type.text;
    addVehicleDetails.year = int.parse(year.text);
    addVehicleDetails.vehiclePic = addVehiclePic;

    final vehicleData = AddVehicleData(
        Id: Get.find<AuthService>().auth.currentUser?.uid,
        vehicleDetails: addVehicleDetails);

    try {
      await APIManager.postVehicleDetails(body: vehicleData.toJson())
          .then((value) => {
                if (value.data['status'])
                  {Get.to(() => const CarpoolScheduleView())}
                else
                  {showMySnackbar(msg: 'Vehicle data not uploaded')}
              });
    } catch (error) {
      print("vehicleDetailsAPI error: $error");
    }
  }
}
