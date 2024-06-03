import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/modules/find_ride/controllers/find_ride_controller.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/post_ride/controllers/post_ride_controller.dart';
import 'package:green_pool/app/services/dio/endpoints.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../../data/google_location_model.dart';

enum LocationValues { origin, destination, addStop1, addStop2, findRideOrigin, findRideDestination }

class OriginController extends GetxController {
  TextEditingController originController = TextEditingController();
  var uuid = const Uuid();
  String? _sessionToken;
  RxList<dynamic> addressSugestionList = [].obs;
  final debouncer = Debouncer(delay: const Duration(seconds: 1));
  RxBool isLoading = false.obs;
  RxBool isOrigin = false.obs;
  LocationValues locationValues = LocationValues.origin;
  var postRideModel = PostRideModel().obs;

  @override
  void onInit() {
    super.onInit();
    locationValues = Get.arguments;
  }

  void setSessionToken() {
    _sessionToken ??= uuid.v4();
    debouncer(() => addressAutoComplete(originController.text));
  }

  addressAutoComplete(String input) async {
    //from search query to address suggestions
    String apiKey = Endpoints.googleApiKey;
    String lat = Get.find<HomeController>().latitude.value.toString();
    String long = Get.find<HomeController>().longitude.value.toString();

    try {
      isLoading.value = true;
      String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String components = 'country:ca';
      String request = '$baseURL?input=$input&location=$lat%$long&radius=500&key=$apiKey&sessiontoken=$_sessionToken&components=$components';

      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        addressSugestionList.value = jsonDecode(response.body.toString())['predictions'];
      } else {
        throw Exception('Failed to load data');
      }
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getLatLong(String placeId) async {
    String placeApiKey = Endpoints.googleApiKey;
    String baseurl = 'https://maps.googleapis.com/maps/api/place';
    try {
      String request = '$baseurl/details/json?place_id=$placeId&key=$placeApiKey';
      var response = await http.get(Uri.parse(request));
      final geometry = GoogleLocationModel.fromJson(jsonDecode(response.body)).result;

      double lat =geometry?.geometry?.location?.lat ?? 0.0;
      double long = geometry?.geometry?.location?.lng ?? 0.0;


      String nameOfLocation =     geometry?.formattedAddress??"";
      return [lat, long, nameOfLocation];
    } catch (e) {
      log("getLatLong error: $e");
      throw Exception('Failed to load data');
    }
  }

  Future<void> setLocationData(String placeId) async {
    // set lat and long to origin latlong if isOrigin is true

    try {
      //? how to place this in getLatLong directly
      List<dynamic> fetchLatLong = await getLatLong(placeId);

      if (locationValues.name == LocationValues.origin.name) {
        Get.find<PostRideController>().originLatitude.value = fetchLatLong[0];
        Get.find<PostRideController>().originLongitude.value = fetchLatLong[1];
        Get.find<PostRideController>().originTextController.text = fetchLatLong[2];
        // postRideModel.value.ridesDetails?.origin?.latitude = fetchLatLong[0];
        // postRideModel.value.ridesDetails?.origin?.longitude = fetchLatLong[1];
        // postRideModel.value.ridesDetails?.origin?.name = fetchLatLong[2];
      } else if (locationValues.name == LocationValues.destination.name) {
        Get.find<PostRideController>().destLatitude.value = fetchLatLong[0];
        Get.find<PostRideController>().destLongitude.value = fetchLatLong[1];
        Get.find<PostRideController>().destinationTextController.text = fetchLatLong[2];
      } else if (locationValues.name == LocationValues.addStop1.name) {
        Get.find<PostRideController>().stop1Lat.value = fetchLatLong[0];
        Get.find<PostRideController>().stop1Long.value = fetchLatLong[1];
        Get.find<PostRideController>().stop1TextController.text = fetchLatLong[2];
      } else if (locationValues.name == LocationValues.addStop2.name) {
        Get.find<PostRideController>().stop2Lat.value = fetchLatLong[0];
        Get.find<PostRideController>().stop2Long.value = fetchLatLong[1];
        Get.find<PostRideController>().stop2TextController.text = fetchLatLong[2];
      } else if (locationValues.name == LocationValues.findRideOrigin.name) {
        Get.find<FindRideController>().riderOriginLat = fetchLatLong[0];
        Get.find<FindRideController>().riderOriginLong = fetchLatLong[1];
        Get.find<FindRideController>().riderOriginTextController.text = fetchLatLong[2];
      } else if (locationValues.name == LocationValues.findRideDestination.name) {
        Get.find<FindRideController>().riderDestinationLat = fetchLatLong[0];
        Get.find<FindRideController>().riderDestinationLong = fetchLatLong[1];
        Get.find<FindRideController>().riderDestinationTextController.text = fetchLatLong[2];
      }
    } catch (e) {
      log("setLocationData error: $e");
    }
    Get.back();
  }
}
