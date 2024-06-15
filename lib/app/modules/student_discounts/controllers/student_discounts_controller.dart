import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:green_pool/app/data/school_list_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../services/snackbar.dart';

class StudentDiscountsController extends GetxController {
  TextEditingController emailTextController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool requestSent = false.obs;
  RxBool isActive = false.obs;
  RxBool isSelected = true.obs;
  RxList<SchoolListModelData> schoolSugestionList = <SchoolListModelData>[].obs;
  final debouncer = Debouncer(delay: const Duration(seconds: 1));
  TextEditingController searchTextController = TextEditingController();
  var schoolListModel = SchoolListModel().obs;
  final confettiController = ConfettiController();

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  searchMethod() {
    debouncer(() => schoolListAPI(searchTextController.value.text));
  }

  schoolListAPI(String input) async {
    if (input.isNotEmpty) {
      try {
        isLoading.value = true;
        isSelected.value = false;
        final response = await APIManager.getAllSchools(schoolName: input);
        var data = jsonDecode(response.toString());
        schoolListModel.value = SchoolListModel.fromJson(data);
        if (schoolListModel.value.data!.isNotEmpty) {
          schoolSugestionList.value = schoolListModel.value.data!;
        }
        isLoading.value = false;
      } catch (e) {
        throw Exception(e);
      }
    } else {}
  }

  studentDiscountAPI() async {
    try {
      final response = await APIManager.postStudentDiscount(body: {
        "email": emailTextController.value.text,
        "school": searchTextController.text,
      });
      if (response.data['status']) {
        requestSent.value = true;
        confettiController.play();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  toggleButton() {
    if (isSelected.value == true && emailTextController.value.text.isNotEmpty) {
      isActive.value = true;
    } else {
      return showMySnackbar(msg: "please fill in the required information");
    }
  }
}
