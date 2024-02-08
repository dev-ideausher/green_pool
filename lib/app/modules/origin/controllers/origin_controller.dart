import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:green_pool/app/modules/post_ride/controllers/post_ride_controller.dart';
import 'package:green_pool/app/services/dio/endpoints.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class OriginController extends GetxController {
  TextEditingController originController = TextEditingController();
  var uuid = const Uuid();
  String? _sessionToken;
  RxList<dynamic> addressSugestionList = [].obs;
  final _debouncer = Debouncer(delay: const Duration(seconds: 1));

  RxBool isOrigin = false.obs;

  @override
  void onInit() {
    super.onInit();
    isOrigin.value = Get.arguments;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  //  Get.find<PostRideController>()
  //         .postRideModel
  //         .ridesDetails
  //         ?.origin
  //         ?.latitude = lat;
  //     Get.find<PostRideController>()
  //         .postRideModel
  //         .ridesDetails
  //         ?.origin
  //         ?.longitude = long;

  void setSessionToken() {
    _sessionToken ??= uuid.v4();
    _debouncer(() => addressAutoComplete(originController.text));
  }

  addressAutoComplete(String input) async {
    //from search query to address suggestions
    String apiKey = Endpoints.googleApiKey;
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$apiKey&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      addressSugestionList.value =
          jsonDecode(response.body.toString())['predictions'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getLatLong(String placeId) async {
    String placeApiKey = Endpoints.googleApiKey;
    String baseurl = 'https://maps.googleapis.com/maps/api/place';
    try {
      String request =
          '$baseurl/details/json?place_id=$placeId&key=$placeApiKey';

      var response = await http.get(Uri.parse(request));

      final geometry = response.body;
      double lat =
          jsonDecode(geometry)['result']['geometry']['location']['lat'];
      double long =
          jsonDecode(geometry)['result']['geometry']['location']['lat'];
      String nameOfLocation =
          jsonDecode(geometry)['result']['address_components'][0]['long_name'];

      return [lat, long, nameOfLocation];
    } catch (e) {
      print("getLatLong error: $e");
      throw Exception('Failed to load data');
    }
  }

  Future<void> setLocationData(String placeId) async {
    // set lat and long to origin latlong if isOrigin is true

    try {
      List<dynamic> fetchLatLong = await getLatLong(placeId);
      if (isOrigin.value) {
        Get.find<PostRideController>()
            .postRideModel
            .ridesDetails
            ?.origin
            ?.latitude = fetchLatLong[0];
        Get.find<PostRideController>()
            .postRideModel
            .ridesDetails
            ?.origin
            ?.longitude = fetchLatLong[1];
        Get.find<PostRideController>()
            .postRideModel
            .ridesDetails
            ?.origin
            ?.name = fetchLatLong[2];
        Get.find<PostRideController>().originTextController.text =
            fetchLatLong[2];
      } else {
        Get.find<PostRideController>()
            .postRideModel
            .ridesDetails
            ?.destination
            ?.latitude = fetchLatLong[0];
        Get.find<PostRideController>()
            .postRideModel
            .ridesDetails
            ?.destination
            ?.longitude = fetchLatLong[1];
        Get.find<PostRideController>()
            .postRideModel
            .ridesDetails
            ?.destination
            ?.name = fetchLatLong[2];
        Get.find<PostRideController>().destinationTextController.text =
            fetchLatLong[2];
      }
    } catch (e) {}
  }
}
