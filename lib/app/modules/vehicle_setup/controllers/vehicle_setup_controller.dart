import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/post_ride_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/utils/image_util.dart';
import '../../../services/snackbar.dart';
import '../../../services/storage.dart';
import '../../home/controllers/home_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

class VehicleSetupController extends GetxController {
  Rx<File?> selectedVehicleImagePath = Rx<File?>(null);
  TextEditingController model = TextEditingController();
  RxBool isVehicleBtnLoading = false.obs;
  RxBool isVehicleImagePicked = false.obs;
  RxBool vehicleImageNotUploaded = false.obs;
  RxBool idImageNotUploaded = false.obs;
  TextEditingController year = TextEditingController();
  TextEditingController licencePlate = TextEditingController();

  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> vehicleFormKey = GlobalKey<FormState>();

  final Rx<PostRideModel> postRideModel = PostRideModel().obs;

  Rx<File?> selectedIDImagePath = Rx<File?>(null);
  RxBool isIDPicked = false.obs;

  final count = 0.obs;
  TextEditingController type = TextEditingController();
  RxBool isTypeListExpanded = false.obs;
  RxList<String> typeList = <String>[
    "Hatchback",
    "Coupe",
    "Convertible",
    "Sedan",
    "SUV",
    "Truck",
    "Van"
  ].obs;
  TextEditingController color = TextEditingController();
  RxBool isColorListExpanded = false.obs;
  RxList<String> colorList = <String>[
    "Silver",
    "Black",
    "White",
    "Dark Grey",
    "Light Grey",
    "Red",
    "Blue",
    "Light Blue",
    "Dark Blue",
    "Brown"
  ].obs;

  //focus node
  FocusNode modelFocusNode = FocusNode();
  FocusNode typeFocusNode = FocusNode();
  FocusNode colorFocusNode = FocusNode();
  FocusNode yearFocusNode = FocusNode();
  FocusNode licenseFocusNode = FocusNode();

  ScrollController vehicleInfoScroll = ScrollController();

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
    XFile? pickedVehicleFile =
        await ImageUtil.cropCompressImage(imageSource: imageSource);
    if (pickedVehicleFile != null) {
      selectedVehicleImagePath.value = File(pickedVehicleFile.path);
      isVehicleImagePicked.value = true;
      Get.back();
      update();
    } else {
      showMySnackbar(msg: LocaleKeys.app_no_img_selected.tr);
    }
  }

  getIDImage(ImageSource imageSource) async {
    XFile? pickedIDFile =
        await ImageUtil.cropCompressImage(imageSource: imageSource);

    if (pickedIDFile != null) {
      selectedIDImagePath.value = File(pickedIDFile.path);
      isIDPicked.value = true;
      Get.back();
      update();
    } else {
      showMySnackbar(msg: LocaleKeys.app_no_img_selected.tr);
    }
  }

  bool _isFieldEmpty(
      String fieldValue, FocusNode focusNode, String errorMessage) {
    if (fieldValue.isEmpty) {
      focusNode.requestFocus();
      showMySnackbar(msg: errorMessage);
      return true;
    }
    return false;
  }

  void _scrollVehicleInfoToTop() {
    vehicleInfoScroll.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  checkVehicleValidations() async {
    final isValid = vehicleFormKey.currentState!.validate();

    if (!isValid) {
      vehicleImageNotUploaded.value = true;
      idImageNotUploaded.value = true;

      if (!isVehicleImagePicked.value) {
        _scrollVehicleInfoToTop();
        return showMySnackbar(msg: 'Please upload the vehicle image');
      }

      if (_isFieldEmpty(
        model.text,
        modelFocusNode,
        'Please enter your model',
      )) return;

      if (_isFieldEmpty(
        type.text,
        typeFocusNode,
        'Please select your car type',
      )) {
        isTypeListExpanded.value = true;
        return;
      }

      if (_isFieldEmpty(
        color.text,
        colorFocusNode,
        'Kindly select the color of your vehicle.',
      )) {
        isColorListExpanded.value = true;
        return;
      }

      if (_isFieldEmpty(
        year.text,
        yearFocusNode,
        'Please enter a correct year',
      )) return;

      if (_isFieldEmpty(
        licencePlate.text,
        licenseFocusNode,
        'Please enter a correct license number',
      )) return;

      if (!isIDPicked.value) {
        idImageNotUploaded.value = true;
        return showMySnackbar(msg: 'Please upload your verification ID');
      }

      return showMySnackbar(msg: 'Please fill in all the details');
    } else {
      if (!isVehicleImagePicked.value) {
        _scrollVehicleInfoToTop();
        return showMySnackbar(msg: 'Please upload the vehicle image');
      }

      if (!isIDPicked.value) {
        idImageNotUploaded.value = true;
        return showMySnackbar(msg: 'Please upload your verification ID');
      }

      vehicleImageNotUploaded.value = false;
      idImageNotUploaded.value = false;
      vehicleFormKey.currentState!.save();
      await uploadID();
    }
  }

  Future<void> uploadID() async {
    final File pickedIDFile = File(selectedIDImagePath.value?.path ?? "");
    String idExtension = pickedIDFile.path.split('.').last;
    String idMediaType;

    if (idExtension == 'jpg' || idExtension == 'jpeg') {
      idMediaType = 'image/jpeg';
    } else if (idExtension == 'png') {
      idMediaType = 'image/png';
    } else {
      idMediaType = 'application/octet-stream';
    }

    final userData = dio.FormData.fromMap({
      if (isIDPicked.value)
        'idPic': await dio.MultipartFile.fromFile(
          pickedIDFile.path,
          contentType: MediaType.parse(idMediaType),
          filename: path.basename(pickedIDFile.path),
        ),
    });

    try {
      isVehicleBtnLoading.value = true;
      final response = await APIManager.userDetails(body: userData);
      if (response.data['status'] == true) {
        await vehicleDetailsAPI();
      } else {
        showMySnackbar(msg: response.data['message'].toString());
        isVehicleBtnLoading.value = false;
      }
    } catch (e) {
      isVehicleBtnLoading.value = false;
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
      'model': model.text,
      'type': type.value.text,
      'color': color.value.text,
      'year': year.text,
      'licencePlate': licencePlate.text,
      'vehiclePic': await dio.MultipartFile.fromFile(
        pickedVehicleFile.path,
        contentType: MediaType.parse(mediaType),
        filename: path.basename(pickedVehicleFile.path),
      )
    });
    try {
      isVehicleBtnLoading.value = true;
      final res = await APIManager.postVehicleDetails(body: vehicleData);
      if (res.data["status"]) {
        showMySnackbar(msg: "Data filled successfully");
        Get.find<GetStorageService>().setDriver = true;
        Get.find<HomeController>().userInfoAPI();
        isVehicleBtnLoading.value = false;
        Get.until((route) => Get.currentRoute == Routes.POST_RIDE_STEP_FOUR);
        // Get.offNamed(Routes.POST_RIDE_STEP_TWO, arguments: postRideModel.value);
      } else {
        showMySnackbar(msg: res.data["message"].toString());
      }
    } catch (e) {
      throw Exception(e);
    }
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

  String? validateVehicleType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your Vehicle type';
    }
    return null;
  }

  String? validateColor(String? value) {
    if (value == null || value.isEmpty) {
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
