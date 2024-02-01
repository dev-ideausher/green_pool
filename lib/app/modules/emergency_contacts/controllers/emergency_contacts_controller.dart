import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/emergencyContactsModel.dart';
import 'package:green_pool/app/services/auth.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

class EmergencyContactsController extends GetxController {
  TextEditingController fullName1 = TextEditingController();
  TextEditingController fullName2 = TextEditingController();
  TextEditingController emergencyNumber1 = TextEditingController();
  TextEditingController emergencyNumber2 = TextEditingController();

  emergencyContactsAPI() async {
    List<EmergencyModelEmergencyContacts?>? emergencyContacts =
        <EmergencyModelEmergencyContacts>[];

    emergencyNumber1.text.isNotEmpty && fullName1.text.isNotEmpty
        ? emergencyContacts.add(EmergencyModelEmergencyContacts(
            phone: emergencyNumber1.text, fullName: fullName1.text))
        : null;

    emergencyNumber2.text.isNotEmpty && fullName2.text.isNotEmpty
        ? emergencyContacts.add(EmergencyModelEmergencyContacts(
            phone: emergencyNumber2.text, fullName: fullName2.text))
        : null;

    final emergencyModel = EmergencyModel(
        Id: Get.find<AuthService>().auth.currentUser?.uid,
        emergencyContacts: emergencyContacts);

    try {
      await APIManager.postEmergencyDetails(
        body: emergencyModel.toJson(),
      );
    } catch (e) {
      print('emcontact error: $e');
    }
  }
}
