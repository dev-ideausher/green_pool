import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../profile_setup/views/review_picture.dart';

class RiderProfileSetupController extends GetxController {
  var selectedProfileImagePath = ''.obs;
  var selectedIDImagePath = ''.obs;
  RxBool isPicked = false.obs;
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void getProfileImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedProfileImagePath.value = pickedFile.path;
      isPicked.value = true;
      Get.back();
      // Get.to( ReviewPictureView( imagePath: selectedProfileImagePath.value,));
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  void getIDImage(ImageSource imageSource) async {
    final pickedIDFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedIDFile != null) {
      selectedIDImagePath.value = pickedIDFile.path;
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  //
  Map<String, dynamic> userData = {};


  void updateUserDetails()  {
    userData = {
      'fullName': fullName.text,
      'email': email.text,
      'phone': phoneNumber.text,
      'gender': 'Male',
      'city': city.text,
      'dob': DateTime.now().toString(),
      // 'profilePic': dio.MultipartFile.fromFile(selectedProfileImagePath.value),
    };
  }

  Future<void> userDetailsAPI() async {
    updateUserDetails();
    print("USER DATA: $userData");
    APIManager.userDetails(body: userData).then((value) {
      if (value.data['status']) {
        showMySnackbar(msg: 'Details updated succesfully');
        Get.offNamed(Routes.MATCHING_RIDES);
      } else {
        showMySnackbar(msg: 'Error in updating details');
      }
    });
  }
}
