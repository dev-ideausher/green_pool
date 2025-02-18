import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/modules/find_ride/controllers/find_ride_controller.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/dio/endpoints.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../../data/google_location_model.dart';
import '../../../services/storage.dart';

enum LocationValues {
  origin,
  destination,
  addStop1,
  addStop2,
  findRideOrigin,
  findRideDestination
}

class OriginController extends GetxController {
  TextEditingController originController = TextEditingController();
  var uuid = const Uuid();
  String? _sessionToken;
  DateTime? _sessionStartTime;
  final int sessionTimeout = 5 * 60; // 5 minutes timeout in seconds

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
    // Check if session has expired or not started
    if (_sessionToken == null || hasSessionExpired()) {
      _sessionToken = uuid.v4();
      _sessionStartTime = DateTime.now(); // Record session start time
    }

    if (originController.text.length > 3) {
      debouncer(() => addressAutoComplete(originController.text));
    }
  }

  bool hasSessionExpired() {
    if (_sessionStartTime == null) return true;
    return DateTime.now().difference(_sessionStartTime!).inSeconds >=
        sessionTimeout;
  }

// Call this when a place is selected to reset session
  void resetSessionToken() {
    if (_sessionToken != null && _sessionStartTime != null) {
      int sessionDuration =
          DateTime.now().difference(_sessionStartTime!).inSeconds;
      debugPrint('Session lasted for $sessionDuration seconds');
    }
    _sessionToken = null;
    _sessionStartTime = null;
  }

  addressAutoComplete(String input) async {
    //from search query to address suggestions
    String apiKey = Endpoints.googleApiKey;
    String lat = Get.find<HomeController>().latitude.value.toString();
    String long = Get.find<HomeController>().longitude.value.toString();

    try {
      isLoading.value = true;
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String components = 'country:ca';
      String request =
          '$baseURL?input=$input&location=$lat%$long&radius=500&key=$apiKey&sessiontoken=$_sessionToken&components=$components';
      // String request =
      //     '$baseURL?input=$input&location=$lat%$long&radius=500&key=$apiKey&sessiontoken=$_sessionToken';

      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        addressSugestionList.value =
            jsonDecode(response.body.toString())['predictions'];
      } else {
        throw Exception('Failed to load data');
      }
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getLatLong(String placeId) async {
    final storageService = Get.find<GetStorageService>();

    // Check the cache for the placeId
    if (storageService.locationCache.containsKey(placeId)) {
      return storageService.locationCache[placeId]!;
    }

    //if not found in cache then fetch from google api
    String placeApiKey = Endpoints.googleApiKey;
    String baseurl = 'https://maps.googleapis.com/maps/api/place';

    try {
      String request =
          '$baseurl/details/json?place_id=$placeId&key=$placeApiKey';
      var response = await http.get(Uri.parse(request));
      final geometry =
          GoogleLocationModel.fromJson(jsonDecode(response.body)).result;
      double lat = geometry?.geometry?.location?.lat ?? 0.0;
      double long = geometry?.geometry?.location?.lng ?? 0.0;
      String nameOfLocation = geometry?.formattedAddress ?? "";

      // Add the fetched data to the cache
      storageService.addToLocationCache(placeId, [lat, long, nameOfLocation]);

      return [lat, long, nameOfLocation];
    } catch (e) {
      debugPrint("getLatLong error: $e");
      throw Exception('Failed to load data');
    }
  }

  Future<void> setLocationData(String placeId) async {
    // set lat and long to origin latlong if isOrigin is true

    try {
      //? how to place this in getLatLong directly
      List<dynamic> fetchLatLong = await getLatLong(placeId);

      if (locationValues.name == LocationValues.findRideOrigin.name) {
        Get.find<FindRideController>().riderOriginLat = fetchLatLong[0];
        Get.find<FindRideController>().riderOriginLong = fetchLatLong[1];
        Get.find<FindRideController>().riderOriginTextController.text =
            fetchLatLong[2];
      } else if (locationValues.name ==
          LocationValues.findRideDestination.name) {
        Get.find<FindRideController>().riderDestinationLat = fetchLatLong[0];
        Get.find<FindRideController>().riderDestinationLong = fetchLatLong[1];
        Get.find<FindRideController>().riderDestinationTextController.text =
            fetchLatLong[2];
      }
    } catch (e) {
      log("setLocationData error: $e");
    }
    Get.back();
  }
}
