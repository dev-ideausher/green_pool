import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:green_pool/app/data/school_list_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

class StudentDiscountsController extends GetxController {
  TextEditingController emailTextController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isSelected = true.obs;
  RxList<SchoolListModelData> schoolSugestionList = <SchoolListModelData>[].obs;
  final debouncer = Debouncer(delay: const Duration(seconds: 1));
  TextEditingController searchTextController = TextEditingController();
  var schoolListModel = SchoolListModel().obs;

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
        } else {}
        isLoading.value = false;
      } catch (e) {
        throw Exception(e);
      }
    } else {}
  }

  studentDiscountAPI() async {
    final Map<String, dynamic> body = {"email": emailTextController.value.text};
    final response = await APIManager.postStudentDiscount(body: body);
    // var data = jsonDecode(response.toString());
    print(response.toString());
  }
}
