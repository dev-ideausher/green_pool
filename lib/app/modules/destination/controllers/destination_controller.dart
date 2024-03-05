import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:uuid/uuid.dart';

import '../../../services/dio/endpoints.dart';
import 'package:http/http.dart' as http;

class DestinationController extends GetxController {
  TextEditingController destinationController = TextEditingController();
  var uuid = const Uuid();
  String? _sessionToken;
  RxList<dynamic> destinationList = [].obs;
  RxDouble destinationLatitude = 0.0.obs;
  RxDouble destinationLongitude = 0.0.obs;
  final _debouncer = Debouncer(delay: const Duration(seconds: 1));

  void setSessionToken() {
    _sessionToken ??= uuid.v4();
    _debouncer(() => getDestination(destinationController.text));
  }

  getDestination(String input) async {
    String apiKey = Endpoints.googleApiKey;
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&radius=500&key=$apiKey&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      destinationList.value =
          jsonDecode(response.body.toString())['predictions'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  getLatLong(String placeId) async {
    String placeApiKey = Endpoints.googleApiKey;
    String baseurl = 'https://maps.googleapis.com/maps/api/place';
    try {
      String request =
          '$baseurl/details/json?place_id=$placeId&key=$placeApiKey';

      var response = await http.get(Uri.parse(request));

      final geometry = response.body;
      var lat = jsonDecode(geometry)['result']['geometry']['location']['lat'];
      var long = jsonDecode(geometry)['result']['geometry']['location']['lat'];

      destinationLatitude.value = lat;
      destinationLongitude.value = long;
    } catch (e) {
      throw Exception(e);
    }
  }

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
}
